package com.oaker.hours.doman.vo;


import com.baomidou.mybatisplus.annotations.TableField;
import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.experimental.Accessors;

import java.time.LocalDate;
import java.util.Date;

@Data
@Accessors(chain = true)
@ApiModel(value = "UserProjectListVO", description = "成员参与的项目列表")
public class UserProjectListVO {
    @ApiModelProperty("项目id")
    private Long projectId;

    @ApiModelProperty("项目名称")
    private String projectName;

    @ApiModelProperty("项目状态")
    private String projectStatus;

    @ApiModelProperty("项目编码")
    private String projectCode;


    @ApiModelProperty("项目经理id")
    private Long projectManager;

    @ApiModelProperty("项目经理name")
    private String projectManagerName;


    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;


    @ApiModelProperty("开始日期")
    private LocalDate startDate;


    @ApiModelProperty("结束日期")
    private LocalDate endDate;


    @ApiModelProperty("加入时间")
    private Date joinTime;

    @ApiModelProperty("填报日期")
    private Boolean joinWithProject;


}
