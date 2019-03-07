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
import org.springframework.web.context.ContextLoader;
import org.springframework.web.multipart.MultipartFile;

import cn.itcast.common.utils.Page;
import cn.itcast.core.bean.BaseDict;
import cn.itcast.core.bean.Course;
import cn.itcast.core.bean.Customer;
import cn.itcast.core.bean.Question;
import cn.itcast.core.dao.PaperDao;
import cn.itcast.core.service.CustomerService;
import cn.itcast.core.service.PaperService;
import cn.itcast.core.service.QuestionService;
import net.sf.json.JSONArray;

import java.io.File;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;

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
 * 题目管理
 * <p>Title: CustomerController</p>
 * <p>Description: </p>
 * <p>Company: www.itcast.cn</p> 
 * @version 1.0
 */
@Controller
public class QuestionController {
	
//	保存题目图片的位置
	private String pictureUrl = "";
	private String lastPictureUrl = ""; //存储当前待编辑题目的图片
	private int index = 0;
	boolean flag = true; //第一张图片的标识
	List<Course> course;
	
	// 依赖注入
	@Autowired
	private QuestionService questionService;
	@Autowired
	private PaperDao paperDao;
	
	@Autowired
	private PaperService paperService;
	
	
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
	public String questionAdd(Model model, Long qid, String subject, String type, String optionA, String optionB, String optionC, String optionD,  String optionE, String optionF, String optionG, 
			String answerOption, String answerJudge, @RequestParam(value = "answerFill[]", required = false, defaultValue = "") String[] answerFills, String answerCloze, 
			String course, String analysis, String chapter, String knowPoint, String difficulty, String score, String spendTime, @RequestParam(value = "uploadfile", required = false, defaultValue = "")List<MultipartFile> uploadfile, HttpServletRequest request) {

		String[] pic = new String[5];
		System.out.println("\n/question/add " + "  answerOption: " + answerOption + "   answerJudge: " + answerJudge + "   answerCloze: " + answerCloze + "   course:" + course);
	
		
//		处理题目中的图片
		// 如果上传文件存在
		if (!uploadfile.isEmpty() && uploadfile.size() > 0) {
			// 遍历文件
			for (MultipartFile file : uploadfile) {

				// 获取上传文件的名称
				String originalFilename = file.getOriginalFilename();
				System.out.println("文件名："+originalFilename);

				// 设置上传文件保存的地址目录
				String dirpath = request.getServletContext().getRealPath("");
				String[] temp = dirpath.split("\\\\");
				int mark = dirpath.indexOf(".metadata");
				dirpath = dirpath.substring(0, mark) + temp[temp.length-1];
				dirpath = dirpath + "\\questionImg";

				System.out.println(dirpath);
				File filepath = new File(dirpath);
				// 如果保存文件的目录不存在，创建upload文件夹
				if (!filepath.exists()) {
					filepath.mkdirs();
				}
				// 使用UUID重新命名上传文件的名称
//						String newFilename = name + "_" + UUID.randomUUID() + "_" + originalFilename;
				String newFilename = UUID.randomUUID() + "_" + originalFilename;
                System.out.println(newFilename);
				try {
					System.out.println("目标路径："+dirpath + File.separator+ newFilename);

					
					if(originalFilename.equals("")){
						pic[index] = "null"; ++index;
					}
					else{
						// 使用MultipartFile的方法将文件上传到指定位置

						file.transferTo(new File(dirpath + File.separator+ newFilename));
						pic[index] = dirpath  + File.separator+ newFilename; ++index;
					}
					
				} catch (Exception e) {

					e.printStackTrace();
					return "error";

				}
			}
		}
		index = 0;
		pictureUrl = pic[0] + '&' + pic[1];

		System.out.println("/question/add  qid: " + qid + "  optionA: " + optionE + "  optionE: " + optionE + "   type: " + type + "   difficulty: " + difficulty + "  position: " + pictureUrl + "\n");
		
		questionService.addQuestion(qid, subject, type, optionA, optionB, optionC, optionD, optionE, optionF, optionG, 
				answerOption,  answerJudge, answerFills, answerCloze, course,  analysis, chapter,  knowPoint,  difficulty, pictureUrl, score, spendTime);
		pictureUrl = null; //这里应该不会有内存泄漏
		index = 0;
		flag = true;
		
		
		ArrayList<String> Cour = new ArrayList<String>();
		ArrayList<ArrayList<String>> Chapter = new ArrayList<ArrayList<String>>();
		ArrayList<ArrayList<ArrayList<String>>> Konw = new ArrayList<ArrayList<ArrayList<String>>>();
		List<Course> courseList;
		courseList = paperService.findCourseList();
		ArrayList<String> chapterList = null;
		ArrayList<String> knowpointList = null;
		for(int i = 0; i < courseList.size(); ++i){
			Cour.add(courseList.get(i).getCourseName());
			chapterList = paperDao.selectChapterList((courseList.get(i).getCourseId().intValue()));
			Chapter.add(chapterList);
			
			ArrayList<ArrayList<String>> tempKonw = new ArrayList<ArrayList<String>>();
			for(String chapter1 : chapterList){
				knowpointList = paperDao.selectKnowpointList((courseList.get(i).getCourseId().intValue()), chapter1);
				tempKonw.add(knowpointList);
			}
			Konw.add(tempKonw);

		}
		
//		for(int i = 0;i < Chapter.size(); i ++){
//            System.out.println(Chapter.get(i));
//        }
//		for(int i = 0;i < Konw.size(); i ++){
//            System.out.println(Konw.get(i));
//        }
		 	
		

		model.addAttribute("course", JSONArray.fromObject(Cour));
		model.addAttribute("chapter", JSONArray.fromObject(Chapter));
		model.addAttribute("knowpoint", JSONArray.fromObject(Konw));
		
		
		return "addQuestion";
	}
	
