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

import cn.itcast.common.utils.ChildNode;
import cn.itcast.common.utils.Page;
import cn.itcast.common.utils.ParentNode;
import cn.itcast.core.bean.BaseDict;
import cn.itcast.core.bean.Paper;
import cn.itcast.core.bean.Question;
import cn.itcast.core.service.PaperService;
import cn.itcast.core.service.SystemService;
import net.sf.json.JSONArray;
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
	
	
	
	@RequestMapping(value = "/paper")
	public String showQuestion() {
		return "redirect:/paper/list.action";
	}
	
	// 获取试卷列表
	@RequestMapping(value = "/paper/list")
	public String list(@RequestParam(defaultValue="1")Integer page, @RequestParam(defaultValue="10")Integer rows, 
			Long id, Model model) {
		
		System.out.println("/paper/list");  

		Page<Paper> papers = paperService.findPaperList(page, rows, id);
		model.addAttribute("page", papers);


		return "paper";
	}
	
//	创建试卷
	@RequestMapping(value = "/paper/add")
	public String paperAdd() {
		
		
		return "addPaper";
	}

	//手动创建试卷
	@RequestMapping(value = "/paper/manualadd")
	public String paperManualAdd() {
		return "paperManualAdd";
	}
	// 获取章节和知识点列表方式二@ResponseBody必须）
//	@responseBody注解的作用是将controller的方法返回的对象通过适当的转换器转换为指定的格式之后，
//	写入到response对象的body区，通常用来返回JSON数据或者是XML
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
