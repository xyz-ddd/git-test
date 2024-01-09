package com.oaker.hours.service;

import com.oaker.hours.doman.entity.MhConfig;
import com.oaker.system.domain.SysConfig;
import com.oaker.system.domain.vo.SysAppConfigVo;

import java.math.BigDecimal;
import java.util.List;

public interface MhConfigService {

    /**
     * 查询应用配置
     * @return
     */

    public List<MhConfig> selectConfigList();

    public int updateConfig(MhConfig config);


    /**
     * 加载参数缓存数据
     */
    public void loadingConfigCache();

    /**
     * 清空参数缓存数据
     */
    public void clearConfigCache();


    boolean update(Boolean overtimeAllow, BigDecimal workTime, Integer workDay, Boolean workReview,Boolean hourZero);
}