	@RequestMapping(value = "/question/add",method={RequestMethod.GET})
	public String questionAdd(Model model) {
		ArrayList<String> Cour = new ArrayList<String>();
		ArrayList<ArrayList<String>> Chapter = new ArrayList<ArrayList<String>>();
		ArrayList<ArrayList<ArrayList<String>>> Konw = new ArrayList<ArrayList<ArrayList<String>>>();
		course = paperService.findCourseList();
		ArrayList<String> chapterList = null;
		ArrayList<String> knowpointList = null;
		for(int i = 0; i < course.size(); ++i){
			Cour.add(course.get(i).getCourseName());
			chapterList = paperDao.selectChapterList((course.get(i).getCourseId().intValue()));
			Chapter.add(chapterList);
			
			ArrayList<ArrayList<String>> tempKonw = new ArrayList<ArrayList<String>>();
			for(String chapter : chapterList){
				knowpointList = paperDao.selectKnowpointList((course.get(i).getCourseId().intValue()), chapter);
				tempKonw.add(knowpointList);
			}
			Konw.add(tempKonw);

		}
		
//		for(int i = 0;i < Chapter.size(); i ++){
//            System.out.println(Chapter.get(i));
//        }
//		for(int i = 0;i < Konw.size(); i ++){
//            System.out.println(Konw.get(i));
//        }
		 	
		
		System.out.println("/question/add:  " + course.get(0).getCourseName());
		model.addAttribute("course", JSONArray.fromObject(Cour));
		model.addAttribute("chapter", JSONArray.fromObject(Chapter));
		model.addAttribute("knowpoint", JSONArray.fromObject(Konw));

		
		return "addQuestion";
	}
	
