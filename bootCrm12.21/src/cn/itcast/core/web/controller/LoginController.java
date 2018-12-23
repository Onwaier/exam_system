package cn.itcast.core.web.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import cn.itcast.common.utils.Page;
import cn.itcast.core.bean.ActiveUser;
import cn.itcast.core.bean.BaseDict;
import cn.itcast.core.bean.Customer;
import cn.itcast.core.bean.Question;
import cn.itcast.core.bean.SysUser;
import cn.itcast.core.service.CustomerService;
import cn.itcast.core.service.SysService;
import net.sf.json.JSONArray;
import cn.itcast.core.service.QuestionService;

import java.io.File;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

/**
 * 客户管理
 * <p>Title: CustomerController</p>
 * <p>Description: </p>
 * @version 1.0
 */
@Controller
public class LoginController {
	
//	保存题目图片的位置
	private String pictureUrl;
	
	// 依赖注入
	@Autowired
	private SysService sysService;
	//登陆提交地址，和applicationContext-shiro.xml中配置的loginurl一致
	@RequestMapping(value = "login")
	public String login(HttpServletRequest request)throws Exception{
		
		//如果登陆失败从request中获取认证异常信息,shiroLoginFailure就是异常类的权限类名
		String exceptionClassName = (String) request.getAttribute("shiroLoginFailure");
		//根据shiro返回的异常类路径判断，抛出指定异常信息
		if(exceptionClassName!=null){
			if (UnknownAccountException.class.getName().equals(exceptionClassName)) {
				//最终会抛给异常处理器
				throw new CustomException("账号不存在");
			} else if (IncorrectCredentialsException.class.getName().equals(
					exceptionClassName)) {
				throw new CustomException("用户名/密码错误");
			}else if("randomCodeError".equals(exceptionClassName)){
				throw new CustomException("验证码错误");
			}else{
				throw new Exception();//最终在异常处理器生成未知错误
			}	
		}

		//此方法不处理登陆成功，shiro认证成功，会自动跳转跳转到上一个请求路径

		//登陆失败还到login页面
		return "login";
	}
	
	//用户退出
		@RequestMapping("/logout")
		public String logout(HttpSession session)throws Exception{
			
			//session失效
			session.invalidate();
			//重定向到商品查询页面
			return "redirect:/login.action";
			
		}
	
		//获取当前登陆用户的名称
		@RequestMapping("/login/getUserName")
		@ResponseBody
		public String getUserName()throws Exception {
			System.out.println("/login/getUserName");
			ActiveUser activeUser  = (ActiveUser)SecurityUtils.getSubject().getPrincipal(); 
			JSONArray json = JSONArray.fromObject(activeUser);//将java对象转换为json对象
			String str = json.toString();//将json对象转换为字符串
			System.out.println(str);
			return str;

		}

}
