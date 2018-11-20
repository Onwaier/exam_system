package cn.itcast.core.web.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

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
import cn.itcast.core.bean.BaseDict;
import cn.itcast.core.bean.Customer;
import cn.itcast.core.bean.Question;
import cn.itcast.core.service.CustomerService;
import cn.itcast.core.service.SystemService;
import cn.itcast.core.service.QuestionService;

import java.io.File;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import cn.itcast.core.bean.User;
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
 * <p>Company: www.itcast.cn</p> 
 * @version 1.0
 */
@Controller
public class QuestionController {
	
//	保存题目图片的位置
	private String pictureUrl;
	
	// 依赖注入
	@Autowired
	private QuestionService questionService;
	
	
	
	@RequestMapping(value = "/question")
	public String showQuestion() {
		return "redirect:/question/list.action";
	}
	
	// 获取题目列表
	@RequestMapping(value = "/question/list")
	public String list(@RequestParam(defaultValue="1")Integer page, @RequestParam(defaultValue="10")Integer rows, 
			Long qid, String subject, String type, Model model) {
		
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
	
	@RequestMapping(value = "/question/add",method={RequestMethod.POST})
	public String questionAdd(Long qid, String subject, String type, String optionA, String optionB, String optionC, String optionD,  String optionE, String optionF, String optionG, 
			String answerOption, String answerJudge, @RequestParam(value = "answerFill[]", required = false, defaultValue = "") String[] answerFills, String answerCloze, 
			String courseName, String analysis, String chapter, String knowPoint, String difficulty) {
		
		System.out.println("\n/question/add " + "  answerOption: " + answerOption + "   answerJudge: " + answerJudge + "   answerCloze: " + answerCloze);

		System.out.println("/question/add  qid: " + qid + "  optionA: " + optionE + "  optionE: " + optionE + "   type: " + type + "   difficulty: " + difficulty + "  position: " + pictureUrl + "\n");
		
		
		questionService.addQuestion(qid, subject, type, optionA, optionB, optionC, optionD, optionE, optionF, optionG, 
				answerOption,  answerJudge, answerFills, answerCloze, courseName,  analysis,  chapter,  knowPoint,  difficulty, pictureUrl);
		pictureUrl = null; //这里是否会有内存泄漏呢
		
		return "addQuestion";
	}
	
	@RequestMapping(value = "/question/add",method={RequestMethod.GET})
	public String questionAdd() {
		
		
		return "addQuestion";
	}
	
	//上传图片
	@RequestMapping(value = "/question/fileUpload",method={RequestMethod.POST})
	/*必须使用注释 @RequestParam("uploadfile")List<MultipartFile> uploadfile
	 *否则报Failed to instantiate [java.util.List]: Specified class is an interface错误 
	 * */
	public String handleFormUpload(String name, @RequestParam("uploadfile")List<MultipartFile> uploadfile, HttpServletRequest request) {

		// 如果上传文件存在
		if (!uploadfile.isEmpty() && uploadfile.size() > 0) {
			// 遍历文件
			for (MultipartFile file : uploadfile) {

				// 获取上传文件的名称
				String originalFilename = file.getOriginalFilename();
				System.out.println("文件名"+originalFilename);

				// 设置上传文件保存的地址目录
				String dirpath = request.getServletContext().getRealPath("/images");

				File filepath = new File(dirpath);
				// 如果保存文件的目录不存在，创建upload文件夹
				if (!filepath.exists()) {
					filepath.mkdirs();
				}
				// 使用UUID重新命名上传文件的名称
//				String newFilename = name + "_" + UUID.randomUUID() + "_" + originalFilename;
				String newFilename = UUID.randomUUID() + "_" + originalFilename;
                System.out.println(newFilename);
				try {
					// 使用MultipartFile的方法将文件上传到指定位置
					file.transferTo(new File(dirpath +File.separator+ newFilename));
					System.out.println("handleFormUpload 目标路径"+dirpath +File.separator+ newFilename);
					
					//定义列表保存图片保存的路径
					List<String> listpath=new ArrayList<String>();
					listpath.add(newFilename);
					 
					request.setAttribute("filenames", listpath);
					pictureUrl = new String(dirpath +File.separator+ newFilename);
				} catch (Exception e) {

					e.printStackTrace();
					return "error";

				}
			}
		}
		return "sucess";
	}
	

	@RequestMapping(value = "/question/fileUpload",method={RequestMethod.GET})
	public String handleFormUpload(){
		return "fileload";
	}
	
//	下载word模板文件
	@RequestMapping(value = "/question/downloadWord", method={RequestMethod.GET})
	public ResponseEntity<byte[]> WordDownload(String filename,
			HttpServletRequest request ) throws IOException{
		
		//指定下载文件所在的位置
		String path = request.getServletContext().getRealPath("/wordTemplate");
		
		//创建文件对象
		File file = new File(path+File.separator+filename);
		
		//设置响应头
		HttpHeaders headers=new HttpHeaders();
		
		//通知浏览器下载打开的方式
		headers.setContentDispositionFormData("attachment", filename);
		
		//以流的方式下载文件数据
		headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
		
		//responseEntity封装返回下载的数据
		return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file),headers,HttpStatus.OK);
		
		
	}	
	
