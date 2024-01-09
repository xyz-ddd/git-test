package com.oaker.hours.service.impl;

import com.baomidou.mybatisplus.enums.SqlLike;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.oaker.common.config.AppConfig;
import com.oaker.common.constant.HttpStatus;
import com.oaker.common.core.domain.entity.SysUser;
import com.oaker.common.core.domain.model.LoginUser;
import com.oaker.common.core.page.TableDataInfo;
import com.oaker.common.exception.ServiceException;
import com.oaker.common.utils.DateUtils;
import com.oaker.common.utils.FestivalsUtil;
import com.oaker.common.utils.SecurityUtils;
import com.oaker.hours.doman.columns.Columns;
import com.oaker.hours.doman.dto.*;
import com.oaker.hours.doman.entity.*;
import com.oaker.hours.doman.vo.*;
import com.oaker.hours.enums.LeaveTypeEnum;
import com.oaker.hours.enums.ProjectStatusEnum;
import com.oaker.hours.enums.UserHourFillStatusEnum;
import com.oaker.hours.mapper.MhUserHourMapper;
import com.oaker.hours.service.MhHourDetailSubService;
import com.oaker.hours.service.MhUserHourService;
import com.oaker.system.domain.SysPost;
import com.oaker.system.service.ISysUserService;
import com.oaker.system.service.SysHolidayService;
import com.oaker.system.service.impl.SysPostServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections4.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.time.temporal.TemporalAdjusters;
import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import static java.util.stream.Collectors.groupingBy;
import static java.util.stream.Collectors.toList;

/**
 * @Description :
 * <功能详细描述>
 * @author: 须尽欢_____
 * @Data : 2021/9/13 14:26
 */
@Service
@Slf4j
public class MhUserHourServiceImpl extends ServiceImpl<MhUserHourMapper, MhUserHour> implements MhUserHourService {

    @Resource
    private SysPostServiceImpl postService;

    @Resource
    private ProjectServiceImpl projectService;

    @Resource
    private MhUserLeaveServiceImpl userLeaveService;

    @Resource
    private ProjectHourServiceImpl projectHourService;

    @Resource
    private MhHourDetailSubService mhHourDetailSubService;

    @Resource
    private MhHourDetailServiceImpl hourDetailService;

    @Resource
    private ProjectUserServiceImpl projectUserService;

    @Resource
    private MhUserHourMissServiceImpl userHourMissService;

    @Resource
    private SysHolidayService sysHolidayService;

    @Resource
    private ISysUserService userService;


