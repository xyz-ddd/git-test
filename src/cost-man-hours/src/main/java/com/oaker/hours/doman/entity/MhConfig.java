package com.oaker.hours.doman.entity;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
import com.oaker.common.annotation.Excel;
import com.oaker.common.core.domain.BaseEntity;
import lombok.Data;
import lombok.experimental.Accessors;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

/**
 * @description: 功能描述
 * 功能说明：
 * @className: MhConfig
 * @author: sixfly
 * @date: 2023-11-02 0002 14:48
 */


@Data
@Accessors(chain = true)
@TableName("mh_config")
public class MhConfig  extends BaseEntity {
 /** id */
 @TableId(value = "id", type = IdType.AUTO)
 private Long id;


 @TableId(value = "config_key")
 private String configKey;

 /**
  * 参数键值
  */
 @TableId(value = "config_value")
 private String configValue;

 public MhConfig(String configKey) {
  this.configKey = configKey;
 }

 public MhConfig() {
 }
}
