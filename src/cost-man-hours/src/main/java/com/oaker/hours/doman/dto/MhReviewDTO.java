package com.oaker.hours.doman.dto;

import com.oaker.common.core.domain.entity.SysUser;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotNull;
import java.time.LocalDate;

/**
 * @description: 审批查询条件
 * 功能说明：
 * @className: MhReviewDTO
 * @author: sixfly
 * @date: 2023-10-29 0029 19:08
 */

@Data
@ApiModel(value = "审核列表查询参数类")
public class MhReviewDTO  extends SysUser {
    @ApiModelProperty(value = "审批状态")
    private Integer reviewStatus;

}

