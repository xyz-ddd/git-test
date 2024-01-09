package com.oaker.hours.doman.dto;


import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotNull;
import java.time.LocalDate;

/**
 * @Description : 用户数据统计列表查询参数类
 * <功能详细描述>
 * @author: 须尽欢_____
 * @Data : 2023年9月20日
 */
@Data
@ApiModel(value = "用户数据统计列表查询参数类")
public class UserDataStatDTO {

    @ApiModelProperty(value = "人员id")
    private Long userId;

    @ApiModelProperty(value = "时间")
    private LocalDate localDate;


    @NotNull(message = "分页参数不能为空")
    private Integer pageNum;

    @NotNull(message = "分页参数不能为空")
    private Integer pageSize;



}
