package com.oaker.hours.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.oaker.hours.doman.entity.MhConfig;
import com.oaker.hours.doman.entity.MhCost;
import com.oaker.system.domain.SysConfig;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @description: 功能描述
 * 功能说明：
 * @className: MhConfigMapper
 * @author: sixfly
 * @date: 2023-11-02 0002 15:17
 */


@Mapper
public interface MhConfigMapper  extends BaseMapper<MhConfig> {


    public int updateConfig(MhConfig config);

    public List<MhConfig> selectConfigList();

    public MhConfig selectByKey(@Param("keyName") String keyname);

}
