package com.oaker.hours.service.impl;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.oaker.common.core.domain.IdName;
import com.oaker.common.core.domain.entity.SysUser;
import com.oaker.common.enums.UserStatus;
import com.oaker.common.enums.UserTypeEnum;
import com.oaker.common.exception.ServiceException;
import com.oaker.common.utils.DateUtils;
import com.oaker.common.utils.SecurityUtils;
import com.oaker.common.utils.StringUtils;
import com.oaker.hours.doman.columns.Columns;
import com.oaker.hours.doman.dto.ProjectUserSaveDTO;
import com.oaker.hours.doman.entity.MhProject;
import com.oaker.hours.doman.entity.ProjectUser;
import com.oaker.hours.doman.entity.SysUserEntity;
import com.oaker.hours.doman.vo.ProjectUserVO;
import com.oaker.hours.doman.vo.UserProjectDetailVO;
import com.oaker.hours.doman.vo.UserProjectListVO;
import com.oaker.hours.doman.vo.UserProjectShortVO;
import com.oaker.hours.enums.ProjectStatusEnum;
import com.oaker.hours.mapper.ProjectUserMapper;
import com.oaker.hours.service.ProjectService;
import com.oaker.hours.service.ProjectUserService;
import com.oaker.system.domain.SysPost;
import com.oaker.system.service.ISysPostService;
import com.oaker.system.service.ISysUserService;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections4.CollectionUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import java.util.Objects;
import java.util.Set;
import java.util.TreeSet;
import java.util.stream.Collectors;

import static java.util.stream.Collectors.collectingAndThen;
import static java.util.stream.Collectors.toCollection;

/**
 * @Description :
 * <功能详细描述>
 * @author: 须尽欢_____
 * @Data : 2021/9/9 15:00
 */
@Service
@Slf4j
public class ProjectUserServiceImpl extends ServiceImpl<ProjectUserMapper, ProjectUser> implements ProjectUserService {

    @Resource
    private ISysUserService sysUserService;

    @Resource
    private UserServiceImpl userService;

    @Resource
    private ISysPostService sysPostService;

    @Resource
    private ProjectService projectService;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean create(ProjectUserSaveDTO projectUserSaveDTO) {
        List<Long> users = projectUserSaveDTO.getUsers();
        ProjectUser projectUser;
        Long projectId = projectUserSaveDTO.getProjectId();
        Long createUser = SecurityUtils.getUserId();
        Date createTime = new Date();
        for (Long userId : users) {
            projectUser = new ProjectUser();
            projectUser.setProjectId(projectId)
                    .setUserId(userId);
            ProjectUser existUser = baseMapper.selectOne(projectUser);
            if (!Objects.isNull(existUser)) {
                existUser.setStatus(Boolean.TRUE)
                        .setUpdateTime(createTime)
                        .setUpdateUser(createUser);
                baseMapper.updateById(existUser);
                continue;
            }

            //默认人员加入时间不同项目开始时间时间
            projectUser.setJoinWithProject(false);
            projectUser.setJoinTime(createTime);

            projectUser.setCreateTime(createTime)
                    .setCreateUser(createUser);
            baseMapper.insert(projectUser);
        }
        return Boolean.TRUE;
    }

    @Override
    public List<ProjectUserVO> queryList(Long projectId) {
        List<ProjectUser> projectUsers = this.queryUserByProjectId(projectId, null);
        if (CollectionUtils.isEmpty(projectUsers)) {
            return Collections.emptyList();
        }
        ProjectUserVO projectUserVo;
        List<ProjectUserVO> resultList = new ArrayList<>(projectUsers.size());
        for (ProjectUser projectUser : projectUsers) {
            projectUserVo = this.entityToVo(projectUser);
            resultList.add(projectUserVo);
        }
        return resultList;
    }