    /**
     * 1. 写入mh_user_hour 用户工时填报表
     * 2. 写入mh_hour_detail工时填报详情表
     * 3. 更新mh_project_hour表中已用工时
     * 4. 如果mh_user_hour_miss用户缺报记录表 有缺报记录 则执行删除
     *
     * @param userHourSaveDTO
     * @return
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public long create(UserHourSaveDTO userHourSaveDTO) {
        Long userId = SecurityUtils.getUserId();
        EntityWrapper<MhUserHour> queryWrapper = new EntityWrapper<>();
        queryWrapper.eq(Columns.MhUserHour.fillDate, userHourSaveDTO.getDate())
                .eq(Columns.MhUserHour.userId, userId);
        Integer count = baseMapper.selectCount(queryWrapper);
        if (count > 0) {
            throw new ServiceException("当前日期已经填报工时，请勿重复提交");
        }
        List<UserHourSaveDTO.ProjectHour> projectHours = userHourSaveDTO.getProjectHours();

        //如果没有开启0工时记录，则删除列表中的0工时项目
        if (!AppConfig.HOUR_ZERO) {
            projectHours.removeIf((UserHourSaveDTO.ProjectHour u)->u.getHour().equals(BigDecimal.ZERO));
        }

        BigDecimal total = projectHours.stream()
                .map(UserHourSaveDTO.ProjectHour::getHour)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
        // 工时总数判断
        if (total.compareTo(new BigDecimal("24")) > 0) {
            throw new ServiceException("工时总数不能超过24");
        }
        if (total.compareTo(AppConfig.WORK_TIME) > 0 && !AppConfig.OVERTIME_ALLOW) {
            throw new ServiceException("提交工时总数超过限定值");
        }
        LocalDate fillDate = userHourSaveDTO.getDate();
        Date createTime = new Date();
        MhUserHour userHour = new MhUserHour();
        userHour.setUserId(userId)
                .setFillDate(fillDate)
                .setTotalHour(total)
                .setCreateTime(createTime);
        // 1. 写入mh_user_hour 用户工时填报表

        baseMapper.insert(userHour);
        long insertId = userHour.getId() ;


        ProjectUser projectUser;
        MhHourDetail mhHourDetail;
        // 2. 写入mh_hour_detail工时填报详情表
        for (UserHourSaveDTO.ProjectHour projectHour : projectHours) {
            mhHourDetail = new MhHourDetail();
            MhProject mhProject = projectService.selectById(projectHour.getProjectId());
            EntityWrapper<ProjectUser> wrapper = new EntityWrapper<>();
            wrapper.eq(Columns.ProjectUser.projectId, projectHour.getProjectId())
                    .and()
                    .eq(Columns.ProjectUser.userId, userId);
            projectUser = projectUserService.selectOne(wrapper);
            mhHourDetail.setProjectId(projectHour.getProjectId())
                    .setUserId(userId)
                    .setUseHour(projectHour.getHour())
                    .setFillDate(fillDate)
                    .setProjectStatus(mhProject.getProjectStatus())
                    .setHourId(userHour.getId())
                    .setEveryday(projectUser.getEveryday())
                    .setDaily(projectHour.getDaily())
                    .setCreateTime(createTime);
            hourDetailService.insert(mhHourDetail);
            Long detailId =mhHourDetail.getId() ;
            List<ProjectSubHour> workTypeHourList = projectHour.getWorkTypeHourList();
            insertDetailSub(detailId,workTypeHourList);


            // 3. 更新mh_project_hour表中已用工时
            //   该操作迁移到事件中。
            projectHourService.addTotalHour(projectHour.getProjectId(), projectHour.getHour());
        }

        // 4. 如果mh_user_hour_miss用户缺报记录表 有缺报记录 则执行删除
        EntityWrapper<MhUserHourMiss> wrapper = new EntityWrapper<>();
        wrapper.eq(Columns.MhUserHourMiss.userId, userId)
                .eq(Columns.MhUserHourMiss.missDate, fillDate);
        MhUserHourMiss mhUserHourMiss = userHourMissService.selectOne(wrapper);
        if (!Objects.isNull(mhUserHourMiss)) {
            userHourMissService.deleteByIdAndDetail(mhUserHourMiss.getId());
        }

        return insertId;


    }

    private void insertDetailSub(Long detailId,List<ProjectSubHour> workTypeHourList){
        if(CollectionUtils.isEmpty(workTypeHourList)){
           return;
        }
        List<MhHourDetailSub> subList = new ArrayList<>();
        for(ProjectSubHour subHour:workTypeHourList){
            MhHourDetailSub sub = new MhHourDetailSub();
            sub.setDetailId(detailId);
            sub.setWorkTypeId(subHour.getWorkTypeId());
            sub.setUseHour(subHour.getHour());
            sub.setCreateTime(new Date());
            subList.add(sub);
        }
        //写入mh_hour_detail工时填报详情表字表mh_hour_detail_sub
        mhHourDetailSubService.insertBatch(subList);
    }

    @Override
    public List<UserHourListVO> queryList(LocalDate startDate, LocalDate endDate) {
        Long userId = SecurityUtils.getUserId();
        Date firstJoinTime = projectUserService.getUserFirstJoinTime(userId);
        // 如果当前用户没有加入项目 或者 加入项目查询范围内用户还没有加入项目
        if (Objects.isNull(firstJoinTime) || endDate.isBefore(DateUtils.date2LocalDate(firstJoinTime))) {
            return Collections.emptyList();
        }
        if (startDate.isBefore(DateUtils.date2LocalDate(firstJoinTime))) {
            startDate = DateUtils.date2LocalDate(firstJoinTime);
        }
        // 查询出用户所有缺报记录
        List<MhUserHourMiss> mhUserHourMisses = userHourMissService.queryUserList(userId, startDate, endDate);
        Map<LocalDate, MhUserHourMiss> missMap = new HashMap<>();
        Set<LocalDate> missDates = new HashSet<>();
        if(!CollectionUtils.isEmpty(mhUserHourMisses)){
            for(MhUserHourMiss miss:mhUserHourMisses) {
                missMap.put(miss.getMissDate(),miss);
                missDates.add(miss.getMissDate());
            }
        }

        // 查询用户所用填报记录
        EntityWrapper<MhUserHour> wrapper = new EntityWrapper<>();
        wrapper.eq(Columns.MhUserHour.userId, userId)
                .and()
                .between(Columns.MhUserHour.fillDate, startDate, endDate);
        List<MhUserHour> mhUserHours = baseMapper.selectList(wrapper);
        Map<LocalDate, MhUserHour> hourMap = mhUserHours.stream().collect(Collectors.toMap(MhUserHour::getFillDate, mhUserHour -> mhUserHour));
        Set<LocalDate> hourDates = mhUserHours.stream().map(MhUserHour::getFillDate).collect(Collectors.toSet());

        // 查询用户所有请假记录
        List<MhUserLeave> mhUserLeaves = userLeaveService.queryLeave(userId, startDate, endDate);
        Map<LocalDate, MhUserLeave> leaveMap = mhUserLeaves.stream().collect(Collectors.toMap(MhUserLeave::getLeaveDate, leave -> leave));
        Set<LocalDate> leaveDates = mhUserLeaves.stream().map(MhUserLeave::getLeaveDate).collect(Collectors.toSet());

        long between = ChronoUnit.DAYS.between(startDate, endDate);
        List<LocalDate> allDay = Stream.iterate(startDate, localDate -> localDate.plusDays(1)).limit(between + 1).collect(toList());
        UserHourListVO userHourListVO;
        LocalDate now = LocalDate.now();

        //输出当前时间
        //System.out.println("now:"+now.toString());
        List<UserHourListVO> resultList = new ArrayList<>(allDay.size());
        for (LocalDate localDate : allDay) {
            userHourListVO = new UserHourListVO();
            userHourListVO.setDate(localDate);
            System.out.println("localDate:"+localDate);
            if (localDate.isAfter(now)) {
                if (sysHolidayService.isAHoliday(localDate)) {
                    userHourListVO.setStatus(UserHourFillStatusEnum.FESTIVAL.getStatus());
                    resultList.add(userHourListVO);
                    continue;
                }
                userHourListVO.setStatus(UserHourFillStatusEnum.NO_NEED.getStatus());
                resultList.add(userHourListVO);
                continue;
            }
            if (sysHolidayService.isAHoliday(localDate) && !hourDates.contains(localDate)) {
                userHourListVO.setStatus(UserHourFillStatusEnum.FESTIVAL.getStatus());
                resultList.add(userHourListVO);
                continue;
            }
            if (hourDates.contains(localDate)) {
                MhUserHour userHour = hourMap.get(localDate);
                userHourListVO.setId(userHour.getId());

                userHourListVO.setCreateTime(userHour.getCreateTime());
                userHourListVO.setStatus(UserHourFillStatusEnum.FILLED.getStatus());
                userHourListVO.setReviewStatus(userHour.getReviewStatus());

                resultList.add(userHourListVO);
                continue;
            }
            if (leaveDates.contains(localDate)) {
                MhUserLeave leave = leaveMap.get(localDate);
                userHourListVO.setId(leave.getId());
                int leaveType = UserHourFillStatusEnum.LEAVE.getStatus();
                if (LeaveTypeEnum.OFF_DUTY.getCode() == leave.getLeaveType()) {
                    leaveType = UserHourFillStatusEnum.OFF_DUTY.getStatus();
                }
                userHourListVO.setStatus(leaveType);
                resultList.add(userHourListVO);
                continue;
            }
            if (missDates.contains(localDate)) {
                MhUserHourMiss mhUserHourMiss = missMap.get(localDate);
                userHourListVO.setId(mhUserHourMiss.getId());
                userHourListVO.setStatus(UserHourFillStatusEnum.NOT_FILLED.getStatus());
                resultList.add(userHourListVO);
                continue;
            }
            // 如果是当天
            if (now.compareTo(localDate) == 0) {
                List<UserProjectShortVO> vos = projectUserService.userProjects(userId, null, null);
                List<UserProjectShortVO> collect = vos.stream()
                        .filter(vo -> !Objects.equals(vo.getProjectStatus(), ProjectStatusEnum.COMPLETE.getCode()))
                        .collect(toList());
                if (CollectionUtils.isNotEmpty(collect)) {
                    userHourListVO.setStatus(UserHourFillStatusEnum.NOT_FILLED.getStatus());
                    resultList.add(userHourListVO);
                    continue;
                }
            }
            // 其它情况  用户空挡期 没有参与任何项目
            userHourListVO.setStatus(UserHourFillStatusEnum.NOT_FILLED.getStatus());
            System.out.println("走到这里是什么都没有计算出来，所以是no need");
            resultList.add(userHourListVO);
        }
        return resultList;
    }

    @Override
    public TableDataInfo missList(int pageNum, int pageSize) {
        TableDataInfo dataInfo = new TableDataInfo();
        Long userId = SecurityUtils.getUserId();
        EntityWrapper<MhUserHourMiss> entityWrapper = new EntityWrapper<>();
        entityWrapper.eq(Columns.MhUserHourMiss.userId, userId);
        int count = userHourMissService.selectCount(entityWrapper);
        if (count <= 0) {
            return dataInfo;
        }
        Page<MhUserHourMiss> page = new Page<>(pageNum, pageSize);
        Page<MhUserHourMiss> missPage = userHourMissService.selectPage(page, entityWrapper);
        List<MhUserHourMiss> records = missPage.getRecords();
        List<UserHourListVO> list = new ArrayList<>(records.size());
        UserHourListVO vo;
        for (MhUserHourMiss record : records) {
            vo = new UserHourListVO();
            vo.setId(record.getId())
                    .setStatus(UserHourFillStatusEnum.NOT_FILLED.getStatus())
                    .setDate(record.getMissDate());
            list.add(vo);
        }
        dataInfo.setCode(HttpStatus.SUCCESS);
        dataInfo.setTotal(count);
        dataInfo.setRows(list);
        return dataInfo;
    }

    @Override
    public List<UserHourDetailVO> queryDetail(Long hourId) {
        EntityWrapper<MhHourDetail> detailWrapper = new EntityWrapper<>();
        detailWrapper.eq(Columns.MhHourDetail.hourId, hourId);
        List<MhHourDetail> mhHourDetails = hourDetailService.selectList(detailWrapper);
        if (CollectionUtils.isEmpty(mhHourDetails)) {
            return Collections.emptyList();
        }
        UserHourDetailVO vo;
        List<UserHourDetailVO> voList = new ArrayList<>(mhHourDetails.size());
        for (MhHourDetail mhHourDetail : mhHourDetails) {
            vo = new UserHourDetailVO();
            BeanUtils.copyProperties(mhHourDetail, vo);
            MhProject mhProject = projectService.selectById(mhHourDetail.getProjectId());
            vo.setProjectName(mhProject.getProjectName());
            vo.setDaily(mhHourDetail.getDaily());
            List<UserHourDetailVO.SubHour> workTypeHourList = new ArrayList<>();
            List<MhHourDetailSub> subList = mhHourDetailSubService.findByDetailId(mhHourDetail.getId());
            if(!CollectionUtils.isEmpty(subList)){
                for(MhHourDetailSub sub:subList){
                    UserHourDetailVO.SubHour hour= new UserHourDetailVO.SubHour();
                    BeanUtils.copyProperties(sub,hour);
                    workTypeHourList.add(hour);
                }
            }else {
                UserHourDetailVO.SubHour hour = new UserHourDetailVO.SubHour();
                hour.setUserHour(vo.getUseHour());
                workTypeHourList.add(hour);
            }
            vo.setWorkTypeHourList(workTypeHourList);

            voList.add(vo);
        }
        return voList;
    }

    /**
     * 修改 mh_user_hour 用户工时填报表
     * 修改 mh_hour_detail 工时填报详情表
     * 修改 mh_project_hour 表中已用工时
     *
     * @param userHourUpdateDTO
     * @return
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean updateUserHour(UserHourUpdateDTO userHourUpdateDTO) {
        Long userId = SecurityUtils.getUserId();
        List<UserHourUpdateDTO.ProjectHourDetail> projectHours = userHourUpdateDTO.getProjectHours();
        BigDecimal total = projectHours.stream()
                .map(UserHourUpdateDTO.ProjectHourDetail::getHour)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
        MhUserHour userHour = this.selectById(userHourUpdateDTO.getHourId());

        LocalDate fillDate = userHour.getFillDate();
        // 工时总数判断
        if (total.compareTo(new BigDecimal("24")) > 0) {
            throw new ServiceException("工时总数不能超过24");
        }
        if (total.compareTo(AppConfig.WORK_TIME) > 0 && !AppConfig.OVERTIME_ALLOW) {
            throw new ServiceException("提交工时总数超过限定值");
        }

        MhUserHour newUserHour = new MhUserHour();
        newUserHour.setId(userHour.getId()).setReviewStatus(userHourUpdateDTO.getReviewStatus());
        // 如果总工时不相等更新工时填报表
        if (userHour.getTotalHour().compareTo(total) != 0) {
            newUserHour.setTotalHour(total);
        }
        this.updateById(newUserHour);

        for (UserHourUpdateDTO.ProjectHourDetail projectHour : projectHours) {
            log.info("进入到了处理每个项目任务的循环");
            log.info("projectHour:"+projectHour.toString());

            if (projectHour.getDetailId() == null){
                log.info("更新之前没有加入的项目内容");
                MhHourDetail mhHourDetail = new MhHourDetail();

                MhProject mhProject = projectService.selectById(projectHour.getProjectId());
                EntityWrapper<ProjectUser> wrapper = new EntityWrapper<>();
                wrapper.eq(Columns.ProjectUser.projectId, projectHour.getProjectId())
                        .and()
                        .eq(Columns.ProjectUser.userId, userId);
                ProjectUser projectUser = projectUserService.selectOne(wrapper);
                mhHourDetail.setProjectId(projectHour.getProjectId())
                        .setUserId(userId)
                        .setUseHour(projectHour.getHour())
                        .setFillDate(fillDate)
                        .setProjectStatus(mhProject.getProjectStatus())
                        .setHourId(userHour.getId())
                        .setEveryday(projectUser.getEveryday())
                        .setDaily(projectHour.getDaily())
                        .setCreateTime(new Date());
                hourDetailService.insert(mhHourDetail);
                Long detailId =mhHourDetail.getId() ;
                List<ProjectSubHour> workTypeHourList = projectHour.getWorkTypeHourList();

                insertDetailSub(detailId,workTypeHourList);

                // 更新总工时
                projectHourService.addTotalHour(projectHour.getProjectId(), projectHour.getHour());

            } else {
                MhHourDetail mhHourDetail = hourDetailService.selectById(projectHour.getDetailId());
                // 如果更改了数值
                if (mhHourDetail.getUseHour().compareTo(projectHour.getHour()) != 0) {
                    BigDecimal subtract = projectHour.getHour().subtract(mhHourDetail.getUseHour());
                    // 更新总工时
                    projectHourService.addTotalHour(projectHour.getProjectId(), subtract);

                    fillDate = mhHourDetail.getFillDate();
                    // 更新详情
                    mhHourDetail.setUseHour(projectHour.getHour());
                    hourDetailService.updateById(mhHourDetail);
                }
                // 如果修改了日报内容
                if (!Objects.equals(mhHourDetail.getDaily(), projectHour.getDaily())) {
                    mhHourDetail.setDaily(projectHour.getDaily());
                    hourDetailService.updateById(mhHourDetail);
                }

                //子表信息更新先删除后插入
                mhHourDetailSubService.deleteByDetailId(projectHour.getDetailId());
                List<ProjectSubHour> workTypeHourList = projectHour.getWorkTypeHourList();
                insertDetailSub(projectHour.getDetailId(),workTypeHourList);

            }

        }
        return Boolean.TRUE;
    }

    @Override
    public List<UserHourStatVO> getMyHourStat(LocalDate localDate) {
        LoginUser loginUser = SecurityUtils.getLoginUser();
        Long userId = loginUser.getUserId();
        SysUser user = loginUser.getUser();
        String nickName = user.getNickName();
        SysPost post = postService.getByUserId(userId);
        String postName = post.getPostName();
        LocalDate first = localDate.with(TemporalAdjusters.firstDayOfMonth());
        LocalDate last = localDate.with(TemporalAdjusters.lastDayOfMonth());
        EntityWrapper<MhUserHour> wrapper = new EntityWrapper<>();
        wrapper.eq(Columns.MhUserHour.userId, userId)
                .and()
                .between(Columns.MhUserHour.fillDate, first, last);
        // 填报集合
        List<MhUserHour> mhUserHours = baseMapper.selectList(wrapper);
        Map<LocalDate, List<MhUserHour>> fillMap = mhUserHours.stream().collect(groupingBy(MhUserHour::getFillDate));
        // 缺报集合
        List<MhUserHourMiss> userHourMisses = this.queryMiss(userId, first, last);
        Map<LocalDate, List<MhUserHourMiss>> missMap = userHourMisses.stream().collect(groupingBy(MhUserHourMiss::getMissDate));
        // 请假集合
        List<MhUserLeave> mhUserLeaves = this.queryLeaveNum(userId, first, last);
        Map<LocalDate, List<MhUserLeave>> leaveMap = mhUserLeaves.stream().collect(groupingBy(MhUserLeave::getLeaveDate));
        // 所有日期集合
        List<LocalDate> listDate = FestivalsUtil.interval(first, last);
        List<UserHourStatVO> list = new ArrayList<>(listDate.size());
        UserHourStatVO vo;
        LocalDate now = LocalDate.now();
        for (LocalDate date : listDate) {
            vo = new UserHourStatVO();
            vo.setDate(date)
                    .setNickName(nickName)
                    .setPostName(postName);

            if (!sysHolidayService.isWorkDay(date)) {
                System.out.println("data:" + date +  sysHolidayService.isAHoliday(date) );
                vo.setType(1);
            }
            if (fillMap.containsKey(date)) {
                MhUserHour userHour = fillMap.get(date).get(0);
                EntityWrapper<MhHourDetail> hourWrapper = new EntityWrapper<>();
                hourWrapper.eq(Columns.MhHourDetail.hourId, userHour.getId());
                List<MhHourDetail> mhHourDetails = hourDetailService.selectList(hourWrapper);
                List<UserHourStatVO.ProjectHour> projectHours = new ArrayList<>(mhHourDetails.size());
                UserHourStatVO.ProjectHour projectHour;
                for (MhHourDetail mhHourDetail : mhHourDetails) {
                    projectHour = new UserHourStatVO.ProjectHour();
                    projectHour.setProjectId(mhHourDetail.getProjectId())
                            .setProjectName(projectService.selectById(mhHourDetail.getProjectId()).getProjectName())
                            .setDaily(mhHourDetail.getDaily())
                            .setUseHour(mhHourDetail.getUseHour());
                    projectHours.add(projectHour);
                }
                vo.setStatus(UserHourFillStatusEnum.FILLED.getStatus())
                        .setId(userHour.getId())
                        .setFillTime(userHour.getCreateTime())
                        .setProjectHours(projectHours)
                        .setReviewStatus((userHour.getReviewStatus()));

                list.add(vo);
                continue;
            }
            if (!sysHolidayService.isWorkDay(date)) {
                vo.setStatus(UserHourFillStatusEnum.FESTIVAL.getStatus());
                list.add(vo);
                continue;
            }

            if (missMap.containsKey(date)) {
                MhUserHourMiss miss = missMap.get(date).get(0);
                vo.setStatus(UserHourFillStatusEnum.NOT_FILLED.getStatus())
                        .setId(miss.getId());
                list.add(vo);
                continue;
            }
            if (leaveMap.containsKey(date)) {
                MhUserLeave leave = leaveMap.get(date).get(0);
                int status = UserHourFillStatusEnum.getCodeByLeaveType(leave.getLeaveType());
                vo.setStatus(status)
                        .setId(leave.getId());
                list.add(vo);
                continue;
            }
            // 如果是当天
            if (now.compareTo(date) == 0) {
                List<UserProjectShortVO> projects = projectUserService.queryMyProject(userId, new Date());
                List<UserProjectShortVO> collect = projects.stream()
                        .filter(project -> !Objects.equals(project.getProjectStatus(), ProjectStatusEnum.COMPLETE.getCode()))
                        .collect(toList());
                if (!CollectionUtils.isEmpty(collect)) {
                    vo.setStatus(UserHourFillStatusEnum.NOT_FILLED.getStatus());
                    list.add(vo);
                    continue;
                }
            }
            vo.setStatus(UserHourFillStatusEnum.NO_NEED.getStatus());
            list.add(vo);
        }
        return list;
    }

    private List<MhUserHour> queryUserHourInfo(Long userId, LocalDate first, LocalDate last) {
        EntityWrapper<MhUserHour> wrapper = new EntityWrapper<>();
        wrapper.eq(Columns.MhUserHour.userId, userId)
                .and()
                .between(Columns.MhUserHour.fillDate, first, last);
        return baseMapper.selectList(wrapper);
    }

    private List<MhUserHourMiss> queryMiss(Long userId, LocalDate first, LocalDate last) {
        EntityWrapper<MhUserHourMiss> wrapper = new EntityWrapper<>();
        wrapper.eq(Columns.MhUserHour.userId, userId)
                .and()
                .between(Columns.MhUserHourMiss.missDate, first, last);
        return userHourMissService.selectList(wrapper);
    }

    private List<MhUserLeave> queryLeaveNum(Long userId, LocalDate first, LocalDate last) {
        EntityWrapper<MhUserLeave> wrapper = new EntityWrapper<>();
        wrapper.eq(Columns.MhUserHour.userId, userId)
                .and()
                .between(Columns.MhUserLeave.leaveDate, first, last);
        return userLeaveService.selectList(wrapper);
    }

    @Override
    public List<UserHourProjectStat> queryUserHourProjectStat(LocalDate localDate) {
        Long userId = SecurityUtils.getUserId();
        LocalDate first = localDate.with(TemporalAdjusters.firstDayOfMonth());
        LocalDate last = localDate.with(TemporalAdjusters.lastDayOfMonth());
        List<MhHourDetail> mhHourDetails = this.queryUserHourDetailInfo(userId, first, last);
        // 项目工时详情
        Map<Long, List<MhHourDetail>> collect = mhHourDetails.stream()
                .collect(groupingBy(MhHourDetail::getProjectId));
        List<UserHourProjectStat> projectHourList = new ArrayList<>();
        collect.forEach((projectId, list) -> {
            UserHourProjectStat projectHour = new UserHourProjectStat();
            projectHour.setProjectId(projectId);
            MhProject mhProject = projectService.selectById(projectId);
            //projectHour.setProjectName(mhProject.getProjectName());
            projectHour.setProjectName(mhProject.getProjectName() != null ?mhProject.getProjectName():"");

            BigDecimal totalUse = list.stream().map(MhHourDetail::getUseHour).reduce(BigDecimal.ZERO, BigDecimal::add);
            projectHour.setUseHour(totalUse);
            projectHourList.add(projectHour);
        });
        return projectHourList;
    }

    private List<MhHourDetail> queryUserHourDetailInfo(Long userId, LocalDate first, LocalDate last) {
        EntityWrapper<MhHourDetail> wrapper = new EntityWrapper<>();
        wrapper.eq(Columns.MhUserHour.userId, userId)
                .and()
                .between(Columns.MhUserHour.fillDate, first, last);
        return hourDetailService.selectList(wrapper);
    }

    @Override
    public UserHourExportVO userHourExport(LocalDate localDate, Long projectId) {
        Long userId = SecurityUtils.getUserId();
        LocalDate first = localDate.with(TemporalAdjusters.firstDayOfMonth());
        LocalDate last = localDate.with(TemporalAdjusters.lastDayOfMonth());
        EntityWrapper<MhHourDetail> wrapper = new EntityWrapper<>();
        wrapper.eq(Columns.MhHourDetail.projectId, projectId)
                .and()
                .eq(Columns.MhHourDetail.userId, userId)
                .and()
                .between(Columns.MhHourDetail.fillDate, first, last);
        // 填报集合
        List<MhHourDetail> mhHourDetails = hourDetailService.selectList(wrapper);
        Map<LocalDate, List<MhHourDetail>> fillMap = mhHourDetails.stream().collect(groupingBy(MhHourDetail::getFillDate));
        // 缺报集合
        List<MhUserHourMiss> userHourMisses = this.queryMiss(userId, first, last);
        Set<LocalDate> missSet = userHourMisses.stream().map(MhUserHourMiss::getMissDate).collect(Collectors.toSet());
        // 请假集合
        List<MhUserLeave> mhUserLeaves = this.queryLeaveNum(userId, first, last);
        Map<LocalDate, List<MhUserLeave>> leaveMap = mhUserLeaves.stream().collect(groupingBy(MhUserLeave::getLeaveDate));
        // 所有日期集合
        List<LocalDate> listDate = FestivalsUtil.interval(first, last);
        List<UserHourExportVO.FillInfo> list = new ArrayList<>(listDate.size());
        UserHourExportVO.FillInfo fillInfo;
        for (LocalDate date : listDate) {
            fillInfo = new UserHourExportVO.FillInfo();
            fillInfo.setDate(date);
            if (fillMap.containsKey(date)) {
                MhHourDetail mhHourDetail = fillMap.get(date).get(0);
                fillInfo.setUseHour(mhHourDetail.getUseHour())
                        .setStatus(UserHourFillStatusEnum.FILLED.getStatus())
                        .setDaily(mhHourDetail.getDaily())
                        .setFillTime(mhHourDetail.getCreateTime());
                list.add(fillInfo);
                continue;
            }
            if (!sysHolidayService.isWorkDay(date)) {
                fillInfo.setStatus(UserHourFillStatusEnum.FESTIVAL.getStatus());
                list.add(fillInfo);
                continue;
            }
            if (missSet.contains(date)) {
                fillInfo.setStatus(UserHourFillStatusEnum.NOT_FILLED.getStatus());
                list.add(fillInfo);
                continue;
            }
            if (leaveMap.containsKey(date)) {
                int leaveType = leaveMap.get(date).get(0).getLeaveType();
                int status = UserHourFillStatusEnum.getCodeByLeaveType(leaveType);
                fillInfo.setStatus(status);
                list.add(fillInfo);
                continue;
            }
            // 如果是当天
            if (LocalDate.now().compareTo(date) == 0) {
                List<UserProjectShortVO> projects = projectUserService.queryMyProject(userId, new Date());
                List<UserProjectShortVO> collect = projects.stream()
                        .filter(project -> !Objects.equals(project.getProjectStatus(), ProjectStatusEnum.COMPLETE.getCode()))
                        .collect(toList());
                if (!CollectionUtils.isEmpty(collect)) {
                    fillInfo.setStatus(UserHourFillStatusEnum.NOT_FILLED.getStatus());
                    list.add(fillInfo);
                    continue;
                }
            }
            fillInfo.setStatus(UserHourFillStatusEnum.NO_NEED.getStatus());
            list.add(fillInfo);
        }
        SysPost post = postService.getByUserId(userId);
        MhProject mhProject = projectService.selectById(projectId);
        String nickName = SecurityUtils.getLoginUser().getUser().getNickName();
        UserHourExportVO hourExportVO = new UserHourExportVO();
        hourExportVO.setProjectId(projectId)
                .setProjectName(mhProject.getProjectName())
                .setPostName(post.getPostName())
                .setNickName(nickName)
                .setFillInfos(list);
        return hourExportVO;
    }

    public UserHourExportVO userHourExport(LocalDate localDate, Long projectId,Long userId) {
        //Long userId = SecurityUtils.getUserId();

        log.info("接收到的userid是："+userId);
        LocalDate first = localDate.with(TemporalAdjusters.firstDayOfMonth());
        LocalDate last = localDate.with(TemporalAdjusters.lastDayOfMonth());
        EntityWrapper<MhHourDetail> wrapper = new EntityWrapper<>();
        wrapper.eq(Columns.MhHourDetail.projectId, projectId)
                .and()
                .eq(Columns.MhHourDetail.userId, userId)
                .and()
                .between(Columns.MhHourDetail.fillDate, first, last);
        // 填报集合
        List<MhHourDetail> mhHourDetails = hourDetailService.selectList(wrapper);
        Map<LocalDate, List<MhHourDetail>> fillMap = mhHourDetails.stream().collect(groupingBy(MhHourDetail::getFillDate));
        // 缺报集合
        List<MhUserHourMiss> userHourMisses = this.queryMiss(userId, first, last);
        Set<LocalDate> missSet = userHourMisses.stream().map(MhUserHourMiss::getMissDate).collect(Collectors.toSet());
        // 请假集合
        List<MhUserLeave> mhUserLeaves = this.queryLeaveNum(userId, first, last);
        Map<LocalDate, List<MhUserLeave>> leaveMap = mhUserLeaves.stream().collect(groupingBy(MhUserLeave::getLeaveDate));
        // 所有日期集合
        List<LocalDate> listDate = FestivalsUtil.interval(first, last);
        List<UserHourExportVO.FillInfo> list = new ArrayList<>(listDate.size());
        UserHourExportVO.FillInfo fillInfo;
        for (LocalDate date : listDate) {
            fillInfo = new UserHourExportVO.FillInfo();
            fillInfo.setDate(date);
            if (fillMap.containsKey(date)) {
                MhHourDetail mhHourDetail = fillMap.get(date).get(0);
                fillInfo.setUseHour(mhHourDetail.getUseHour())
                        .setStatus(UserHourFillStatusEnum.FILLED.getStatus())
                        .setDaily(mhHourDetail.getDaily())
                        .setFillTime(mhHourDetail.getCreateTime());
                list.add(fillInfo);
                continue;
            }
            if (!sysHolidayService.isWorkDay(date)) {
                fillInfo.setStatus(UserHourFillStatusEnum.FESTIVAL.getStatus());
                list.add(fillInfo);
                continue;
            }
            if (missSet.contains(date)) {
                fillInfo.setStatus(UserHourFillStatusEnum.NOT_FILLED.getStatus());
                list.add(fillInfo);
                continue;
            }
            if (leaveMap.containsKey(date)) {
                int leaveType = leaveMap.get(date).get(0).getLeaveType();
                int status = UserHourFillStatusEnum.getCodeByLeaveType(leaveType);
                fillInfo.setStatus(status);
                list.add(fillInfo);
                continue;
            }
            // 如果是当天
            if (LocalDate.now().compareTo(date) == 0) {
                List<UserProjectShortVO> projects = projectUserService.queryMyProject(userId, new Date());
                List<UserProjectShortVO> collect = projects.stream()
                        .filter(project -> !Objects.equals(project.getProjectStatus(), ProjectStatusEnum.COMPLETE.getCode()))
                        .collect(toList());
                if (!CollectionUtils.isEmpty(collect)) {
                    fillInfo.setStatus(UserHourFillStatusEnum.NOT_FILLED.getStatus());
                    list.add(fillInfo);
                    continue;
                }
            }
            fillInfo.setStatus(UserHourFillStatusEnum.NO_NEED.getStatus());
            list.add(fillInfo);
        }
        SysPost post = postService.getByUserId(userId);
        MhProject mhProject = projectService.selectById(projectId);
        // String nickName = SecurityUtils.getLoginUser().getUser().getNickName();

        SysUser sysUser = userService.selectUserById(userId);
        String nickName = sysUser.getNickName();

        UserHourExportVO hourExportVO = new UserHourExportVO();
        hourExportVO.setProjectId(projectId)
                .setProjectName(mhProject.getProjectName())
                .setPostName(post.getPostName())
                .setNickName(nickName)
                .setFillInfos(list);
        return hourExportVO;
    }














    @Override
    public List<UserHourCalendarVO> queryUserHourCalendar(LocalDate localDate) {
        Long userId = SecurityUtils.getUserId();
        LocalDate first = localDate.with(TemporalAdjusters.firstDayOfMonth());
        LocalDate last = localDate.with(TemporalAdjusters.lastDayOfMonth());
        EntityWrapper<MhUserHour> wrapper = new EntityWrapper<>();
        wrapper.eq(Columns.MhUserHour.userId, userId)
                .and()
                .between(Columns.MhUserHour.fillDate, first, last);
        // 填报集合
        List<MhUserHour> mhUserHours = baseMapper.selectList(wrapper);
        Map<LocalDate, List<MhUserHour>> fillMap = mhUserHours.stream().collect(groupingBy(MhUserHour::getFillDate));
        // 缺报集合
        List<MhUserHourMiss> userHourMisses = this.queryMiss(userId, first, last);
        Map<LocalDate, List<MhUserHourMiss>> missMap = userHourMisses.stream().collect(groupingBy(MhUserHourMiss::getMissDate));
        // 请假集合
        List<MhUserLeave> mhUserLeaves = this.queryLeaveNum(userId, first, last);
        Map<LocalDate, List<MhUserLeave>> leaveMap = mhUserLeaves.stream().collect(groupingBy(MhUserLeave::getLeaveDate));
        List<LocalDate> listDate = FestivalsUtil.interval(first, last);
        List<UserHourCalendarVO> list = new ArrayList<>(listDate.size());
        UserHourCalendarVO vo;
        LocalDate now = LocalDate.now();
        for (LocalDate date : listDate) {
            vo = new UserHourCalendarVO();
            vo.setDate(date);
            if (fillMap.containsKey(date)) {
                BigDecimal hour = fillMap.get(date).stream().map(MhUserHour::getTotalHour)
                        .reduce(BigDecimal.ZERO, BigDecimal::add);
                vo.setStatus(UserHourFillStatusEnum.FILLED.getStatus())
                        .setHour(hour)
                        .setId(fillMap.get(date).get(0).getId());
                list.add(vo);
                continue;
            }
            if (!sysHolidayService.isWorkDay(date)) {
                vo.setStatus(UserHourFillStatusEnum.FESTIVAL.getStatus());
                list.add(vo);
                continue;
            }
            if (missMap.containsKey(date)) {
                vo.setStatus(UserHourFillStatusEnum.NOT_FILLED.getStatus())
                        .setId(missMap.get(date).get(0).getId());
                list.add(vo);
                continue;
            }
            if (leaveMap.containsKey(date)) {
                MhUserLeave leave = leaveMap.get(date).get(0);
                int leaveType = leave.getLeaveType();
                int status = UserHourFillStatusEnum.getCodeByLeaveType(leaveType);
                vo.setStatus(status)
                        .setId(leave.getId());
                list.add(vo);
                continue;
            }
            // 如果是当天
            if (now.compareTo(date) == 0) {
                List<UserProjectShortVO> projects = projectUserService.queryMyProject(userId, new Date());
                List<UserProjectShortVO> collect = projects.stream()
                        .filter(project -> !Objects.equals(project.getProjectStatus(), ProjectStatusEnum.COMPLETE.getCode()))
                        .collect(toList());
                if (!CollectionUtils.isEmpty(collect)) {
                    vo.setStatus(UserHourFillStatusEnum.NOT_FILLED.getStatus());
                    list.add(vo);
                    continue;
                }
            }
            vo.setStatus(UserHourFillStatusEnum.NO_NEED.getStatus());
            list.add(vo);
        }
        return list;
    }

    @Override
    public TableDataInfo queryMyHourStatDetail(LocalDate localDate, int pageNum, int pageSize) {
        TableDataInfo dataInfo = new TableDataInfo();
        Long userId = SecurityUtils.getUserId();
        Date firstJoinTime = projectUserService.getUserFirstJoinTime(userId);
        LocalDate startDate = localDate.with(TemporalAdjusters.firstDayOfMonth());
        LocalDate endDate = localDate.with(TemporalAdjusters.lastDayOfMonth());
        // 如果当前用户没有加入项目 或者 加入项目查询范围内用户还没有加入项目
        if (Objects.isNull(firstJoinTime) || endDate.isBefore(DateUtils.date2LocalDate(firstJoinTime))) {
            return dataInfo;
        }
        if (startDate.isBefore(DateUtils.date2LocalDate(firstJoinTime))) {
            startDate = DateUtils.date2LocalDate(firstJoinTime);
        }
        EntityWrapper<MhHourDetail> detailWrapper = new EntityWrapper<>();
        detailWrapper.eq(Columns.MhHourDetail.userId, userId)
                .and()
                .between(Columns.MhHourDetail.fillDate, startDate, endDate);
        int count = hourDetailService.selectCount(detailWrapper);
        if (count <= 0) {
            return dataInfo;
        }
        Page<MhHourDetail> page = new Page<>(pageNum, pageSize);
        Page<MhHourDetail> detailPage = hourDetailService.selectPage(page, detailWrapper);
        List<MhHourDetail> records = detailPage.getRecords();
        List<UserHourStatDetailVO> list = new ArrayList<>(records.size());
        MhProject mhProject;
        UserHourStatDetailVO vo;
        SysPost post = postService.getByUserId(userId);
        String nickName = SecurityUtils.getLoginUser().getUser().getNickName();
        for (MhHourDetail record : records) {
            vo = new UserHourStatDetailVO();
            mhProject = projectService.selectById(record.getProjectId());
            vo.setId(record.getId())
                    .setProjectId(record.getProjectId())
                    .setEveryday(record.getEveryday())
                    .setFillDate(record.getFillDate())
                    .setProjectStatus(ProjectStatusEnum.getDescByCode(record.getProjectStatus()))
                    .setUseHour(record.getUseHour())
                    .setCreateTime(record.getCreateTime())
                    .setPostName(post.getPostName())
                    .setNickName(nickName)
                    .setProjectName(mhProject.getProjectName());
            list.add(vo);
        }
        dataInfo.setTotal(count);
        dataInfo.setCode(HttpStatus.SUCCESS);
        dataInfo.setRows(list);
        return dataInfo;
    }

    @Override
    public List<MhHourDetail> queryFillByProject(Long projectId, LocalDate date) {
        EntityWrapper<MhHourDetail> wrapper = new EntityWrapper<>();
        wrapper.eq(Columns.MhHourDetail.projectId, projectId)
                .and()
                .eq(Columns.MhHourDetail.fillDate, date);
        return hourDetailService.selectList(wrapper);
    }

    @Override
    public List<MhHourDetail> queryProjectUserHour(Long projectId, LocalDate date) {
        EntityWrapper<MhHourDetail> wrapper = new EntityWrapper<>();
        wrapper.eq(Columns.MhHourDetail.projectId, projectId);
        if (!Objects.isNull(date)) {
            wrapper.eq(Columns.MhHourDetail.fillDate, date);
        }
        return hourDetailService.selectList(wrapper);
    }

    @Override
    public List<MhHourDetail> queryProjectUserHourMonth(Long projectId, String yearMonth) {
        EntityWrapper<MhHourDetail> wrapper = new EntityWrapper<>();
        wrapper.eq(Columns.MhHourDetail.projectId, projectId);
        if (StringUtils.isNotBlank(yearMonth)) {
            wrapper.like(Columns.MhHourDetail.fillDate, yearMonth, SqlLike.RIGHT);
        }
        return hourDetailService.selectList(wrapper);
    }

    @Override
    public int countProjectMonthUserDetail(ProjectHourStatMonthDetailDTO monthDetailDTO) {
        return baseMapper.countProjectMonthUserDetail(monthDetailDTO);
    }

    @Override
    public List<ProjectHourStatMonthDetail> queryProjectMonthUserDetail(ProjectHourStatMonthDetailDTO monthDetailDTO, int pageStart, int pageSize) {
        return baseMapper.queryProjectMonthUserDetail(monthDetailDTO, pageStart, pageSize);
    }

    @Override
    public MhUserHour getByUserId(Long userId, LocalDate localDate) {
        MhUserHour userHour = new MhUserHour();
        userHour.setUserId(userId);
        userHour.setFillDate(localDate);
        return baseMapper.selectOne(userHour);
    }

    @Override
    public int getMonthFill(Long userId, LocalDate localDate) {
        LocalDate first = localDate.with(TemporalAdjusters.firstDayOfMonth());
        LocalDate last = localDate.with(TemporalAdjusters.lastDayOfMonth());
        // 上报天数
        List<MhUserHour> mhUserHours = this.queryUserHourInfo(userId, first, last);
        return mhUserHours.size();
    }

    @Override
    public int getMonthMissFill(Long userId, LocalDate localDate) {
        LocalDate first = localDate.with(TemporalAdjusters.firstDayOfMonth());
        LocalDate last = localDate.with(TemporalAdjusters.lastDayOfMonth());
        List<MhUserHourMiss> hourMisses = this.queryMiss(userId, first, last);
        return hourMisses.size();
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean userLeave(LocalDate leaveDate, int leaveType) {
        boolean result = userLeaveService.create(leaveDate, leaveType);
        userHourMissService.deleteMiss(leaveDate);
        return result;
    }

    @Override
    public boolean unLeave(Long id) {
        Long userId = SecurityUtils.getUserId();
        MhUserLeave leave = userLeaveService.selectById(id);
        if (!Objects.equals(userId, leave.getUserId())) {
            throw new ServiceException("只能本人取消请假/调休");
        }
        return userLeaveService.unLeave(id);
    }

    @Override
    public List<MhHourDetail> queryProjectFillDetail(Long projectId, LocalDate localDate) {
        EntityWrapper<MhHourDetail> wrapper = new EntityWrapper<>();
        wrapper.eq(Columns.MhHourDetail.projectId, projectId)
                .and()
                .eq(Columns.MhHourDetail.fillDate, localDate);
        return hourDetailService.selectList(wrapper);
    }

    @Override
    public List<UserProjectShortVO> queryMyMissProject(Long missId) {
        return userHourMissService.queryMyMissProject(missId);
    }

    public int queryUserTotal(Long userid) {
        //  return  mhUserHourService.countUserHour(userId);
        return  baseMapper.countUserHour(userid);

    }


    public List<LocalDate> queryUserHourDayList(Long userid) {
        baseMapper.countUserHour(userid);;

        return null;
    }

    public TableDataInfo queryUserDataStat(UserDataStatDTO detailDTO, int pageStart, int pageSize) {
        TableDataInfo dataInfo = new TableDataInfo();
        Long userid =  detailDTO.getUserId();

        int count = this.queryUserTotal(detailDTO.getUserId());

        if (count <=0) {
            return dataInfo;
        }


        //查询填报列表
        List<LocalDate> dateList = baseMapper.queryUserHourDayList(detailDTO.getUserId());


        //创建月份列表
        List<String> monthList = new ArrayList<>();

        //创建table row
        List<UserDataStatVO> userDataStatVOList = new ArrayList<>();

        DateTimeFormatter dtf3 = DateTimeFormatter.ofPattern("yyyy-MM");

        DateTimeFormatter fmt1 = DateTimeFormatter.ofPattern("yyyy-MM-dd");


        for (int i=0;i< dateList.size();i++) {
            LocalDate  currentDate = dateList.get(i);
            String currentMonth = currentDate.format(dtf3);

            if (!monthList.contains(currentMonth)){
                monthList.add(currentMonth);
            }
        }

        //log.info("月份列表"+monthList.toString());

        for ( String month:monthList){
            LocalDate date2 = LocalDate.parse(month +"-01", fmt1);

            // log.info("date2:"+date2);

            UserDataStatVO  uds= new UserDataStatVO();
            uds.setMonth(month);

            //获取当月应报总数
            uds.setMonthTotal(sysHolidayService.getMonthWorkDayCount(date2));

            //int c =  sysHolidayService.getMonthWorkDayCount(date2);
            //uds.setMonthTotal(c);

            //log.info("应报总数："+uds.getMonthTotal());
            //获取用户当月填报总数
            uds.setFillTotal(this.getMonthFill(userid,date2));

            //获取用户当月缺报总数
            //uds.setMissFillTotal(this.getMonthMissFill(userid,date2));


            //获取用户加班总数
            uds.setOvertimeTotal(this.getMonthOver(userid,date2));

            //获取用户请假总数
            uds.setLeaveTotal(this.getMonthLeave(userid,date2));

            //获取用户调休总数
            uds.setPaidLeaveTotal(this.getMonthPaid(userid,date2));

            userDataStatVOList.add(uds);
        }

        //设置data倒序

        Collections.reverse(userDataStatVOList);

        dataInfo.setTotal(count);
        dataInfo.setRows(userDataStatVOList);
        dataInfo.setCode(HttpStatus.SUCCESS);

        return dataInfo;
    }

    public List<UserDataStatVO> queryUserDataStat(Long userId,String localMonth) {
        //创建月份列表
        List<String> monthList = new ArrayList<>();
        List<UserDataStatVO> userDataStatVOList = new ArrayList<>();
        DateTimeFormatter dtf3 = DateTimeFormatter.ofPattern("yyyy-MM");
        DateTimeFormatter fmt1 = DateTimeFormatter.ofPattern("yyyy-MM-dd");

        if (localMonth !=null) {
            monthList.add(localMonth);
        }else {
            //查询填报列表
            List<LocalDate> dateList = new ArrayList<>();
            dateList = baseMapper.queryUserHourDayList(userId);

            for (int i=0;i< dateList.size();i++) {
                LocalDate  currentDate = dateList.get(i);
                String currentMonth = currentDate.format(dtf3);
                if (!monthList.contains(currentMonth)){
                    monthList.add(currentMonth);
                }
            }

        }

        for ( String month:monthList){
            LocalDate date2 = LocalDate.parse(month +"-01", fmt1);
            // log.info("date2:"+date2);
            UserDataStatVO  uds= new UserDataStatVO();
            uds.setMonth(month);

            //获取当月应报总数
            uds.setMonthTotal(sysHolidayService.getMonthWorkDayCount(date2));

            //int c =  sysHolidayService.getMonthWorkDayCount(date2);
            //uds.setMonthTotal(c);

            //log.info("应报总数："+uds.getMonthTotal());
            //获取用户当月填报总数
            uds.setFillTotal(this.getMonthFill(userId,date2));

            //获取用户当月缺报总数
            //uds.setMissFillTotal(this.getMonthMissFill(userid,date2));


            //获取用户加班总数
            uds.setOvertimeTotal(this.getMonthOver(userId,date2));

            //获取用户请假总数
            uds.setLeaveTotal(this.getMonthLeave(userId,date2));

            //获取用户调休总数
            uds.setPaidLeaveTotal(this.getMonthPaid(userId,date2));

            userDataStatVOList.add(uds);
        }

        //设置data倒序
        Collections.reverse(userDataStatVOList);

        return userDataStatVOList;
    }

    public int getMonthLeave(Long userId, LocalDate localDate) {
        LocalDate first = localDate.with(TemporalAdjusters.firstDayOfMonth());
        LocalDate last = localDate.with(TemporalAdjusters.lastDayOfMonth());
        List<MhUserLeave> mhUserLeaves = this.queryLeaveNumNotPaid(userId, first, last);
        return mhUserLeaves.size();
    }

    public int getMonthOver(Long userId, LocalDate localDate) {
        LocalDate first = localDate.with(TemporalAdjusters.firstDayOfMonth());
        LocalDate last = localDate.with(TemporalAdjusters.lastDayOfMonth());
        EntityWrapper<MhUserHour> wrapper = new EntityWrapper<>();
        wrapper.eq(Columns.MhUserHour.userId, userId)
                .and()
                .between(Columns.MhUserHour.fillDate, first, last);
        List<MhUserHour> mhUserHours = baseMapper.selectList(wrapper);

        List<MhUserHour> collect = mhUserHours.stream().filter((MhUserHour uh) -> sysHolidayService.isAHoliday(uh.getFillDate())).collect(toList());
        return collect.size();
    }

    public int getMonthPaid(Long userId, LocalDate localDate) {
        LocalDate first = localDate.with(TemporalAdjusters.firstDayOfMonth());
        LocalDate last = localDate.with(TemporalAdjusters.lastDayOfMonth());
        List<MhUserLeave> mhUserLeaves = this.queryPaidNum(userId, first, last);

        return mhUserLeaves.size();
    }

    // 查询用户的倒休记录
    private List<MhUserLeave> queryPaidNum(Long userId, LocalDate first, LocalDate last) {
        EntityWrapper<MhUserLeave> wrapper = new EntityWrapper<>();
        wrapper.eq(Columns.MhUserHour.userId, userId)
                .and()
                .eq(Columns.MhUserLeave.leaveType,2)
                .and()
                .between(Columns.MhUserLeave.leaveDate, first, last);
        return userLeaveService.selectList(wrapper);
    }



    // 查询用户的请假记录（不包括倒休）
    private List<MhUserLeave> queryLeaveNumNotPaid(Long userId, LocalDate first, LocalDate last) {

        EntityWrapper<MhUserLeave> wrapper = new EntityWrapper<>();
        wrapper.eq(Columns.MhUserHour.userId, userId)
                .and()
                .eq(Columns.MhUserLeave.leaveType,1)
                .and()
                .between(Columns.MhUserLeave.leaveDate, first, last);
        return userLeaveService.selectList(wrapper);
    }
}
