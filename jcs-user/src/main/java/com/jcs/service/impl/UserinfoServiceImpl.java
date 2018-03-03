package com.jcs.service.impl;/*
 * create by yph
 * Since 2018 - 2018
 */

import com.jcs.common.base.BaseMapper;
import com.jcs.common.base.BaseServiceImpl;
import com.jcs.entity.Userinfo;
import com.jcs.mapper.UserinfoMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


/**
 * 业务逻辑实现
 * @author admin
 */
@Service
@Slf4j
public class UserinfoServiceImpl extends BaseServiceImpl<Userinfo> implements IUserinfoService {

	@Autowired
	private UserinfoMapper userinfoMapper;

	@Override
	public BaseMapper<Userinfo> getBaseMapper() {
		return userinfoMapper;
	}




	@Override
	public Userinfo findUserByNameAndPassword(Userinfo userinfo) {
		return userinfoMapper.findUserByNameAndPassword(userinfo);
	}
}
