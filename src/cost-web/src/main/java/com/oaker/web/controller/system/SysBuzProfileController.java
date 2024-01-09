package com.oaker.web.controller.system;

import com.oaker.common.annotation.Log;
import com.oaker.common.config.OakerConfig;
import com.oaker.common.constant.UserConstants;
import com.oaker.common.core.controller.BaseController;
import com.oaker.common.core.domain.AjaxResult;
import com.oaker.common.core.domain.entity.SysUser;
import com.oaker.common.core.domain.model.LoginUser;
import com.oaker.common.enums.BusinessType;
import com.oaker.common.utils.SecurityUtils;
import com.oaker.common.utils.ServletUtils;
import com.oaker.common.utils.StringUtils;
import com.oaker.common.utils.file.FileUploadUtils;
import com.oaker.framework.web.service.TokenService;
import com.oaker.system.domain.vo.SysAppConfigVo;
import com.oaker.system.service.ISysUserService;
import com.oaker.system.service.impl.SysAppConfigServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import java.io.IOException;

/**
 * 业务信息 配置查询
 *
 * @author `` 须尽欢 _____
 */
@RestController
@RequestMapping("/system/biz/profile")
public class SysBuzProfileController extends BaseController {
    @Resource
    private SysAppConfigServiceImpl sysAppConfigService;

    /**
     * 个人信息
     */
    @GetMapping("/review")
    public AjaxResult Query () {
        SysAppConfigVo configVo = sysAppConfigService.get();
        return AjaxResult.success(configVo);
    }


}
