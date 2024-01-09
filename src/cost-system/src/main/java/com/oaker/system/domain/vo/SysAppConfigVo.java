package com.oaker.system.domain.vo;

import java.math.BigDecimal;

/**
 * @Description : 应用配置类
 * <功能详细描述>
 * @author: 须尽欢_____
 * @Data : 2021/11/4 10:34
 */
public class SysAppConfigVo {

    /** 是否允许加班 */
    private boolean overtimeAllow;


    /** 是否开启审核 */
    private boolean workReview;


    /** 每日工时数 */
    private BigDecimal workTime;

    /** 每月工作日数 */
    private int workDay;


    /** 是否记录0工时项目 */
    private boolean hourZero;



    public boolean isOvertimeAllow() {
        return overtimeAllow;
    }

    public void setOvertimeAllow(boolean overtimeAllow) {
        this.overtimeAllow = overtimeAllow;
    }

    public BigDecimal getWorkTime() {
        return workTime;
    }

    public void setWorkTime(BigDecimal workTime) {
        this.workTime = workTime;
    }

    public int getWorkDay() {
        return workDay;
    }

    public void setWorkDay(int workDay) {
        this.workDay = workDay;
    }


    public boolean isWorkReview() {
        return workReview;
    }

    public void setWorkReview(boolean workReview) {
        this.workReview = workReview;
    }


    public boolean isHourZero() {
        return hourZero;
    }

    public void setHourZero(boolean hourZero) {
        this.hourZero = hourZero;
    }
}
