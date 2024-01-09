package com.oaker.hours.doman.vo;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.experimental.Accessors;

import java.math.BigDecimal;
import java.time.LocalDate;

/**
 * @projectName: wyproject-local
 * @package: com.oaker.hours.doman.vo
 * @className: UserDataStat
 * @author: sixfly
 * @description: TODO
 * @date: 2023-09-21 0021 11:04
 * @version: 1.0
 */

@Data
@Accessors(chain = true)
public class UserDataStatVO {

    @ApiModelProperty("月份")
    private String month;

    @ApiModelProperty("当月应报数")
    private int MonthTotal;

    @ApiModelProperty("用户上报总数")
    private int fillTotal;


    @ApiModelProperty("缺报")
    private int missFillTotal;

    @ApiModelProperty("请假")
    private int leaveTotal;

    @ApiModelProperty("加班")
    private int overtimeTotal;

    @ApiModelProperty("调休")
    private int paidLeaveTotal;


}
