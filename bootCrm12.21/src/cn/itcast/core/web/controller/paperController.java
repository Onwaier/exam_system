
package cn.itcast.core.web.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import cn.itcast.common.utils.ChildNode;
import cn.itcast.common.utils.Page;
import cn.itcast.common.utils.ParentNode;
import cn.itcast.core.bean.BaseDict;
import cn.itcast.core.bean.Customer;
import cn.itcast.core.bean.Paper;
import cn.itcast.core.bean.Question;
import cn.itcast.core.service.PaperService;
import net.sf.json.JSONArray;
import cn.itcast.core.service.QuestionService;

import java.io.File;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import cn.itcast.core.bean.Course;

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
 * 试卷管理
 * <p>Title: PaperController</p>
 * <p>Description: </p>
 * <p>Company: www.itcast.cn</p> 
 * @version 1.0
 */
@Controller
public class paperController {
	
	// 依赖注入
	@Autowired
	private PaperService paperService;
	// 依赖注入
	@Autowired
	private QuestionService questionService;
	
	List<Course> course;
	
	@RequestMapping(value = "/paper")
	public String showQuestion() {
		return "redirect:/paper/list.action";
	}
	
	// 获取试卷列表
	@RequestMapping(value = "/paper/list")
	//@RequiresPermissions("paper:query")//执行paper/list需要paper:query权限
	public String list(@RequestParam(defaultValue="1")Integer page, @RequestParam(defaultValue="10")Integer rows, 
			Long id, String courseName, Model model) {
		
		
		Long courseId = null;
		course = paperService.findCourseList();
		for(int i = 0; i < course.size(); ++i){
			if(course.get(i).getCourseName().equals(courseName)){
				courseId = course.get(i).getCourseId();
				break;
			}
		}
		System.out.println("/paper/list courseId:" + courseId);
		Page<Paper> papers = paperService.findPaperList(page, rows, id, courseId);
		model.addAttribute("page", papers);
		model.addAttribute("course", course);
		model.addAttribute("courseName", courseName);

		return "paper";
	}
	
//	创建试卷
	@RequestMapping(value = "/paper/add")
	public String paperAdd(Model model) {
		
		course = paperService.findCourseList();
		System.out.println("/paper/add:  " + course.get(0).getCourseName());
		model.addAttribute("course", course);
		
		return "addPaper";
	}

	//手动创建试卷
	@RequestMapping(value = "/paper/manualadd")
	public String paperManualAdd(Model model, String paperName, String courseName, String userId, String userName) {
		
		
		for(int i = 0; i < course.size(); ++i){
			if(course.get(i).getCourseName().equals(courseName)){
				model.addAttribute("courseId", course.get(i).getCourseId());
				System.out.println("/paper/manualadd:" + paperName + "\t" + courseName + '\t' + course.get(i).getCourseId() + '\t' +userId  + '\t' + userName);
				break;
			}
		}
		model.addAttribute("paperName", paperName);
		model.addAttribute("userId", userId);
		model.addAttribute("userName", userName);
		return "paperManualAdd";
	}
	
	
	// 获取章节和知识点列表方式二@ResponseBody必须）
//		@responseBody注解的作用是将controller的方法返回的对象通过适当的转换器转换为指定的格式之后，
//		写入到response对象的body区，通常用来返回JSON数据或者是XML
	@RequestMapping(value = "/paper/knowpointlist", method={RequestMethod.POST})
	@ResponseBody
	public String knowpointList(int courseId, Model model){
		System.out.println("courseId:" + courseId);
		ArrayList<String>chapterList = paperService.findChapterList(courseId);
		ArrayList<ParentNode>nodes = new ArrayList<ParentNode>();
		for(String chapter : chapterList){
			ArrayList<ChildNode>childNodes = new ArrayList<ChildNode>();
			ArrayList<String>knowpointList = paperService.findKnowpointList(courseId, chapter);
			for(String knowpoint : knowpointList){
				childNodes.add(new ChildNode(knowpoint));
			}
			ParentNode node = new ParentNode(chapter, childNodes);
			nodes.add(node);
		}
		JSONArray json = JSONArray.fromObject(nodes);//将java对象转换为json对象
		String str = json.toString();//将json对象转换为字符串
		System.out.println(str);
		model.addAttribute("treeData", json);
		return str;
	}
	
//	显示需要添加到试卷的题目
	@RequestMapping(value = "/paper/showQuestion", method={RequestMethod.POST})
	@ResponseBody
	public String showQuestion(Model model, String type, String courseName, Long courseId, String difficulty, String checkNodes){
		
		
	
		System.out.println("/paper/showQuestion:  \tdifficulty:"  + difficulty + "\ttype:" + type + "\tcourseId:" + courseId + "\tcheckNodes:" + checkNodes);  
		Page<Question> questions = paperService.findQuestionList(type, courseId, difficulty, checkNodes);
		model.addAttribute("page", questions);
		
		JSONArray json = JSONArray.fromObject(questions);//将java对象转换为json对象
		String str = json.toString();//将json对象转换为字符串
		System.out.println(str);
		
		return str;
//		return questions;
	}
	
//	显示所有试卷
	@RequestMapping(value = "/paper/showPaper", method={RequestMethod.POST})
	@ResponseBody
	public String showPaper(Model model, String courseName, Long courseId){
		
		
	
		System.out.println("/paper/showPaper:  \tcourseId:"  + courseId);  
		Page<Paper> papers = paperService.findPaper(courseId);
		
		JSONArray json = JSONArray.fromObject(papers);//将java对象转换为json对象
		String str = json.toString();//将json对象转换为字符串
		System.out.println(str);
		
		return str;
//		
	}
	
