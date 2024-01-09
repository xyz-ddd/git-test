package com.oaker.hours.doman.dto;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import org.springframework.validation.annotation.Validated;

import javax.validation.Valid;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import java.math.BigDecimal;
import java.util.List;

/**
 * @Description : 修改工时填报
 * <功能详细描述>
 * @author: 须尽欢_____
 * @Data : 2021/9/16 10:39
 */
@Data
@ApiModel(value = "UserHourUpdateDTO", description = "用户修改填报工时")
public class UserHourUpdateDTO {

    @NotNull(message = "工时填报id不能为空")
    @ApiModelProperty("工时填报表id")
    private Long hourId;



    @ApiModelProperty("审核状态：0 或者空不需要审核 , 1 待审核 , 2 审核通过 , -1 审核拒绝")
    private int reviewStatus;

    @Valid
    @NotEmpty(message = "工时详情不能为空")
    @ApiModelProperty(value = "工时详情")
    List<ProjectHourDetail> projectHours;

    @Data
    @Validated
    @ApiModel(description = "用户填报工时详情")
    public static class ProjectHourDetail {

        @NotNull(message = "详情id不能为空")
        @ApiModelProperty(name = "detailId", value = "填报详情id", required = true)
        private Long detailId;

        @NotNull(message = "项目id不能为空")
        @ApiModelProperty(value = "项目id", required = true)
        private Long projectId;

        @ApiModelProperty(value = "填报工时", required = true)
        private BigDecimal hour;

        @NotEmpty(message = "工作类型工时列表不能为空")
        @ApiModelProperty(value = "工作类型工时列表", required = true)
        private List<ProjectSubHour> workTypeHourList;

        @ApiModelProperty(value = "日报内容")
        private String daily;
    }


}
