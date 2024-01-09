package com.oaker.hours.doman.vo;


import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.experimental.Accessors;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Date;

@Data
@Accessors(chain = true)
@ApiModel(value = "ProjectStatMonthVo", description = "项目月报列表")
public class ProjectStatMonthVo {
    @ApiModelProperty("项目id")
    private Long projectId;

//    @ApiModelProperty("日期")
//    private Date date;


    @ApiModelProperty("项目名称")
    private String projectName;

    @ApiModelProperty("项目状态")
    private String projectStatus;


    @ApiModelProperty("上报人数")
    private int totalUser;

    @ApiModelProperty("总上报工时")
    private BigDecimal totalHour;

}
