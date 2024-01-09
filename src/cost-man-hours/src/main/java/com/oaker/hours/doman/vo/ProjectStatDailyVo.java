package com.oaker.hours.doman.vo;


import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.experimental.Accessors;

import java.math.BigDecimal;
import java.time.LocalDate;

@Data
@Accessors(chain = true)
@ApiModel(value = "ProjectDailyVo", description = "项目日报列表")
public class ProjectStatDailyVo   {
    @ApiModelProperty("项目id")
    private Long projectId;

    @ApiModelProperty("项目名称")
    private String projectName;

    @ApiModelProperty("项目经理name")
    private String projectManagerName;

    @ApiModelProperty("项目状态")
    private String projectStatus;

    @ApiModelProperty("日报日期")
    private LocalDate statDate;


    @ApiModelProperty("全部上报数量")
    private int allFill;

    @ApiModelProperty("总上报工时")
    private BigDecimal totalHour;

}
