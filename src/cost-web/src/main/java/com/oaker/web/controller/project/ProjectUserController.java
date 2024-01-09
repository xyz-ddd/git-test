package com.oaker.web.controller.project;

import com.oaker.common.annotation.Log;
import com.oaker.common.core.controller.BaseController;
import com.oaker.common.core.domain.AjaxResult;
import com.oaker.common.core.domain.entity.SysUser;
import com.oaker.common.core.page.PageDomain;
import com.oaker.common.core.page.TableDataInfo;
import com.oaker.common.enums.BusinessType;
import com.oaker.common.utils.SecurityUtils;
import com.oaker.common.utils.bean.BeanUtils;
import com.oaker.hours.doman.dto.ProjectUserSaveDTO;
import com.oaker.hours.doman.entity.MhProject;
import com.oaker.hours.doman.vo.ProjectUserVO;
import com.oaker.hours.doman.vo.UserProjectDetailVO;
import com.oaker.hours.doman.vo.UserProjectListVO;
import com.oaker.hours.doman.vo.UserProjectShortVO;
import com.oaker.hours.service.ProjectService;
import com.oaker.hours.service.impl.ProjectHourServiceImpl;
import com.oaker.hours.service.impl.ProjectUserServiceImpl;
import com.oaker.system.service.ISysUserService;
import io.swagger.annotations.Api;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.validation.constraints.NotNull;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

/**
 * @Description : 项目成员
 * <功能详细描述>
 * @author: 须尽欢_____
 * @Data : 2021/9/9 15:15
 */
@Validated
@RestController
@Api(tags = "D-我的项目")
@RequestMapping("/system/project/user")
@Slf4j
public class ProjectUserController extends BaseController {

    @Resource
    private ProjectUserServiceImpl projectUserService;

    @Resource
    private ProjectService projectService;

    @Resource
    private ProjectHourServiceImpl projectHourService;

    @Resource
    private ISysUserService userService;
    /**
     * 增加项目成员
     */
    @PostMapping("/create")
    @PreAuthorize("@ss.hasPermi('mh:project:user:add')")
    @Log(title = "项目人员管理", businessType = BusinessType.INSERT)
    public AjaxResult save(@Validated @RequestBody ProjectUserSaveDTO projectUserSaveDTO) {
        return toAjax(projectUserService.create(projectUserSaveDTO));
    }

    /**
     * 查询项目成员
     */
    @GetMapping("/list")
    @PreAuthorize("@ss.hasPermi('mh:project:user:list')")
    public AjaxResult queryList(@NotNull(message = "项目id不能为空") @RequestParam("projectId") Long projectId) {
        List<ProjectUserVO> queryList = projectUserService.queryList(projectId);
        return AjaxResult.success(queryList);
    }

    /**
     * 移除项目成员
     *
     * @param userIds
     * @return
     */
    @PutMapping("/remove")
    @PreAuthorize("@ss.hasPermi('mh:project:user:remove')")
    public AjaxResult removeUser(@NotNull(message = "项目id不能为空") @RequestParam("projectId") Long projectId
            , @NotNull(message = "人员id不能为空") Long[] userIds) {
        boolean result = projectUserService.removeUser(projectId, Arrays.asList(userIds));
        return toAjax(result);
    }

    /**
     * 查询项目可选成员
     *
     * @param projectId
     * @param nickName
     * @return
     */
    @GetMapping("/select")
    @PreAuthorize("@ss.hasPermi('mh:project:user:add')")
    public AjaxResult selectList(@NotNull(message = "项目id不能为空") @RequestParam("projectId") Long projectId,
                                 @RequestParam(value="nickName", required = false) String nickName) {
        return AjaxResult.success(projectUserService.selectList(projectId, nickName));
    }

    /**
     * 成员查询参与的项目不包含归档状态的项目
     *
     * @return
     */
    @GetMapping("/my/project")
    // @PreAuthorize("@ss.hasPermi('mh:project:hour')")
    public AjaxResult queryMyProject(@RequestParam("date") Date date) {
        Long userId = SecurityUtils.getUserId();
        if (Objects.isNull(date)) {
            date = new Date();
            return AjaxResult.success(projectUserService.queryMyProject(userId, date));

        }
        Date dateToday = new Date();
        List<UserProjectShortVO> thenList = projectUserService.queryMyProject(userId, date);
        List<UserProjectShortVO> todayList = projectUserService.queryMyProject(userId, dateToday);

        todayList.addAll(thenList);

        //对合并后的数据进行去重

        List<UserProjectShortVO> result = todayList.stream().distinct().collect(Collectors.toList());

        return AjaxResult.success(result);
    }

