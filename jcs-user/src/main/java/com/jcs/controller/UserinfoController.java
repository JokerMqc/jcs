/*
 * create by yph
 * Since 2018 - 2018
 */

package com.jcs.controller;


import com.jcs.common.base.BaseController;
import com.jcs.common.base.IBaseService;
import com.jcs.common.result.CommonResult;
import com.jcs.common.utils.ShiroUtils;
import com.jcs.entity.Userinfo;
import com.jcs.service.impl.IUserinfoService;
import lombok.extern.slf4j.Slf4j;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.crypto.hash.Sha256Hash;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * @author : Administrator mqc
 * @create ：2018/1/29
 **/
@Controller
@Slf4j
@RequestMapping("/user")
public class UserinfoController extends BaseController<Userinfo> {

	@Autowired
	private IUserinfoService userinfoService;

	@Override
	public IBaseService getBaseService() {

		return (IBaseService) userinfoService;
	}

	/**
	* @Description: 用户登录
	* @return ${return_type}
	* @throws
	* @author 毛其传
	* @date 2018/3/1 17:08
	*/
	@ResponseBody
	@RequestMapping("/login.do")
	public CommonResult login(String userName, String password) {

		try {
			Subject subject = ShiroUtils.getSubject();
			password = new Sha256Hash(password).toHex();
			UsernamePasswordToken token = new UsernamePasswordToken(userName, password);
			subject.login(token);
		} catch (UnknownAccountException e) {
			log.info("帐号不存在");
			return CommonResult.ERROR(e.getMessage());
		} catch (IncorrectCredentialsException e) {
			return CommonResult.ERROR(e.getMessage());
		} catch (LockedAccountException e) {
			return CommonResult.ERROR(e.getMessage());
		} catch (Exception e) {
			return CommonResult.ERROR(e.getMessage());
		}
		return CommonResult.SUCCESS();
	}

	/**
	* @Description: 跳转到登录界面
	* @return ${return_type}
	* @throws
	* @author 毛其传
	* @date 2018/3/1 17:29
	*/
	@RequestMapping("/toLogin.do")
    public String toLogin(){

		return "login";
    }
}

