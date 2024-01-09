package com.oaker.web.controller.dataStat;


import com.oaker.common.core.controller.BaseController;
import com.oaker.common.core.domain.AjaxResult;
import com.oaker.common.core.domain.entity.SysUser;
import com.oaker.common.utils.SecurityUtils;
import com.oaker.common.utils.bean.BeanUtils;
import com.oaker.hours.doman.entity.MhProject;
import com.oaker.hours.doman.vo.*;
import com.oaker.hours.enums.ProjectStatusEnum;
import com.oaker.hours.service.ProjectService;
import com.oaker.hours.service.impl.MhUserHourServiceImpl;
import com.oaker.hours.service.impl.ProjectHourServiceImpl;
import com.oaker.hours.service.impl.ProjectUserServiceImpl;
import com.oaker.system.service.ISysUserService;
import io.swagger.annotations.Api;
import lombok.extern.slf4j.Slf4j;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.util.CollectionUtils;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import javax.validation.constraints.NotNull;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.*;
import java.util.stream.Collectors;

/**
 * @Description : 项目统计相关模块
 * <功能详细描述>
 * @author:
 * @Data : 2
 */
@Validated
@RestController
@Api(tags = "B-项目统计")
@Slf4j
@RequestMapping("/project/dataStat")
public class ProjectDataStatController extends BaseController {

    @Resource
    private ProjectHourServiceImpl projectHourService;

    @Resource
    private ProjectUserServiceImpl projectUserService;

    @Resource
    private MhUserHourServiceImpl userHourService;

    @Resource
    private ProjectService projectService;

    @Resource
    private ISysUserService userService;

    /**
     * 项目日报
     * @param
     * @return
     */
    @GetMapping("/daily")
    public AjaxResult queryMyProjectDaily(@NotNull(message = "日期不能为空") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE)LocalDate localDate
            , Long projectId) {
        Long userId = SecurityUtils.getUserId();
        ZoneId zoneId = ZoneId.systemDefault();
        ZonedDateTime zdt = localDate.atStartOfDay(zoneId);
        Date date = Date.from(zdt.toInstant());
        List<UserProjectShortVO> vos1 = projectUserService.queryMyProject(userId,date);

        if (projectId !=null){
            vos1 = vos1.stream().filter(i -> i.getProjectId() == projectId).collect(Collectors.toList());
        }

        List<ProjectStatDailyVo> projectDailyVoList = vos1.stream().map((item) -> {
            ProjectStatDailyVo projectDailyVo = new ProjectStatDailyVo();
            BeanUtils.copyProperties(item, projectDailyVo);

            //查询项目相关信息
            Long id = item.getProjectId();
            ProjectHourFillStatListVO projectHourFillStatListVOS = projectHourService.queryProjectHourFill(id, localDate);

            MhProject mhProject = projectService.selectById(id);
            Long  pmId = mhProject.getProjectManager();
            SysUser sysUser = userService.selectUserById(pmId);

            projectDailyVo.setProjectManagerName(sysUser.getNickName());
            projectDailyVo.setAllFill(projectHourFillStatListVOS.getAllFill());
            projectDailyVo.setTotalHour(projectHourFillStatListVOS.getTotalHour());
            projectDailyVo.setStatDate(localDate);

            return projectDailyVo;
        }).collect(Collectors.toList());
        return AjaxResult.success(projectDailyVoList);
    }



    /**
     * 项目日报详情
     * @param localDate
     * @param projectId
     * @return
     */
    @GetMapping("/daily/detail")
    // @PreAuthorize("@ss.hasPermi('system:project:daily')")
    public AjaxResult getProjectFillCalendarDetail(@NotNull(message = "日期不能为空") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE)LocalDate localDate
            ,@NotNull(message = "项目id不能为空") Long projectId) {
        ProjectFillCalendarDetail detail = projectHourService.getProjectFillCalendarDetail(localDate, projectId);
        return AjaxResult.success(detail);
    }





    /**
     * 项目月报
     * @param date 月份（yyyy-dd)
     * @return
     */
    @GetMapping("/month")
    public AjaxResult queryMyProjectMonth(@RequestParam("date") Date date,@RequestParam(value = "projectId",required = false) Long id) {
        Long userId = SecurityUtils.getUserId();
        if (Objects.isNull(date)) {
            date = new Date();
        }
        Date mydate = date;

        LocalDate localDate = date.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();

        List<UserProjectShortVO> vos1 = projectUserService.queryMyProject(userId, date);

        if (id != null ) {
             vos1 = vos1.stream().filter(item-> item.getProjectId().equals(id)).collect(Collectors.toList());
             log.info("新的vos是："+vos1.stream());
        }

        if (vos1 == null || vos1.size() == 0 ){
            return  AjaxResult.success("该月份没有数据");
        }

        List<ProjectStatMonthVo> projectStatMonthVoList = vos1.stream().map((item) -> {
            ProjectStatMonthVo projectStatMonthVo = new ProjectStatMonthVo();
            BeanUtils.copyProperties(item, projectStatMonthVo);

            //查询项目相关信息
            Long projectId = item.getProjectId();
            List<ProjectHourStatMonth> hourStatMonths = projectHourService.queryProjectHourMonthStat(projectId,localDate);

            if (CollectionUtils.isEmpty(hourStatMonths)) {
                return projectStatMonthVo;
            }
            List<Long> users  = hourStatMonths.stream().findFirst().get().getUsers();
            BigDecimal useHour = hourStatMonths.stream().findFirst().get().getUseHour();
            projectStatMonthVo.setTotalUser((int)users.stream().count());
            projectStatMonthVo.setTotalHour(useHour);

            return projectStatMonthVo;
        }).collect(Collectors.toList());

        return AjaxResult.success(projectStatMonthVoList);
    }


    /**
     * 项目月报详情
     * @param projectId  项目id
     * @param yearMonth 月份（yyyy-dd)
     * @return
     */
    @GetMapping(value = "/month/detail")
    @PreAuthorize("@ss.hasPermi('system:project:stat:query')")
    public AjaxResult queryProjectHourUserStat(@NotNull(message = "项目id不能为空") Long projectId, @NotNull(message = "月份不能为空") String yearMonth){
        List<ProjectHourStatUser> projectHourStatUsers = projectHourService.queryProjectHourUserStat(projectId, yearMonth);
        return AjaxResult.success(projectHourStatUsers);
    }


    /**
     * 用户月报详情导出
     *
     * @param localDate
     * @param projectId
     * @return
     */
    @GetMapping("/month/export")
    @PreAuthorize("@ss.hasPermi('mh:hour:stat')")
    public AjaxResult userHourExport(
            @NotNull(message = "查询日期不能为空") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate localDate
            , @NotNull(message = "项目id不能为空") Long projectId,Long userId) {



        return  AjaxResult.error("该版本不包含此功能");
    }


}
