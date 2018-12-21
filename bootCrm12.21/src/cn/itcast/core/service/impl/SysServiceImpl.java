package cn.itcast.core.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import cn.itcast.core.dao.SysPermissionMapper;
import cn.itcast.core.dao.SysPermissionMapperCustom;
import cn.itcast.core.dao.SysUserMapper;
import cn.itcast.core.bean.ActiveUser;
import cn.itcast.core.bean.SysPermission;
import cn.itcast.core.bean.SysPermissionExample;
import cn.itcast.core.bean.SysUser;
import cn.itcast.core.bean.SysUserExample;
import cn.itcast.core.service.SysService;
import cn.itcast.core.web.controller.CustomException;
import cn.itcast.common.utils.MD5;

public class SysServiceImpl implements SysService {
	@Autowired
	private SysUserMapper sysUserMapper;
	@Autowired
	private SysPermissionMapperCustom sysPermissionMapperCustom;
	@Override
	public ActiveUser authenticat(String usercode, String password)
			throws Exception {
		
		//账号和密码非空校验 
		//....
		SysUser sysUser = this.findSysUserByUserCode(usercode);
		
		if(sysUser == null) {
			throw new CustomException("用户账号不存在！");
		}
		//密码 
		String password_db = sysUser.getPassword();
		//输入 密码 和数据库密码 比较
		String password_input_md5= new MD5().getMD5ofStr(password);
		if(!password_input_md5.equalsIgnoreCase(password_db)){
			throw new CustomException("账号或密码 错误 ！");
		}
		
		//得到用户的id
		String userid=sysUser.getId();
		//根据用户id查菜单
		List<SysPermission> menus =this.findMenuListByUserId(userid);
		//根据用户id查询权限url
		List<SysPermission> permissions =this.findPermissionListByUserId(userid);
		
		//认证通过，返回用户身份
		ActiveUser activeUser = new ActiveUser();
		activeUser.setUserid(sysUser.getId());
		activeUser.setUsername(sysUser.getUsername());
		activeUser.setUsercode(sysUser.getUsercode());
		//放入权限范围的菜单和url
		activeUser.setMenus(menus);
		activeUser.setPermissions(permissions);
		
		return activeUser;
	}
	
	public SysUser findSysUserByUserCode(String usercode)throws Exception{
		SysUserExample sysUserExample = new SysUserExample();
		SysUserExample.Criteria criteria = sysUserExample.createCriteria();
		criteria.andUsercodeEqualTo(usercode);
		
		List<SysUser> userList = sysUserMapper.selectByExample(sysUserExample);
		
		if(userList == null || userList.size()==1){
			return userList.get(0);
		}
		return null;
		
	}

	
	
	
	
	@Override
	public List<SysPermission> findMenuListByUserId(String userid) throws Exception {
		// TODO Auto-generated method stub
		return sysPermissionMapperCustom.findMenuListByUserId(userid);
	}

	@Override
	public List<SysPermission> findPermissionListByUserId(String userid) throws Exception {
		// TODO Auto-generated method stub
		return sysPermissionMapperCustom.findPermissionListByUserId(userid);
	}

}
