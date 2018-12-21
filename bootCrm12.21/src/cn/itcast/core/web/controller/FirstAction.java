package cn.itcast.core.web.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import cn.itcast.core.bean.ActiveUser;
import cn.itcast.core.bean.SysPermission;

@Controller
public class FirstAction {
	//系统首页
	@RequestMapping("/first")
	public String first(Model model)throws Exception{
		
		//从shiro的session中取activeUser
		Subject subject = SecurityUtils.getSubject();
		//取身份信息
		ActiveUser activeUser=(ActiveUser) subject.getPrincipal();
		//通过model传到页面
		model.addAttribute("activeUser",activeUser);
		
		return "/first";
	}
	
//	//欢迎页面
//	@RequestMapping("/welcome")
//	public String welcome(Model model)throws Exception{
//		
//		return "welcome";
//		
//	}
}	
