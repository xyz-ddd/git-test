package com.oaker.hours.doman.vo;

import com.oaker.common.core.domain.entity.SysUser;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.time.LocalDate;

/**
 * @projectName: cost-pro-server
 * @package: com.oaker.hours.doman.vo
 * @className: QueryDateRateVO
 * @author: sixfly
 * @description: TODO
 * @date: 2023-09-25 0025 11:09
 * @version: 1.0
 */


@Data
@ApiModel(value = "数据统计-上报统计率-查询条件")
public class DateRateQueryVO extends SysUser {
    @ApiModelProperty(value = "月份 yyyy-MM 格式字符串")
    private String month;
}