	//通过excel录入题目
 	@RequestMapping(value = "/question/excelAdd",method={RequestMethod.POST})
 	@ResponseBody
 	public String questionAddByExcel(Long qid, String subject, String type, String optionA, String optionB, String optionC, String optionD,  String optionE, String optionF, String optionG, 
 			String answerOption, String answerJudge, @RequestParam(value = "answerFill[]", required = false, defaultValue = "") String[] answerFills, String answerCloze, 
 			String courseName, String analysis, String chapter, String knowPoint, String difficulty, HttpServletRequest request, String score, String spendTime) {
 
  		System.out.println("\n/question/excelAdd " + "  answerOption: " + answerOption + "   answerJudge: " + answerJudge + "   answerCloze: " + answerCloze);
 
  
  		System.out.println("/question/excelAdd  qid: " + qid + "  optionA: " + optionE + "  optionE: " + optionE + "   type: " + type + "   difficulty: " + difficulty + "  position: " + pictureUrl + "\n");
 
  		if(questionService.addQuestion(qid, subject, type, optionA, optionB, optionC, optionD, optionE, optionF, optionG, 
 				answerOption,  answerJudge, answerFills, answerCloze, courseName,  analysis,  chapter,  knowPoint,  difficulty, pictureUrl,  score, spendTime) == true){
 			pictureUrl = null; //这里应该不会有内存泄漏
 			flag = true;
 			return "success";
 		}
 		else{
 			return "fail";
 		}
 	}
	