//	下载图片文件
	@RequestMapping(value = "/question/downloadPicture", method={RequestMethod.GET})
	public ResponseEntity<byte[]> pictureDownload(String filename,
			HttpServletRequest request ) throws IOException{
		
		//指定下载文件所在的位置
		String path = request.getServletContext().getRealPath("/images");
		
		//创建文件对象
		File file = new File(path+File.separator+filename);
		
		//设置响应头
		HttpHeaders headers=new HttpHeaders();
		
		//通知浏览器下载打开的方式
		headers.setContentDispositionFormData("attachment", filename);
		
		//以流的方式下载文件数据
		headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
		
		//responseEntity封装返回下载的数据
		return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file),headers,HttpStatus.OK);
		
		
	}	
	
//	显示存储目录的文件，这里主要是显示模板
    @RequestMapping(value = "/question/showFile")
    public String showFile(HttpServletRequest request,Model m){
        ServletContext servletContext = request.getServletContext();
        String path=servletContext.getRealPath("/wordTemplate");
        File[] fileList = new File(path).listFiles();
        m.addAttribute("fileList", fileList);
        return "showFile";
    }
    
    
//    word模板中的题目导入数据库  
	@RequestMapping(value = "/question/wordInput",method={RequestMethod.POST})
	/*必须使用注释 @RequestParam("uploadfile")List<MultipartFile> uploadfile
	 *否则报Failed to instantiate [java.util.List]: Specified class is an interface错误 
	 * */
	public String wordInput(String name, @RequestParam("uploadfile")List<MultipartFile> uploadfile, HttpServletRequest request) {

		// 如果上传文件存在
		if (!uploadfile.isEmpty() && uploadfile.size() > 0) {
			// 遍历文件
			for (MultipartFile file : uploadfile) {

				// 获取上传文件的名称
				String originalFilename = file.getOriginalFilename();
				System.out.println("文件名"+originalFilename);

				// 设置上传文件保存的地址目录
				String dirpath = request.getServletContext().getRealPath("/images");

				File filepath = new File(dirpath);
				// 如果保存文件的目录不存在，创建upload文件夹
				if (!filepath.exists()) {
					filepath.mkdirs();
				}
				// 使用UUID重新命名上传文件的名称
				String newFilename = name + "_" + UUID.randomUUID() + "_" + originalFilename;
                System.out.println(newFilename);
				try {
					// 使用MultipartFile的方法将文件上传到指定位置
					file.transferTo(new File(dirpath +File.separator+ newFilename));
					System.out.println("\nwordInput 目标路径"+dirpath +File.separator+ newFilename + "\n");
					questionService.addQuestionByword(dirpath +File.separator+ newFilename);
					System.out.println("wordInput 目标路径"+dirpath +File.separator+ newFilename);

				} catch (Exception e) {

					e.printStackTrace();
					return "error";

				}
			}
		}
		return "addQuestion";
	}
	
	@RequestMapping(value = "/question/wordInput",method={RequestMethod.GET})
	public String wordInput(){
		return "wordLoad";
	}
    
	
	// 修改试题
	@RequestMapping(value = "/question/edit")
	public String editQuestion(@RequestParam(defaultValue="1")Integer page, @RequestParam(defaultValue="10")Integer rows, 
			Long qid, String subject, String type, Model model) {
		
		System.out.println("/question/edit");  
		
		System.out.println(" qid: " + qid + "\n");
		Page<Question> questions = questionService.findQuestionList(page, rows, qid, subject, type);
		
		model.addAttribute("page", questions);




		return "editQuestion";
//		return "OK";
	}
	
	//批量修改试题
		@RequestMapping(value = "/question/batchEdit", method={RequestMethod.POST})
		public String batchEditQuestion(@RequestParam(defaultValue="1")Integer page, @RequestParam(defaultValue="10")Integer rows, 
				@RequestParam(value = "qids[]", required = false, defaultValue = "")Long[] qids, String subject, String type, Model model) {
			
			System.out.println("/question/batchEdit");  
			
			System.out.println(" qids: " + Arrays.toString(qids) + "\n");
			Page<Question> questions = questionService.findQuestionListByIds(page, rows, qids);
			
			model.addAttribute("page", questions);




			return "batchEditQuestion";
//			return "OK";
		}
		
		//批量修改试题
			@RequestMapping(value = "/question/batchEdit", method={RequestMethod.GET})
			public String batchEditQuestion(@RequestParam(defaultValue="1")Integer page, @RequestParam(defaultValue="10")Integer rows, 
					@RequestParam(value = "qids[]", required = false, defaultValue = "")Long[] qids, Model model) {
				
				System.out.println("/question/batchEdit");  
				
				System.out.println(" qids: " + Arrays.toString(qids) + "\n");
				Page<Question> questions = questionService.findQuestionListByIds(page, rows, qids);
				
				model.addAttribute("page", questions);




				return "batchEditQuestion";
//				return "OK";
			}
		
		//更新试题
		@RequestMapping(value = "/question/update", method={RequestMethod.POST})
		public String questionUpdate(String qid, String subject, String type, String optionA, String optionB, String optionC, String optionD,  String optionE, String optionF, String optionG, 
				String answerOption, String answerJudge, @RequestParam(value = "answerFill[]", required = false, defaultValue = "") String[] answerFills, String answerCloze, 
				String courseName, String analysis, String chapter, String knowPoint, String difficulty, String pictureUrl) {
			questionService.updateQuestion(qid, subject, type, optionA, optionB, optionC, optionD, optionE, optionF, optionG, 
					answerOption,  answerJudge, answerFills, answerCloze, courseName,  analysis,  chapter,  knowPoint,  difficulty, pictureUrl);
			return "redirect:/question/list.action";
		}
		
		@RequestMapping(value = "/question/update", method={RequestMethod.GET})
		public String questionUpdate(){
			return "OK";
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
