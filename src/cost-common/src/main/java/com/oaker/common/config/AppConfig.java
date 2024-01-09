package com.oaker.common.config;

import com.oaker.common.core.redis.RedisCache;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.util.Map;
import java.util.Objects;

import static com.oaker.common.utils.DictUtils.getMhConfigKey;

/**
 * @Description : 应用设置类
 * <功能详细描述>
 * @author: 须尽欢_____
 * @Data : 2021/11/3 17:40
 */
@Component
public class AppConfig implements ApplicationRunner {

    @Resource
    private RedisCache redisCache;

    public static final String REDIS_KEY = "mh_config:";
    public static final String REDIS_KEY_OVERTIME_ALLOW = "overtime_allow";
    public static final String REDIS_KEY_WORK_TIME = "work_time";
    public static final String REDIS_KEY_WORK_DAY = "work_day";
    public static final String REDIS_KEY_WORK_REVIEWS = "work_review";
    public static final String REDIS_KEY_HOUR_ZERO = "hour_zero";

    /** 是否允许加班 */
    public static boolean OVERTIME_ALLOW = false;

    /** 是否开始审核加班 */
    public static boolean WORK_REVIEWS = false;

    /** 每日工时数 */
    public static BigDecimal WORK_TIME = new BigDecimal("8");

    /** 每月工作日数 */
    public static int WORK_DAY = 22;

    /** 是否记录0工时的项目 */
    public static boolean HOUR_ZERO = false;

    @Override
    public void run(ApplicationArguments args) {

        Map<String, Object> cacheMap = redisCache.getCacheMap(REDIS_KEY);

        Boolean overtimeAllowStr = Boolean.valueOf(cacheMap.get(REDIS_KEY_OVERTIME_ALLOW).toString()) ;
        if (!Objects.isNull(overtimeAllowStr)) {
            OVERTIME_ALLOW = overtimeAllowStr;
        }

        Boolean workReview = Boolean.valueOf(cacheMap.get(REDIS_KEY_WORK_REVIEWS).toString()) ;
        if (!Objects.isNull(workReview)) {
            WORK_REVIEWS = workReview;
        }

        Boolean hourZero = Boolean.valueOf(cacheMap.get(REDIS_KEY_HOUR_ZERO).toString()) ;
        if (!Objects.isNull(hourZero)) {
            HOUR_ZERO = hourZero;
        }

        Integer workTime =Integer.parseInt(cacheMap.get(REDIS_KEY_WORK_TIME).toString());
        if (!Objects.isNull(workTime)) {
            WORK_TIME = new BigDecimal(workTime);
        }

        Integer workDay = Integer.parseInt(cacheMap.get(REDIS_KEY_WORK_DAY).toString()) ;
        if (!Objects.isNull(workDay)) {
            WORK_DAY = workDay;
        }

    }


}
