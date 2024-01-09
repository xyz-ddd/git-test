package com.oaker.web.controller.mhour;

import com.oaker.common.core.controller.BaseController;
import com.oaker.common.core.domain.AjaxResult;
import com.oaker.common.core.page.TableDataInfo;
import com.oaker.common.utils.PageByList;
import com.oaker.framework.web.domain.server.Sys;
import com.oaker.hours.doman.dto.*;
import com.oaker.hours.doman.entity.MhUserHour;
import com.oaker.hours.doman.vo.*;
import com.oaker.hours.service.impl.MhCostServiceImpl;
import com.oaker.hours.service.impl.MhReviewServiceImpl;
import com.oaker.hours.service.impl.MhUserHourServiceImpl;
import com.oaker.hours.service.impl.ProjectUserServiceImpl;
import com.oaker.system.service.ISysPostService;
import com.oaker.system.service.ISysUserService;
import io.swagger.annotations.Api;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.validation.Valid;
import java.time.LocalDate;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

/**
 * @author haski
 * @description 工时审核
 * @params * @return null
 * @date 2023-10-28 0028 21:31
 */
@Validated
@RestController
@Api(tags = "D-工时审核")
@RequestMapping("/mh/review")
public class MhReviewController extends BaseController {

    @Resource
    private MhCostServiceImpl costService;

    @Autowired
    private ISysUserService userService;

    @Autowired
    private ISysPostService postService;

    @Resource
    private MhUserHourServiceImpl userHourService;


    @Resource
    private MhReviewServiceImpl reviewService;

    @Resource
    private ProjectUserServiceImpl projectUserService;
    /**
     * 获取待审核列表
     *
     * @return
     */
    @GetMapping("/list")
    @PreAuthorize("@ss.hasPermi('mh:review')")
    public TableDataInfo list(MhReviewDTO mhReviewDTO,int pageNum, int pageSize,@DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate localDate) {
        List<UserHourReviewVO> list = reviewService.query(mhReviewDTO,localDate);
        TableDataInfo  tableDataInfo = getDataTable(list);
        tableDataInfo.setRows(PageByList.startPage(list,pageNum,pageSize));
        return tableDataInfo;
    }


    @GetMapping("/queryByPostId")
    @PreAuthorize("@ss.hasPermi('mh:review')")
    public UserHourReviewVO queryByPostId(int postId) {
        return reviewService.queryById(postId);
    }


    @PostMapping("/audit")
    @PreAuthorize("@ss.hasPermi('mh:review')")
    public AjaxResult setReview(@Valid @RequestBody MhAuditReviewDTO mhAudit) {
        Long hourId = (long)mhAudit.getHourId();
        MhUserHour mhUserHour = userHourService.selectById(hourId);
        int reviewStatus = mhUserHour.getReviewStatus();
        Integer resultId = mhAudit.getResultId();
        if (reviewStatus == 0) {
            return  AjaxResult.error("该日志无需审核");
        }

        if (reviewStatus == 2) {
            return  AjaxResult.error("该日志已被审核通过,无需再次通过");
        }

        if (reviewStatus == -1 && resultId == -1 ) {
            return  AjaxResult.error("该日志已被驳回，无法再次驳回");

        }
        boolean res = false;

        if (resultId == -1 || resultId == 1 ) {
            res = reviewService.rejectReview(hourId);
            return  toAjax(res);
        }

        if (resultId == 2  ) {
            res = reviewService.auditReview(hourId);
            return toAjax(res);
        }
        return  AjaxResult.error("不是有效的审批结果");

    }


    @GetMapping("/queryDailyDetail")
    public AjaxResult queryHourDetailByPostId(Long hourId) {
        List<UserHourDetailVO> detalList = userHourService.queryDetail(hourId);
        if (detalList.size() <= 0) {
            return AjaxResult.error( "日志查询错误，没有找到该日的日志");
        }
        return AjaxResult.success(detalList);

    }




}