	//上传图片
	@RequestMapping(value = "/question/fileUpload",method={RequestMethod.POST})
	/*必须使用注释 @RequestParam("uploadfile")List<MultipartFile> uploadfile
	 *否则报Failed to instantiate [java.util.List]: Specified class is an interface错误 
	 * */
//	@ResponseBody
	public String handleFormUpload(String name, @RequestParam("uploadfile")List<MultipartFile> uploadfile, HttpServletRequest request) {

		// 如果上传文件存在
		if (!uploadfile.isEmpty() && uploadfile.size() > 0) {
			// 遍历文件
			for (MultipartFile file : uploadfile) {

				// 获取上传文件的名称
				String originalFilename = file.getOriginalFilename();
//				System.out.println("文件名"+originalFilename);

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
					System.out.println("handleFormUpload 目标路径："+dirpath +File.separator+ newFilename);
					
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
//		return "sucess";
		return "OK";
	}
	

//	@RequestMapping(value = "/question/fileUpload",method={RequestMethod.GET})
//	public void handleFormUpload(){
////		return "fileload";
//	}
	
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
					questionService.addQuestionByword(request, dirpath +File.separator+ newFilename);
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
		
		if(StringUtils.isNotBlank(questions.getRows().get(0).getPictureUrl())){
			lastPictureUrl = questions.getRows().get(0).getPictureUrl();
			String[] pic = questions.getRows().get(0).getPictureUrl().split("&");
			String[] subjectPic = pic[0].split("\\\\");
			String[] answerPic = pic[1].split("\\\\");
			model.addAttribute("subjectPic", subjectPic[subjectPic.length-1]);
			model.addAttribute("answerPic", answerPic[answerPic.length-1]);
		}
		
		ArrayList<String> Cour = new ArrayList<String>();
		ArrayList<ArrayList<String>> Chapter = new ArrayList<ArrayList<String>>();
		ArrayList<ArrayList<ArrayList<String>>> Konw = new ArrayList<ArrayList<ArrayList<String>>>();
		List<Course> courseList;
		courseList = paperService.findCourseList();
		ArrayList<String> chapterList = null;
		ArrayList<String> knowpointList = null;
		for(int i = 0; i < courseList.size(); ++i){
			Cour.add(courseList.get(i).getCourseName());
			chapterList = paperDao.selectChapterList((courseList.get(i).getCourseId().intValue()));
			Chapter.add(chapterList);
			
			ArrayList<ArrayList<String>> tempKonw = new ArrayList<ArrayList<String>>();
			for(String chapter1 : chapterList){
				knowpointList = paperDao.selectKnowpointList((courseList.get(i).getCourseId().intValue()), chapter1);
				tempKonw.add(knowpointList);
			}
			Konw.add(tempKonw);

		}
		
//		for(int i = 0;i < Chapter.size(); i ++){
//            System.out.println(Chapter.get(i));
//        }
//		for(int i = 0;i < Konw.size(); i ++){
//            System.out.println(Konw.get(i));
//        }
		 	
		

		model.addAttribute("course", JSONArray.fromObject(Cour));
		model.addAttribute("chapter", JSONArray.fromObject(Chapter));
		model.addAttribute("knowpoint", JSONArray.fromObject(Konw));
		
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
			
			ArrayList<String> Cour = new ArrayList<String>();
			ArrayList<ArrayList<String>> Chapter = new ArrayList<ArrayList<String>>();
			ArrayList<ArrayList<ArrayList<String>>> Konw = new ArrayList<ArrayList<ArrayList<String>>>();
			List<Course> courseList;
			courseList = paperService.findCourseList();
			ArrayList<String> chapterList = null;
			ArrayList<String> knowpointList = null;
			for(int i = 0; i < courseList.size(); ++i){
				Cour.add(courseList.get(i).getCourseName());
				chapterList = paperDao.selectChapterList((courseList.get(i).getCourseId().intValue()));
				Chapter.add(chapterList);
				
				ArrayList<ArrayList<String>> tempKonw = new ArrayList<ArrayList<String>>();
				for(String chapter1 : chapterList){
					knowpointList = paperDao.selectKnowpointList((courseList.get(i).getCourseId().intValue()), chapter1);
					tempKonw.add(knowpointList);
				}
				Konw.add(tempKonw);

			}
			
//			for(int i = 0;i < Chapter.size(); i ++){
//	            System.out.println(Chapter.get(i));
//	        }
//			for(int i = 0;i < Konw.size(); i ++){
//	            System.out.println(Konw.get(i));
//	        }
			 	
			

			model.addAttribute("course", JSONArray.fromObject(Cour));
			model.addAttribute("chapter", JSONArray.fromObject(Chapter));
			model.addAttribute("knowpoint", JSONArray.fromObject(Konw));
			
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
				
				ArrayList<String> Cour = new ArrayList<String>();
				ArrayList<ArrayList<String>> Chapter = new ArrayList<ArrayList<String>>();
				ArrayList<ArrayList<ArrayList<String>>> Konw = new ArrayList<ArrayList<ArrayList<String>>>();
				List<Course> courseList;
				courseList = paperService.findCourseList();
				ArrayList<String> chapterList = null;
				ArrayList<String> knowpointList = null;
				for(int i = 0; i < courseList.size(); ++i){
					Cour.add(courseList.get(i).getCourseName());
					chapterList = paperDao.selectChapterList((courseList.get(i).getCourseId().intValue()));
					Chapter.add(chapterList);
					
					ArrayList<ArrayList<String>> tempKonw = new ArrayList<ArrayList<String>>();
					for(String chapter1 : chapterList){
						knowpointList = paperDao.selectKnowpointList((courseList.get(i).getCourseId().intValue()), chapter1);
						tempKonw.add(knowpointList);
					}
					Konw.add(tempKonw);

				}
				
//				for(int i = 0;i < Chapter.size(); i ++){
//		            System.out.println(Chapter.get(i));
//		        }
//				for(int i = 0;i < Konw.size(); i ++){
//		            System.out.println(Konw.get(i));
//		        }
				 	
				

				model.addAttribute("course", JSONArray.fromObject(Cour));
				model.addAttribute("chapter", JSONArray.fromObject(Chapter));
				model.addAttribute("knowpoint", JSONArray.fromObject(Konw));
				
				model.addAttribute("page", questions);


				

				return "batchEditQuestion";
//				return "OK";
			}
		

		//更新试题
		@RequestMapping(value = "/question/update", method={RequestMethod.POST})
		public String questionUpdate(String qid, String subject, String type, String optionA, String optionB, String optionC, String optionD,  String optionE, String optionF, String optionG, 
				String answerOption, String answerJudge, @RequestParam(value = "answerFill[]", required = false, defaultValue = "") String[] answerFills, String answerCloze, 
				String courseName, String analysis, String chapter, String knowPoint, String difficulty, String deleteSubjectPic, String deleteAnswerPic, @RequestParam(value = "uploadfile", required = false, defaultValue = "")List<MultipartFile> uploadfile, HttpServletRequest request) {
			System.out.println("/question/update: " + deleteSubjectPic + "   " + deleteAnswerPic);
			String[] pic = new String[5];
//			处理题目中的图片
			// 如果上传文件存在
			if (!uploadfile.isEmpty() && uploadfile.size() > 0) {
				// 遍历文件
				for (MultipartFile file : uploadfile) {

					// 获取上传文件的名称
					String originalFilename = file.getOriginalFilename();
					System.out.println("文件名："+originalFilename);

					// 设置上传文件保存的地址目录
					String dirpath = request.getServletContext().getRealPath("");
					String[] temp = dirpath.split("\\\\");
					int mark = dirpath.indexOf(".metadata");
					dirpath = dirpath.substring(0, mark) + temp[temp.length-1];
					dirpath = dirpath + "\\questionImg";
					System.out.println(dirpath);
					File filepath = new File(dirpath);
					// 如果保存文件的目录不存在，创建upload文件夹
					if (!filepath.exists()) {
						filepath.mkdirs();
					}
					// 使用UUID重新命名上传文件的名称
//							String newFilename = name + "_" + UUID.randomUUID() + "_" + originalFilename;
					String newFilename = UUID.randomUUID() + "_" + originalFilename;
	                System.out.println(newFilename);
					try {
						System.out.println("目标路径："+dirpath  +File.separator+ newFilename);
						
						if(originalFilename.equals("")){
							pic[index] = "null"; ++index;
						}
						else{
							// 使用MultipartFile的方法将文件上传到指定位置
							file.transferTo(new File(dirpath  + File.separator+ newFilename));
							pic[index] = dirpath  + File.separator+ newFilename; ++index;
						}
						
					} catch (Exception e) {

						e.printStackTrace();
						return "error";

					}
				}
			}
					
			index = 0;
			System.out.println("/question/update: \n" + lastPictureUrl + "\n" + pictureUrl);		
			if(StringUtils.isNotBlank(lastPictureUrl)){
				String[] oldPic = lastPictureUrl.split("&");
				
//				System.out.println(oldPic[0] + "\n" + oldPic[1] + "\n" + pic[0] + "\n" + pic[1]);
				if(!pic[0].equals("null")) oldPic[0] = pic[0];
				if(!pic[1].equals("null")) oldPic[1] = pic[1];
				if(StringUtils.isNotBlank(deleteSubjectPic)) oldPic[0] = "null";
				if(StringUtils.isNotBlank(deleteAnswerPic)) oldPic[1] = "null";
				pictureUrl = oldPic[0] + '&' + oldPic[1];
			}else{
				if(StringUtils.isNotBlank(deleteSubjectPic)) pic[0] = "null";
				if(StringUtils.isNotBlank(deleteAnswerPic)) pic[1] = "null";
				pictureUrl = pic[0] + '&' + pic[1];
			}
			
			
			
			System.out.println(pictureUrl);		
			questionService.updateQuestion(qid, subject, type, optionA, optionB, optionC, optionD, optionE, optionF, optionG, 
					answerOption,  answerJudge, answerFills, answerCloze, courseName,  analysis,  chapter,  knowPoint,  difficulty, pictureUrl);
			pictureUrl = null; //这里应该不会有内存泄漏
			index = 0;
			return "redirect:/question/list.action";
		}
		
		@RequestMapping(value = "/question/update", method={RequestMethod.GET})
		public String questionUpdate(){
			return "OK";
		}
		
		
		//更新试题
				@RequestMapping(value = "/question/batchUpdate", method={RequestMethod.POST})
				public String questionBatchUpdate(String qid, String subject, String type, String optionA, String optionB, String optionC, String optionD,  String optionE, String optionF, String optionG, 
						String answerOption, String answerJudge, @RequestParam(value = "answerFill[]", required = false, defaultValue = "") String[] answerFills, String answerCloze, 
						String courseName, String analysis, String chapter, String knowPoint, String difficulty, String deleteSubjectPic, String deleteAnswerPic, HttpServletRequest request) {
					System.out.println("/question/batchUpdate: " + deleteSubjectPic + "   " + deleteAnswerPic);
					String[] pic = new String[5];
					System.out.println(pictureUrl);		
					questionService.updateQuestion(qid, subject, type, optionA, optionB, optionC, optionD, optionE, optionF, optionG, 
							answerOption,  answerJudge, answerFills, answerCloze, courseName,  analysis,  chapter,  knowPoint,  difficulty, pictureUrl);
					pictureUrl = null; //这里应该不会有内存泄漏
					index = 0;
					return "redirect:/question/list.action";
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