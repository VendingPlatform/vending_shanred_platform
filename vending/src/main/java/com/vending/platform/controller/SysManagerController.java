package com.vending.platform.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Description;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.vending.platform.domain.FirmInfo;
import com.vending.platform.domain.UserInfo;
import com.vending.platform.service.IFirmAndGroupService;

@Controller
@SessionAttributes("user")
@RequestMapping("/manager")
public class SysManagerController extends UtilsAction {
    private static final long serialVersionUID = -5466394451153962610L;
    @Autowired
    private IFirmAndGroupService firmAndGroupService;

    @Description("获取所有商家信息")
    @RequestMapping(value = "/getAllFirms")
    public String getAllFirms(FirmInfo firmInfo, ModelMap map) {
    	firmInfo.setFirmType(1);
        List<FirmInfo> allFirmInfos = firmAndGroupService
                .getAllFirmInfos(firmInfo);
        map.addAttribute("allFirmInfos", allFirmInfos);
        return "genview/ManagerFirm";
    }

    @Description("按Id获取商家信息")
    @RequestMapping(value = "/getFirmInfo", method = RequestMethod.GET)
    public String getFirmById(Integer firmId, ModelMap modelMap) {
        FirmInfo firmInfo = firmAndGroupService.getFirmInfoById(firmId);
        modelMap.addAttribute("firmInfo", firmInfo);
        return "genview/MFirmUpdate";
    }

    @Description("更新商家信息")
    @RequestMapping(value = "/updateFirmInfo", method = RequestMethod.POST)
    public String updateFirmInfo(FirmInfo firmInfo, ModelMap modelMap) {
        firmAndGroupService.updateFirm(firmInfo);
        return "redirect:/manager/getAllFirms";
    }

    @Description("添加商家")
    @RequestMapping(value = "/createFirmInfo", method = RequestMethod.POST)
    public String createFirmInfo(FirmInfo firmInfo,@ModelAttribute("user") UserInfo user) {
        boolean flag = firmAndGroupService.insertFirm(firmInfo,user);
        try {
            write(flag);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return "genview/ManagerFirm";
    }

    @Description("删除商家信息")
    @RequestMapping(value = "/deleteFirmInfo")
    public String deleteFirm(Integer firmId, ModelMap modelMap) {
        firmAndGroupService.deleteFirmInfo(firmId);
        return "redirect:/manager/getAllFirms";
    }
}