   /**
    * @description  查询项目列表
    * @author haski
    * @params
    *  * @return AjaxResult
    * @date 2023-10-31 0031 18:26
   */
    @GetMapping("/pm/projectList")
    // @PreAuthorize("@ss.hasPermi('mh:project:hour')")
    public AjaxResult queryMyMangerProjectList() {
        Long userId = SecurityUtils.getUserId();
        if (userId ==1) {
            PageDomain pageDomain = getPageDomain();
            List<MhProject> mhProjects = projectService.queryList("");
            return AjaxResult.success(mhProjects);
        }
        List<MhProject> mhProjects = projectService.queryMyList("");


        return AjaxResult.success(mhProjects);
    }
    /**
     * 成员用户查询自己参与的项目，给首页使用
     *
     * @return
     */
    @GetMapping("/my/project/all")
    @PreAuthorize("@ss.hasPermi('mh:project:user:all')")
    public AjaxResult userProjects(String projectStatus) {
        Long userId = SecurityUtils.getUserId();
        List<UserProjectShortVO> vos = projectUserService.userProjectList(userId, projectStatus);
        return AjaxResult.success(vos);

    }


    /**
     * 我的项目中，用户查询自己参与的项目
     * @Data : 2023年8月25日20点23分
     * @return
     */
    @GetMapping("/my/project/list")
//    @PreAuthorize("@ss.hasPermi('mh:project:user:all')")
    public AjaxResult userProjectsList(String projectStatus) {

        startPage();
        Long userId = SecurityUtils.getUserId();

       // List<UserProjectShortVO> vos = projectUserService.userProjectList(userId, projectStatus);
        List<UserProjectDetailVO> vos = projectUserService.userProjectListDetail(userId, projectStatus);


        // List<UserProjectShortVO> vos = projectUserService.queryMyProject(userId);

        List<UserProjectListVO> userProjectListList = vos.stream().map((item) -> {
            UserProjectListVO userProject = new UserProjectListVO();
            BeanUtils.copyProperties(item, userProject);
            Long projectId = item.getProjectId();
            MhProject mhProject = projectService.selectById(projectId);
            //log.info("project的信息是：{}", mhProject.toString());


            //查询项目经理名称
            Long  pmId = mhProject.getProjectManager();


            SysUser sysUser = userService.selectUserById(pmId);

            userProject.setProjectManagerName(sysUser.getNickName());
            userProject.setProjectStatus(mhProject.getProjectStatus());
            userProject.setProjectCode(mhProject.getProjectCode());
            userProject.setProjectManager(mhProject.getProjectId());
            userProject.setStartDate(mhProject.getStartDate());
            userProject.setEndDate(mhProject.getEndDate());
            userProject.setCreateTime(mhProject.getCreateTime());

            return userProject;
        }).collect(Collectors.toList());

        TableDataInfo dataTable = getDataTable(userProjectListList);

        return AjaxResult.success(dataTable);
    }


    /**
     * 更改项目成员每日上报分组
     *
     * @param id
     * @param everyday
     * @return
     */
    @PutMapping("/everyday")
    @PreAuthorize("@ss.hasPermi('mh:project:user:add')")
    @Log(title = "项目人员管理-每日上报分组", businessType = BusinessType.UPDATE)
    public AjaxResult updateEveryDay(@NotNull(message = "id不能为空") @RequestParam("id") Long id
            , @NotNull(message = "上报分组不能为空") @RequestParam("everyday") Boolean everyday) {
        return toAjax(projectUserService.updateEveryDay(id, everyday));
    }

    /**
     * 更改项目成员-加入时间同项目开始时间
     *
     * @param id
     * @param joinWithProject
     * @return
     */
    @PutMapping("/join")
    @PreAuthorize("@ss.hasPermi('mh:project:user:add')")
    @Log(title = "项目人员管理-加入时间同项目开始时间", businessType = BusinessType.UPDATE)
    public AjaxResult updateJoinWithProject(@NotNull(message = "id不能为空") @RequestParam("id") Long id
            , @NotNull(message = "加入时间同项目开始时间标识") @RequestParam("joinWithProject") Boolean joinWithProject) {
        return toAjax(projectUserService.updateJoinWithProject(id, joinWithProject));
    }

}
