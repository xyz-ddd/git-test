package com.oaker.hours.doman.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.experimental.Accessors;

import java.util.Date;

/**
 * @Description : 用户参与项目
 * <功能详细描述>
 * @author: 须尽欢_____
 * @Data : 2021/9/13 12:00
 */
@Data
@Accessors(chain = true)
@ApiModel(value = "UserProjectDetailVO", description = "成员参与的详细项目列表")
public class UserProjectDetailVO  extends  UserProjectShortVO {

    @ApiModelProperty("加入时间")
    private Date joinTime;

    @ApiModelProperty("填报方式")
    private Boolean joinWithProject;



}
