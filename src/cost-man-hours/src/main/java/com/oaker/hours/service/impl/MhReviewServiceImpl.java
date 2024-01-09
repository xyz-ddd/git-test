package com.oaker.hours.service.impl;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.oaker.common.config.AppConfig;
import com.oaker.common.core.domain.entity.SysUser;
import com.oaker.hours.config.CostConfig;
import com.oaker.hours.doman.columns.Columns;
import com.oaker.hours.doman.dto.MhReviewDTO;
import com.oaker.hours.doman.dto.ProjectSubHour;
import com.oaker.hours.doman.dto.UserHourSaveDTO;
import com.oaker.hours.doman.entity.MhUserHour;
import com.oaker.hours.doman.vo.UserHourDetailVO;
import com.oaker.hours.doman.vo.UserHourReviewVO;
import com.oaker.hours.mapper.MhUserHourMapper;
import com.oaker.hours.service.MhReviewService;
import com.oaker.system.domain.SysPost;
import com.oaker.system.service.ISysUserService;
import com.oaker.system.service.SysHolidayService;
import com.oaker.system.service.impl.SysPostServiceImpl;
import org.apache.commons.collections4.CollectionUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;


@Service
public class MhReviewServiceImpl  extends ServiceImpl<MhUserHourMapper, MhUserHour> implements MhReviewService {

    @Autowired
    private ISysUserService userService;
    @Resource
    private MhCostServiceImpl mhCostService;
    @Resource
    private MhUserHourServiceImpl userHourService;

    @Resource
    private SysPostServiceImpl postService;

    @Resource
    private ProjectServiceImpl projectService;

    @Resource
    private SysHolidayService sysHolidayService;


    @Override
    public void setReview(long resultId,UserHourSaveDTO userHourSaveDTO) {

        MhUserHour mhUserHour =  new MhUserHour();
        mhUserHour.setId(resultId);
        //如果没有开启审核
        if (!AppConfig.WORK_REVIEWS) {
            if (CostConfig.POST_COST || CostConfig.USER_COST) {
                mhCostService.create(userHourSaveDTO);
            }
        } else {
            //如果开启审核
            mhUserHour.setReviewStatus(1);
        }
        baseMapper.updateById(mhUserHour);
    }


    public  boolean  rejectReview(Long hourId) {
        MhUserHour mhUserHour =  new MhUserHour();
        mhUserHour.setId(hourId);
        mhUserHour.setReviewStatus(-1);
        Integer res = baseMapper.updateById(mhUserHour);
        if (res != 1)  {
            return  false;
        }
        return  true;
    }


    public  boolean auditReview(Long hourId){
        MhUserHour mhUserHour = baseMapper.selectById(hourId);
        mhUserHour.setId(hourId);
        mhUserHour.setReviewStatus(2);
        baseMapper.updateById(mhUserHour);

        if (CostConfig.POST_COST || CostConfig.USER_COST) {
            UserHourSaveDTO    userHourSaveDTO = new UserHourSaveDTO();
            List<UserHourSaveDTO.ProjectHour> projectHours = new ArrayList<>();
            //查询已经填报记录
            List<UserHourDetailVO> userHourlist = userHourService.queryDetail(hourId);
            for (UserHourDetailVO userHourDetailVO : userHourlist) {
                UserHourSaveDTO.ProjectHour projectHour = new UserHourSaveDTO.ProjectHour();
                projectHour.setProjectId(userHourDetailVO.getProjectId());
                projectHour.setHour(userHourDetailVO.getUseHour());
                projectHour.setDaily(userHourDetailVO.getDaily());
                if(userHourSaveDTO.getDate() ==null) {
                    userHourSaveDTO.setDate(userHourDetailVO.getFillDate());
                }
                List<ProjectSubHour> targetList  = new ArrayList<>();
                List<UserHourDetailVO.SubHour> workTypeHourList = userHourDetailVO.getWorkTypeHourList();
                for (UserHourDetailVO.SubHour  subHour: workTypeHourList) {

                    if (subHour.getUserHour() ==null ||subHour.getUserHour().compareTo(BigDecimal.ZERO)==0) {
                        break; }
                    ProjectSubHour projectSubHour = new ProjectSubHour();
                    projectSubHour.setHour(subHour.getUserHour());
                    projectSubHour.setWorkTypeId(subHour.getWorkTypeId());

                    targetList.add(projectSubHour);
                }
                projectHour.setWorkTypeHourList(targetList);
            }
            userHourSaveDTO.setProjectHours(projectHours);
            System.out.println("uhsdto"+userHourSaveDTO);
            boolean b = mhCostService.create(userHourSaveDTO);
            return  b;

        }
        return true;
    }

    @Override
    public List<UserHourReviewVO> query(MhReviewDTO mhReviewDTO, LocalDate localDate) {
        List<UserHourReviewVO> voList = new ArrayList<>();
        List<SysUser> userList = userService.selectUserList(mhReviewDTO);
        if (CollectionUtils.isEmpty(userList)) {
            return voList;
        }
        userList.forEach(sysUser -> {
            Long userId = sysUser.getUserId();
            Long postId = postService.selectPostListByUserId(userId);
            EntityWrapper<MhUserHour> wrapper = new EntityWrapper<>();
            if (localDate !=null) {
                wrapper.eq(Columns.MhUserHour.fillDate, localDate);
            }
            if (mhReviewDTO.getReviewStatus() !=null) {
                wrapper.eq(Columns.MhUserHour.reviewStatus, mhReviewDTO.getReviewStatus());
            }
            wrapper.eq(Columns.MhUserHour.userId,userId);
            List<MhUserHour> mhUserHoursList = userHourService.selectList(wrapper);
            for (MhUserHour mhHours: mhUserHoursList) {
                UserHourReviewVO userHourReviewVO = new UserHourReviewVO();
                BeanUtils.copyProperties(mhHours,userHourReviewVO);
                if (!Objects.isNull(postId)) {
                    SysPost sysPost = postService.selectPostById(postId);
                    userHourReviewVO.setPostName(sysPost.getPostName());
                }
                userHourReviewVO.setUserName(sysUser.getUserName());
                userHourReviewVO.setNickName(sysUser.getNickName());
                userHourReviewVO.setDayType(sysHolidayService.isAHoliday(mhHours.getFillDate())?0:1);
                userHourReviewVO.setFillTime(mhHours.getCreateTime());
                voList.add(userHourReviewVO);
            }
        });
        //	numList = numList.stream().sorted(Comparator.comparing(User::getAge).reversed()).collect(Collectors.toList());
        List<UserHourReviewVO> collect = voList.stream().sorted(Comparator.comparing(UserHourReviewVO::getFillDate).reversed()).collect(Collectors.toList());
        return collect;

    }


    public  UserHourReviewVO queryById (int postId) {
        UserHourReviewVO userHourReviewVO = new UserHourReviewVO();

        MhUserHour mhUserHour = userHourService.selectById(postId);

        Long userId = mhUserHour.getUserId();

        SysUser sysUser = userService.selectUserById(userId);
        BeanUtils.copyProperties(mhUserHour,userHourReviewVO);

        userHourReviewVO.setDayType(sysHolidayService.isAHoliday(mhUserHour.getFillDate())?0:1);
        userHourReviewVO.setNickName(sysUser.getNickName());
        return userHourReviewVO;
    }
}