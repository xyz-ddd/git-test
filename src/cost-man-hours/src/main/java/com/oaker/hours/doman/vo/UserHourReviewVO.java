package com.oaker.hours.doman.vo;

import com.baomidou.mybatisplus.annotations.TableField;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.experimental.Accessors;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Date;
import java.util.List;

/**
 * @Description : 用户工时审核
 * <功能详细描述>
 * @author: 须尽欢_____
 * @Data : 2021/9/16 12:07
 */
@Data
@Accessors(chain = true)
@ApiModel(value = "UserHourReviewVO", description = "用户工时审核")
public class UserHourReviewVO {

    @ApiModelProperty("填报/缺报/请假 记录id")
    private Long id;

    @ApiModelProperty("日期")
    private LocalDate fillDate;


    @ApiModelProperty("日期类型：0 工作日， 1 节假日")
    private int dayType;

    @ApiModelProperty("用户名")
    private String userName;

    @ApiModelProperty("姓名/昵称")
    private String nickName;

    @ApiModelProperty("岗位名称")
    private String postName;

    @ApiModelProperty("填报时间")
    private Date fillTime;

    @ApiModelProperty("总工时")
    private BigDecimal totalHour;

    @ApiModelProperty("审核状态：0 不需要审核， 1 待审核， 2 通过审核 -1 审核拒绝")
    private int reviewStatus;




}
