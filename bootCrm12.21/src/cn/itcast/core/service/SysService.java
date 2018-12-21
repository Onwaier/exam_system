package cn.itcast.core.service;

import java.util.List;

import cn.itcast.core.bean.ActiveUser;
import cn.itcast.core.bean.SysPermission;
import cn.itcast.core.bean.SysUser;

public interface SysService {
	

	
	/**
	 * 
	 * <p>Title: authenticat</p>
	 * <p>Description:用户认证 </p>
	 * @param usercode 用户账号
	 * @param password 用户密码 
	 * @return ActiveUser 用户身份信息
	 * @throws Exception
	 */
	
	//根据用户的身份密码进行认证，如果认证通过，返回用户身份信息
	public ActiveUser authenticat(String usercode, String password)throws Exception; 
	//根据用户账号查询用户信息
	public SysUser findSysUserByUserCode(String usercode)throws Exception;
	//根据用户的Id查询权限范围菜单
	public List<SysPermission> findMenuListByUserId(String userid)throws Exception;
	//根据用户的id查询权限范围的url
	public List<SysPermission> findPermissionListByUserId(String userid)throws Exception;
	
}
