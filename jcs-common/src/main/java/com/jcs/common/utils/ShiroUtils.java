package com.jcs.common.utils;

import com.jcs.common.entity.Userinfo;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.BeanUtils;

/**
 * @author 毛其传
 * @create 2018-02-27 15:26
 **/
public class ShiroUtils {
    /**
     *  获取 session
     * @return
     */
    public static Session getSession() {
        return SecurityUtils.getSubject().getSession();
    }

    /**
     *
     * @return
     */
    public static Subject getSubject() {
        return SecurityUtils.getSubject();
    }

    /**
     *  获取当前用户
     * @return
     */
    public static Userinfo getUser() {
        Object option = SecurityUtils.getSubject().getPrincipal();
        Userinfo sysUser = new Userinfo();
        if(option!=null){
            BeanUtils.copyProperties(option,sysUser);
        }
        return sysUser;
    }

    /**
     *  获取用户Id
     * @return
     */
    public static Integer getUserId() {

        return getUser().getId();
    }

    /**
     *  在session 设置值
     * @param key
     * @param value
     */
    public static void setSessionAttribute(Object key, Object value) {
        getSession().setAttribute(key, value);
    }

    /**
     *  获取Session 信息
     * @param key
     * @return
     */
    public static Object getSessionAttribute(Object key) {
        return getSession().getAttribute(key);
    }

    /**
     *   是否登录
     * @return
     */
    public static boolean isLogin() {
        return SecurityUtils.getSubject().getPrincipal() != null;
    }

    /**
     *  退出登录
     */
    public static void logout() {
        SecurityUtils.getSubject().logout();
    }


}
