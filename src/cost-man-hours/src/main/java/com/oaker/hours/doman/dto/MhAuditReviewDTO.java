package com.oaker.hours.doman.dto;

import com.oaker.common.core.domain.entity.SysUser;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.time.LocalDate;

/**
 * @description: 审批查询条件
 * 功能说明：
 * @className: MhReviewDTO
 * @author: sixfly
 * @date: 2023-10-29 0029 19:08
 */

@Data
@ApiModel(value = "提交审批")
public class MhAuditReviewDTO  {
    @ApiModelProperty(value = "工时id")
    private Integer hourId;

    @ApiModelProperty(value = "审批结果")
    private Integer resultId;
}
