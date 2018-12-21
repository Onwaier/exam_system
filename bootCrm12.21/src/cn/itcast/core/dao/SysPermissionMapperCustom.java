package cn.itcast.core.dao;

import java.util.List;

import cn.itcast.core.bean.SysPermission;

/**
 * 权限mapper
 * 
 * */
public interface SysPermissionMapperCustom {
	//根据用户的id来查询菜单
	public List<SysPermission> findMenuListByUserId(String userid)throws Exception;
	//根据用户的id来查询权限url
	public List<SysPermission> findPermissionListByUserId(String userid)throws Exception;
}
