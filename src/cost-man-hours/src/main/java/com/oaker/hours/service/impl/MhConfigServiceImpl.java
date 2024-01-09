package com.oaker.hours.service.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.oaker.common.config.AppConfig;
import com.oaker.common.constant.Constants;
import com.oaker.common.core.redis.RedisCache;
import com.oaker.hours.doman.entity.MhConfig;
import com.oaker.hours.mapper.MhConfigMapper;
import com.oaker.hours.service.MhConfigService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import java.math.BigDecimal;
import java.util.Collection;
import java.util.List;
import java.util.Objects;

import static com.oaker.common.utils.DictUtils.getCacheKey;
import static com.oaker.common.utils.DictUtils.getMhConfigKey;

/**
 * @description: 查询工时业务配置
 * 功能说明：
 * @className: MhConfigServiceImpl
 * @author: sixfly
 * @date: 2023-11-02 0002 15:43
 */

@Service
public class MhConfigServiceImpl extends ServiceImpl<MhConfigMapper, MhConfig> implements MhConfigService {

    @Autowired
    private RedisCache redisCache;
    @Autowired
    private MhConfigMapper mhConfigMapper;


    /**
     * 项目启动时，初始化参数到缓存
     */
    @PostConstruct
    public void init() {
        loadingConfigCache();
    }

    @Override
    public List<MhConfig> selectConfigList() {
        return mhConfigMapper.selectConfigList();
    }

    @Override
    public int updateConfig(MhConfig config) {
        int row = baseMapper.updateConfig(config);
        if (row > 0) {
            //redisCache.setCacheObject(getMhConfigKey(config.getConfigKey()), config.getConfigValue());
            redisCache.setCacheMapValue(AppConfig.REDIS_KEY, config.getConfigKey(), config.getConfigValue());

        }
        return 0;
    }

    @Override
    public void loadingConfigCache() {
        List<MhConfig> configsList = selectConfigList();
        for (MhConfig config : configsList) {
            //redisCache.setCacheObject(getMhConfigKey(config.getConfigKey()), config.getConfigValue());
            redisCache.setCacheMapValue(AppConfig.REDIS_KEY, config.getConfigKey(), config.getConfigValue());
        }
    }

    @Override
    public void clearConfigCache() {
        Collection<String> keys = redisCache.keys(Constants.MH_CONFIG_KEY + "*");
        redisCache.deleteObject(keys);
    }

    @Override
    public boolean update(Boolean overtimeAllow, BigDecimal workTime, Integer workDay, Boolean workReview,Boolean hourZero) {

        if (!Objects.isNull(overtimeAllow)) {
            MhConfig mhConfigOverTime = baseMapper.selectByKey("overtime_allow");
            mhConfigOverTime.setConfigValue(overtimeAllow.toString());
            updateConfig(mhConfigOverTime);
            AppConfig.OVERTIME_ALLOW = overtimeAllow;
        }


        if (AppConfig.WORK_TIME != workTime &&  !Objects.isNull(workTime)) {
            MhConfig mhConfigWorkTime = baseMapper.selectByKey("work_time");
            mhConfigWorkTime.setConfigValue(workTime.toString());
            updateConfig(mhConfigWorkTime);
            AppConfig.WORK_TIME = workTime;
        }


        if (!Objects.isNull(workDay)) {
            MhConfig mhConfigWorkDay = baseMapper.selectByKey("work_day");
            mhConfigWorkDay.setConfigValue(workDay.toString());
            updateConfig(mhConfigWorkDay);
            AppConfig.WORK_DAY = workDay;
        }

        if (!Objects.isNull(workReview)) {
            MhConfig mhConfigWorkReview = baseMapper.selectByKey("work_review");
            mhConfigWorkReview.setConfigValue(workReview.toString());
            updateConfig(mhConfigWorkReview);
            AppConfig.WORK_REVIEWS = workReview;
        }

        if (!Objects.isNull(hourZero)) {
            MhConfig mhConfigHourZero = baseMapper.selectByKey("hour_zero");
            mhConfigHourZero.setConfigValue(hourZero.toString());
            updateConfig(mhConfigHourZero);
            AppConfig.HOUR_ZERO = hourZero;
        }

        return true;


    }
}