    private ProjectUserVO entityToVo(ProjectUser projectUser) {
        Long userId = projectUser.getUserId();
        SysUser sysUser = sysUserService.selectUserById(userId);
        SysPost sysPost = sysPostService.getByUserId(userId);
        ProjectUserVO projectUserVo = new ProjectUserVO();
        projectUserVo.setId(projectUser.getId())
                .setUserId(userId)
                .setProjectId(projectUser.getProjectId())
                .setJoinTime(projectUser.getCreateTime())
                .setAvatar(sysUser.getAvatar())
                .setEmail(sysUser.getEmail())
                .setNickName(sysUser.getNickName())
                .setPostId(sysPost.getPostId())
                .setEveryday(projectUser.getEveryday())
                .setPostName(sysPost.getPostName())
                .setJoinWithProject(projectUser.getJoinWithProject());
        return projectUserVo;
    }

    @Override
    public List<ProjectUser> queryUserByProjectId(Long projectId, Boolean everyday) {
        EntityWrapper<ProjectUser> wrapper = new EntityWrapper<>();
        wrapper.eq(Columns.ProjectUser.projectId, projectId);
        wrapper.eq(Columns.ProjectUser.status, Boolean.TRUE);
        if (!Objects.isNull(everyday)) {
            wrapper.eq(Columns.ProjectUser.everyday, everyday);
        }
        return baseMapper.selectList(wrapper);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean removeUser(Long projectId, List<Long> userIds) {
        EntityWrapper<ProjectUser> wrapper = new EntityWrapper<>();
        wrapper.eq(Columns.ProjectUser.projectId, projectId);
        wrapper.in(Columns.ProjectUser.userId, userIds);
        ProjectUser projectUser = new ProjectUser();
        projectUser.setStatus(Boolean.FALSE);
        projectUser.setUpdateTime(new Date());
        projectUser.setUpdateUser(SecurityUtils.getUserId());
        return baseMapper.update(projectUser, wrapper) > 0;
    }

    @Override
    public List<ProjectUserVO> selectList(Long projectId, String nickName) {
        List<ProjectUser> projectUsers = this.queryUserByProjectId(projectId, null);
        List<Long> userIds = projectUsers.stream()
                .map(ProjectUser::getUserId)
                .collect(Collectors.toList());
        EntityWrapper<SysUserEntity> wrapper = new EntityWrapper<>();
        wrapper.eq(Columns.SysUserEntity.delFlag, UserStatus.OK.getCode())
                .and()
                .eq(Columns.SysUserEntity.userType, UserTypeEnum.SYS_USER.getCode());
        if (!CollectionUtils.isEmpty(userIds)) {
            wrapper.notIn(Columns.ProjectUser.userId, userIds);
        }
        if (StringUtils.isNotEmpty(nickName)) {
            wrapper.like(Columns.SysUserEntity.nickName, "%" + nickName + "%");
        }
        List<SysUserEntity> userEntities = userService.selectList(wrapper);
        if (CollectionUtils.isEmpty(userEntities)) {
            return Collections.emptyList();
        }
        ProjectUserVO projectUserVo;
        List<ProjectUserVO> resultList = new ArrayList<>(projectUsers.size());
        for (SysUserEntity userEntity : userEntities) {
            ProjectUser projectUser = new ProjectUser();
            projectUser.setUserId(userEntity.getUserId());
            projectUserVo = this.entityToVo(projectUser);
            resultList.add(projectUserVo);
        }
        return resultList;
    }

    @Override
    public List<UserProjectShortVO> queryMyProject(Long userId, Date date) {
        if (Objects.isNull(date)) {
            date = new Date();
        }
        date = DateUtils.getFinallyDate(date);

        List<UserProjectShortVO> vos ;
        if (userId ==1) {
             vos = baseMapper.queryAllProject(date);
        } else {
             vos = baseMapper.queryUserProject(userId, date);
        }

        if (CollectionUtils.isEmpty(vos)) {
            return Collections.emptyList();
        }
        return vos.stream()
                .filter(vo -> !Objects.equals(vo.getProjectStatus(), ProjectStatusEnum.COMPLETE.getCode()))
                .collect(Collectors.toList());
    }

    @Override
    public List<UserProjectShortVO> queryMyProject(Long userId) {
        List<UserProjectShortVO> vos = baseMapper.queryUserAllProject(userId);

        if (CollectionUtils.isEmpty(vos)) {
            return Collections.emptyList();
        }
        return vos.stream()
                .filter(vo -> !Objects.equals(vo.getProjectStatus(), ProjectStatusEnum.COMPLETE.getCode()))
                .collect(Collectors.toList());
    }






    @Override
    public Date getUserFirstJoinTime(Long userId) {
        EntityWrapper<ProjectUser> wrapper = new EntityWrapper<>();
        wrapper.eq(Columns.ProjectUser.userId, userId);
        wrapper.orderAsc(Collections.singleton(Columns.ProjectUser.createTime));
        wrapper.last("Limit 1");
        List<ProjectUser> projectUsers = baseMapper.selectList(wrapper);
        if (CollectionUtils.isEmpty(projectUsers)) {
            return null;
        }
        return projectUsers.get(0).getJoinTime();
    }

    @Override
    public Set<Long> queryJoinUserIds(LocalDate localDate) {
        if (Objects.isNull(localDate)) {
            localDate = LocalDate.now();
        }
        return baseMapper.queryJoinUserIds(localDate);
    }


    @Transactional(rollbackFor = Exception.class)
    @Override
    public List<UserProjectShortVO> userProjects(Long userId, String projectStatus, Boolean everyday) {
        List<UserProjectShortVO> vos = baseMapper.queryProjectByUserId(userId, projectStatus, everyday);
        if (CollectionUtils.isEmpty(vos)) {
            return vos;
        }
        for (UserProjectShortVO vo : vos) {
            String desc = ProjectStatusEnum.getDescByCode(vo.getProjectStatus());
            vo.setProjectStatus(desc);
        }
        return vos;
    }



    @Transactional(rollbackFor = Exception.class)
    public List<UserProjectShortVO> userProjectList(Long userId, String projectStatus) {
        List<UserProjectShortVO> vos = baseMapper.queryProjectByUserId(userId, projectStatus,null);

        if (CollectionUtils.isEmpty(vos)) {
            return vos;
        }
        for (UserProjectShortVO vo : vos) {
            String desc = ProjectStatusEnum.getDescByCode(vo.getProjectStatus());
            vo.setProjectStatus(desc);
        }
        return vos;
    }



    @Transactional(rollbackFor = Exception.class)
    public List<UserProjectDetailVO> userProjectListDetail(Long userId, String projectStatus) {
        List<UserProjectDetailVO> vos = baseMapper.queryProjectByUserIdDetail(userId, projectStatus,null);

        if (CollectionUtils.isEmpty(vos)) {
            return vos;
        }
        for (UserProjectDetailVO vo : vos) {
            String desc = ProjectStatusEnum.getDescByCode(vo.getProjectStatus());
            vo.setProjectStatus(desc);
        }
        return vos;
    }








    @Override
    public List<IdName> queryUserAll(Long projectId) {
        return baseMapper.queryUserAll(projectId);
    }

    @Override
    public List<IdName> queryPostAll(Long projectId) {
        List<IdName> idNames = baseMapper.queryPostAll(projectId);
        if (CollectionUtils.isEmpty(idNames)) {
            return Collections.emptyList();
        }
        return idNames.stream().collect(collectingAndThen(
                toCollection(() -> new TreeSet<>(Comparator.comparing(IdName::getId))), ArrayList::new));
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public boolean updateEveryDay(Long id, Boolean everyday) {
        ProjectUser projectUser = new ProjectUser();
        projectUser.setId(id)
                .setEveryday(everyday)
                .setUpdateUser(SecurityUtils.getUserId())
                .setUpdateTime(new Date());
        return baseMapper.updateById(projectUser) > 0;
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public boolean updateJoinWithProject(Long id, Boolean joinWithProject) {
        ProjectUser projectUser = this.selectById(id);
        if (null == projectUser) {
            throw new ServiceException("该用户不在项目内！");
        }
        Date joinTime = projectUser.getCreateTime();

        //加入时间同项目开始时间
        if (joinWithProject) {
            MhProject project = projectService.selectById(projectUser.getProjectId());
            if (null == project) {
                throw new ServiceException("对应项目不存在！");
            }
            joinTime = DateUtils.localDate2Date(project.getStartDate());
        }

        projectUser.setJoinWithProject(joinWithProject)
                .setUpdateUser(SecurityUtils.getUserId())
                .setUpdateTime(new Date())
                .setJoinTime(joinTime);
        return baseMapper.updateById(projectUser) > 0;
    }
}
