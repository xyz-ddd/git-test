package com.oaker.hours.doman.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.experimental.Accessors;

import java.math.BigDecimal;

/**
 * @projectName: cost-pro-server
 * @package: com.oaker.hours.doman.vo
 * @className: DataRateVO
 * @author: sixfly
 * @description: TODO
 * @date: 2023-09-24 0024 22:35
 * @version: 1.0
 */


@Data
@Accessors(chain = true)
@ApiModel(value = "DataRateVO", description = "数据统计上报率")
public class DataRateVO  extends  UserDataStatVO{

    @ApiModelProperty("用户id")
    private Long userId;

    @ApiModelProperty("用户昵称/姓名")
    private String nickName;

    @ApiModelProperty("用户昵称/姓名")
    private String userName;

    /** 岗位名称 */
    private String postName;
}
