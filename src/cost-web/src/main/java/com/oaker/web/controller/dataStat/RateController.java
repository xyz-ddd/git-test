package com.oaker.web.controller.dataStat;

import com.oaker.common.core.controller.BaseController;
import com.oaker.common.core.domain.entity.SysRole;
import com.oaker.common.core.domain.entity.SysUser;
import com.oaker.common.core.page.TableDataInfo;
import com.oaker.hours.doman.dto.UserDataStatDTO;
import com.oaker.hours.doman.vo.DataRateVO;
import com.oaker.hours.doman.vo.DateRateQueryVO;
import com.oaker.hours.doman.vo.UserDataStatVO;
import com.oaker.hours.service.impl.MhUserHourServiceImpl;
import com.oaker.system.domain.SysPost;
import com.oaker.system.domain.vo.SysUserVO;
import com.oaker.system.service.ISysPostService;
import com.oaker.system.service.ISysUserService;
import io.swagger.annotations.Api;
import org.apache.commons.collections4.CollectionUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

/**
 * @projectName: cost-pro-server
 * @package: com.oaker.web.controller.dataStat
 * @className: rateController
 * @author: sixfly
 * @description: TODO
 * @date: 2023-09-24 0024 20:51
 * @version: 1.0
 */


@Validated
@RestController
@Api(tags = "E-工时管理/统计")
@RequestMapping("/stat/rate")
public class RateController  extends BaseController {

    @Autowired
    private ISysUserService userService;

    @Autowired
    private ISysPostService postService;

    @Resource
    private MhUserHourServiceImpl userHourService;

    /**
     * @description 填报率列表
     * @param
    	 * @param pageNum:
    	 * @param pageSize:
      * @return TableDataInfo
     * @author haski
     * @date 2023-10-28 0028 21:05
     */
    @GetMapping("/list")
    public TableDataInfo list(DateRateQueryVO dateRateQueryVO, Integer pageNum, Integer pageSize) {
        List<SysUser> list = userService.selectUserList(dateRateQueryVO);
        String month = dateRateQueryVO.getMonth();
        TableDataInfo dataTable = getDataTable(list);
        if (CollectionUtils.isEmpty(list)) {
            return dataTable;
        }

        List<DataRateVO> voList = new ArrayList<>();

        list.forEach(sysUser -> {
            Long userId = sysUser.getUserId();
            Long postId = postService.selectPostListByUserId(userId);
            List<DataRateVO>  dataRateVOS = new ArrayList<>();
            List<UserDataStatVO> userDataStatVOList = userHourService.queryUserDataStat(userId,month);
            for (UserDataStatVO userDataStatVO : userDataStatVOList) {
                DataRateVO dataRateVO = new DataRateVO();
                BeanUtils.copyProperties(userDataStatVO, dataRateVO);
                if (!Objects.isNull(postId)) {
                    SysPost sysPost = postService.selectPostById(postId);
                    // dataRateVO.setPostIds(new Long[] {postId});
                    dataRateVO.setPostName(sysPost.getPostName());
                    dataRateVO.setNickName(sysUser.getNickName());
                    dataRateVO.setUserId(sysUser.getUserId());
                    dataRateVO.setUserName(sysUser.getUserName());
                }
                dataRateVOS.add(dataRateVO);
            }
            voList.addAll(dataRateVOS);

        });
        dataTable.setTotal(voList.size());
        dataTable.setRows(voList);

        return dataTable;
    }
}
