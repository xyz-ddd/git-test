package com.oaker.web.controller.system;

import com.oaker.common.annotation.Log;
import com.oaker.common.core.domain.AjaxResult;
import com.oaker.common.enums.BusinessType;
import com.oaker.system.service.impl.SysInfoConfigServiceImpl;
import org.apache.commons.lang3.StringUtils;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;

/**
 * @Description : 系统信息设置
 * <功能详细描述>
 * @author: 须尽欢_____
 * @Data : 2021/11/3 11:35
 */
@RestController
@RequestMapping("/system/info/config")
public class SysInfoConfigController {

    @Resource
    private SysInfoConfigServiceImpl sysInfoConfigService;

    /**
     * 查询系统信息
     * @return
     */
    @GetMapping("/get")
    public AjaxResult get() {
        return AjaxResult.success(sysInfoConfigService.getInfo());
    }

    /**
     * 修改系统信息
     * @param loginName
     * @param appName
     * @return
     */
    @PutMapping("/edit")
    @PreAuthorize("@ss.hasPermi('system:info:config:edit')")
    @Log(title = "系统信息修改", businessType = BusinessType.UPDATE)
    public AjaxResult update(String loginName, String appName) {
        return AjaxResult.error("该版本不包含此功能");
    }

    /**
     * 上传logo
     */
    @PostMapping("/logo/upload")
    @PreAuthorize("@ss.hasPermi('system:info:config:edit')")
    @Log(title = "系统信息修改上传logo", businessType = BusinessType.UPDATE)
    public AjaxResult uploadLogo(MultipartFile file) {
        return AjaxResult.error("该版本不包含此功能");
    }



}
