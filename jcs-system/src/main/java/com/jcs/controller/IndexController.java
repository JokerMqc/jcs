package com.jcs.controller;

import com.jcs.common.utils.ShiroUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

/**
 * @author 毛其传
 * @create 2018-03-02 11:49
 * 首页跳转控制器
 **/
@Slf4j
@Controller
public class IndexController {

    /**
    * @Description: 系统根菜单
    * @return ${return_type}
    * @throws
    * @author 毛其传
    * @date 2018/3/3 13:58
    */
    @RequestMapping("/index")
    public String begin(HttpServletRequest request) {
        if (ShiroUtils.isLogin()) {
            log.info("[校验登录]  已登录! ");
            String referer = request.getHeader("referer");
            if (referer == null) {
                return "begin";
            } else if (referer.endsWith("main.do")) {
                return "error/error404";
            }
        }
        return "user/login";
    }

    /**
    * @Description: 登录成功跳转到,跳转到首页
    * @return ${return_type}
    * @throws
    * @author 毛其传
    * @date 2018/3/3 14:42
    */
    @RequestMapping("main")
    public String index(){
        return "index/index";
    }



}