	/*预览试卷*/
	@RequestMapping(value = "/paper/preview")
	public String previewPaper(@RequestParam(defaultValue="1")Integer page, @RequestParam(defaultValue="10")Integer rows, 
			@RequestParam(value = "qids[]", required = false, defaultValue = "")Long[] qids, Model model) {
		System.out.println("/question/batchEdit");  
		
		System.out.println(" qids: " + Arrays.toString(qids) + "\n");
		Page<Question> questions = questionService.findQuestionListByIds(page, rows, qids);
		JSONArray json = JSONArray.fromObject(questions);//将java对象转换为json对象
		String str = json.toString();//将json对象转换为字符串
		System.out.println(str);
		model.addAttribute("page", str);
		return "previewPaper";
	}
	
	//从试卷中选题
	@RequestMapping(value = "/paper/selQuestionFromPaper")
	@ResponseBody
	public String selQuestionFromPaper(@RequestParam(defaultValue="1")Integer page, @RequestParam(defaultValue="10")Integer rows, 
			@RequestParam(value = "qids[]", required = false, defaultValue = "")Long[] qids, Model model) {
		System.out.println("/paper/selQuestionFromPaper");  
		
		System.out.println(" qids: " + Arrays.toString(qids) + "\n");
		Page<Question> questions = questionService.findQuestionListByIds(page, rows, qids);
		JSONArray json = JSONArray.fromObject(questions);//将java对象转换为json对象
		String str = json.toString();//将json对象转换为字符串
		System.out.println(str);
//		model.addAttribute("page", str);
		
		return str;
	}
	
	/*生成并保存试卷*/
	@RequestMapping(value = "/paper/Generate")
	public ResponseEntity<byte[]> generatePaper(HttpServletRequest request, @RequestParam(defaultValue="1")Integer page, @RequestParam(defaultValue="10")Integer rows, 
			@RequestParam(value = "qids[]", required = false, defaultValue = "")Long[] qids, Long courseId, String paperName, String userId, String userName, Model model) throws Exception {

		
		System.out.println("/paper/Generate:" + " qids: " + Arrays.toString(qids) + "   courseId:" + courseId + "   paperName: " + paperName + "   userId: " + userId + "   userName: " + userName);
		String paperPath = paperService.paperSave(qids, courseId, paperName, userId, userName);
		
//		ServletContext servletContext = request.getServletContext();
//	    String path=servletContext.getRealPath("/paper");
//	    System.out.println("\npaperPath:" + path);
//	    File[] fileList = new File(path).listFiles();
//	    model.addAttribute("fileList", fileList);
		
	    
	  //指定下载文件所在的位置
		String[] Split = paperPath.split("#");
  		String path = Split[0];
  		String filename = Split[1];
//  		String filename = "HelloWord7.docx";
  		//创建文件对象
  		File file = new File(path+File.separator+filename);
  		System.out.println("\npaperPath:" + path+File.separator+filename);
  		//设置响应头
  		HttpHeaders headers=new HttpHeaders();
  		
  		//通知浏览器下载打开的方式
  		headers.setContentDispositionFormData("attachment", filename);
  		
  		//以流的方式下载文件数据
  		headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
  		
  		//responseEntity封装返回下载的数据
  		return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file),headers,HttpStatus.OK);
	  		
	    
//		return "success";
	}
	
//	删除试卷
	@RequestMapping("/paper/delete")
	@ResponseBody
	public String paperDelete(Long id) {
		paperService.deletePaper(id);
		return "OK";
	}
	
//	下载word模板文件
	@RequestMapping(value = "/paper/downloadWord", method={RequestMethod.GET})
	public ResponseEntity<byte[]> WordDownload1(String filename,
			HttpServletRequest request ) throws IOException{
		
		//指定下载文件所在的位置
		String path = request.getServletContext().getRealPath("/paper");
		
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
	
	

//	返回章节和知识点列表方式二
//	@RequestMapping("/paper/knowpointlist")
//    public void knowpointList(HttpServletRequest request,HttpServletResponse response){
//		response.setContentType("text/html;charset=UTF-8");//防止中文乱码
//        int courseId = Integer.parseInt(request.getParameter("courseId"));
//        ArrayList<String>chapterList = paperService.findChapterList(courseId);
//		ArrayList<ParentNode>nodes = new ArrayList<ParentNode>();
//		for(String chapter : chapterList){
//			ArrayList<ChildNode>childNodes = new ArrayList<ChildNode>();
//			ArrayList<String>knowpointList = paperService.findKnowpointList(courseId, chapter);
//			for(String knowpoint : knowpointList){
//				childNodes.add(new ChildNode(knowpoint));
//			}
//			ParentNode node = new ParentNode(chapter, childNodes);
//			nodes.add(node);
//		}
//		JSONArray json = JSONArray.fromObject(nodes);//将java对象转换为json对象
//		String str = json.toString();//将json对象转换为字符串
//		System.out.println(str);
//        try {
//            if(str!=""){
//                response.getWriter().write(str);
//            }else{
//                response.getWriter().write("ok");
//            }
//        } catch (IOException e) {
//                e.printStackTrace();
//        }    
//    }
}
