package cn.itcast.core.web.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.itcast.common.utils.Page;
import cn.itcast.core.bean.BaseDict;
import cn.itcast.core.bean.Customer;
import cn.itcast.core.bean.Question;
import cn.itcast.core.service.CustomerService;
import cn.itcast.core.service.SystemService;
import cn.itcast.core.service.QuestionService;


/**
 * 客户管理
 * <p>Title: CustomerController</p>
 * <p>Description: </p>
 * <p>Company: www.itcast.cn</p> 
 * @version 1.0
 */
@Controller
public class QuestionController {
	
	
	// 依赖注入
	@Autowired
	private QuestionService questionService;
	
	
	@RequestMapping(value = "/question")
	public String showQuestion() {
		return "redirect:/question/list.action";
	}
	
	// 题目列表
	@RequestMapping(value = "/question/list")
	public String list(@RequestParam(defaultValue="1")Integer page, @RequestParam(defaultValue="10")Integer rows, 
			Integer qid, String subject, String type, Model model) {
		
		System.out.println("/question/list");  
//		String TYPE = strArray[Integer.parseInt(type)-1];
		Page<Question> questions = questionService.findQuestionList(page, rows, qid, subject, type);
		model.addAttribute("page", questions);


/*		//参数回显
		model.addAttribute("qid", qid);
		model.addAttribute("subject", subject);
		model.addAttribute("type", type);*/

		return "question";
	}
	
	@RequestMapping("/question/delete")
	@ResponseBody
	public String questionDelete(Long id) {
		questionService.deleteQuestion(id);
		return "OK";
	}
	
	@RequestMapping("/question/add")
	public String questionAdd(Integer qid, String subject, String type, String optionA, String optionB, String optionC, String optionD,  String optionE, String optionF, String optionG, 
			String answer, String courseName, String analysis, String chapter, String knowPoint, String difficulty) {
		
		System.out.println("/question/add " + qid + " " + optionA + " " + type + " " + difficulty + " " + answer);
		
		
		questionService.addQuestion(qid, subject, type, optionA, optionB, optionC, optionD, optionE, optionF, optionG, 
				 answer,  courseName,  analysis,  chapter,  knowPoint,  difficulty);
		
		return "addQuestion";
	}
/*	
	@RequestMapping("/customer/update")
	@ResponseBody
	public String customerUpdate(Customer customer) {
		customerService.updateCustomer(customer);
		return "OK";
	}
	@RequestMapping("/customer/delete")
	@ResponseBody
	public String customerDelete(Long id) {
		customerService.deleteCustomer(id);
		return "OK";
	}*/

}
