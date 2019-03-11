
package cn.itcast.core.service.impl;

import java.io.File;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigInteger;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Random;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.xml.bind.JAXBElement;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hwpf.extractor.WordExtractor;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFParagraph;
import org.apache.poi.xwpf.usermodel.XWPFPictureData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import cn.itcast.common.utils.CosineSimilarAlgorithm;
import cn.itcast.common.utils.IdWorker;
import cn.itcast.common.utils.Page;
import cn.itcast.common.utils.XWPFUtils;
import cn.itcast.core.bean.Paper;
import cn.itcast.core.bean.Question;
import cn.itcast.core.bean.Course;
import cn.itcast.core.dao.PaperDao;
import cn.itcast.core.dao.QuestionDao;
import cn.itcast.core.service.PaperService;
import org.apache.commons.collections.CollectionUtils;
import org.apache.poi.xwpf.extractor.XWPFWordExtractor;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import org.apache.poi.hwpf.extractor.WordExtractor;
import org.apache.poi.xwpf.usermodel.XWPFPicture;

import java.sql.ResultSet;
import org.docx4j.XmlUtils;
import org.docx4j.dml.wordprocessingDrawing.Inline;
import org.docx4j.openpackaging.exceptions.Docx4JException;
import org.docx4j.openpackaging.packages.WordprocessingMLPackage;
import org.docx4j.openpackaging.parts.WordprocessingML.BinaryPartAbstractImage;
import org.docx4j.openpackaging.parts.WordprocessingML.MainDocumentPart;
import org.docx4j.wml.BooleanDefaultTrue;
import org.docx4j.wml.Color;
import org.docx4j.wml.ContentAccessor;
import org.docx4j.wml.Drawing;
import org.docx4j.wml.HpsMeasure;
import org.docx4j.wml.Jc;
import org.docx4j.wml.JcEnumeration;
import org.docx4j.wml.ObjectFactory;
import org.docx4j.wml.P;
import org.docx4j.wml.PPr;
import org.docx4j.wml.R;
import org.docx4j.wml.RFonts;
import org.docx4j.wml.RPr;
import org.docx4j.wml.STHint;
import org.docx4j.wml.STLineSpacingRule;
import org.docx4j.wml.Text;
import org.docx4j.wml.U;
import org.docx4j.wml.UnderlineEnumeration;
import org.docx4j.wml.PPrBase.Spacing;


/**
 *试卷管理
 * @author lx
 *
 */

@Service("paperService")
@Transactional
public class PaperServiceImpl implements PaperService {

	// 定义dao属性
	@Autowired
	private PaperDao paperDao;
	@Autowired
	private QuestionDao questionDao;
	
	HttpServletRequest request;
	IdWorker worker2 = new IdWorker(1);
	public static ResultSet rs;
	
//	查询试卷列表
	public Page<Paper> findPaperList(Integer page, Integer rows, Long qid, Long courseId) {
		Paper paper = new Paper();
		
		
		paper.setId(qid);
		if(courseId != null)
			paper.setCourseId(courseId);
		System.out.println("\nfindPaperList: " + paper.getCourseId());
		
		//当前页
		paper.setStart((page-1) * rows) ;
		//每页数
		paper.setRows(rows);
		//查询试卷列表
		List<Paper> papers = paperDao.selectPaperList(paper);
		//查询题目列表总记录数
		Integer count = paperDao.selectPaperListCount(paper);
		//创建Page返回对象
		Page<Paper> result = new Page<>();
		result.setPage(page);
		result.setRows(papers);
		result.setSize(rows);
		result.setTotal(count);
		
		return result;
	}
	
	//查询试卷列表，供试卷选题
	@Override
	public Page<Paper> findPaper(Long courseId){
		Paper paper = new Paper();
		
		paper.setCourseId(courseId);
		
		//查询试卷列表
		List<Paper> papers = paperDao.selectPaper(paper);
		//查询题目列表总记录数
		Integer count = paperDao.selectPaperListCount(paper);
		//创建Page返回对象
		Page<Paper> result = new Page<>();
		
		result.setRows(papers);
		
		result.setTotal(count);
		
		return result;
	}

	//获取 chapter列表
	@Override
	public ArrayList<String> findChapterList(Integer courseId) {
		
		ArrayList<String>chapterList = paperDao.selectChapterList(courseId);
		return chapterList;
	}

//	获取知识点列表
	@Override
	public ArrayList<String> findKnowpointList(Integer courseId, String chapter) {
		ArrayList<String>knowpointList = paperDao.selectKnowpointList(courseId, chapter);
		return knowpointList;
	}
	
	// 查询问题列表
	@Override
	public Page<Question> findQuestionList(String type, Long courseId, String difficulty, String checkNodes){
		Question question = new Question();
		
		System.out.println("\npaper findQuestionList ");
		
		if(StringUtils.isNotBlank(type)){	
			if(!type.equals("0"))
				question.setType(type);
		}
		
		question.setCourseId(courseId);

		if(StringUtils.isNotBlank(difficulty)){	
				question.setDifficulty(difficulty);
		}
		
		
		checkNodes = checkNodes.substring(1, checkNodes.length()-1);
		String[] strArray = checkNodes.split("],"); //分割各个章
		ArrayList<String> chapterKnowpoints = new ArrayList<String>();
		for(int i = 0; i < strArray.length; ++i){
			int s = strArray[i].indexOf("\"");
			int e = strArray[i].indexOf("\"", s+1);
			String temp = strArray[i].substring(e+2);
			String[] chapterRear = temp.split("},"); //分割章中各个节与知识点
			for(int j = 0; j < chapterRear.length; ++j){
				String chapterKnowpoint = strArray[i].substring(s+1, e);
				String cr = chapterRear[j];
				int ss = cr.indexOf("\"");
				int ee = cr.indexOf("\"", ss+1);
				chapterKnowpoint = chapterKnowpoint + '#' + cr.substring(ss+1, ee);
				while(ee != -1){
					ss = cr.indexOf("\"", ee+1);
					if(ss == -1){
						break;
					}
					ee = cr.indexOf("\"", ss+1);
					chapterKnowpoint = chapterKnowpoint + '#' + cr.substring(ss+1, ee);
				}
//				System.out.println(chapterKnowpoint);
				chapterKnowpoints.add(chapterKnowpoint);	
			}	
		}
		
//		Pattern p=Pattern.compile("\"(.*?)\"");
//		checkNodes = checkNodes.substring(1, checkNodes.length()-1);
////		System.out.println(checkNodes);
//
//		String[] strArray = checkNodes.split("],"); //分割各个章节
//		String[] chapterKnowpoints = new String[strArray.length];
//        for (int i = 0; i < strArray.length; i++) { //从分割的各个章节中提取中章节与知识点
//        	 String temp = "";
//        	 Matcher m=p.matcher(strArray[i]);
//             while(m.find()){
////                 System.out.println(m.group());
//                 temp = temp + m.group().substring(1, m.group().length()-1) + '#';
//             }
//            chapterKnowpoints[i] = temp;
//            //其他操作   
//        }
        
        //如果可以考虑优化为先查询所有章节的试题，然后在用相应知识点进行刷选
        List<Question> questions = new ArrayList();
        Integer count = 0;
        for(int i = 0; i < chapterKnowpoints.size(); ++i){
        	String[] chapterKnowpoint = chapterKnowpoints.get(i).split("#");
        	question.setChapter(chapterKnowpoint[0]+ '#' + chapterKnowpoint[1]);
        	List<Question> questionTemp = paperDao.selectQuestionList(question);
        	for(int j = 0; j < questionTemp.size(); ++j){
        		for(int k = 2; k < chapterKnowpoint.length; ++k){
        			if(questionTemp.get(j).getKnowPoint().equals(chapterKnowpoint[k])){
        				questions.add(questionTemp.get(j));
        				System.out.println("Papre findQuestionList: " + "   type: " + question.getType() + "   difficluty: " + question.getDifficulty() + "   courseId: " + question.getCourseId() + "   chapter: " + question.getChapter() + "   knowPoint: " + chapterKnowpoint[k] );
        				count++;
        				break;
        			}
        		}
        	}
        	
//        	for(int j = 1; j < chapterKnowpoint.length; ++j){
//        		question.setKnowPoint(chapterKnowpoint[j]);
//        		//查询题目列表
//        		List<Question> questionTemp = paperDao.selectQuestionList(question);
//        		count += paperDao.selectQuestionListCount(question);
//        		System.out.println("Papre findQuestionList: " + "   type: " + question.getType() + "   difficluty: " + question.getDifficulty() + "   courseId: " + question.getCourseId() + "   chapter: " + question.getChapter() + "   knowPoint: " + question.getKnowPoint() );
//        		questions.addAll(questionTemp);
//        	}
        }
        
        for(int i = 0; i < questions.size(); ++i){
        	System.out.println("question: " + questions.get(i).getSubject() + "\t" + questions.get(i).getType());
        }	
		
//		//查询题目列表
//		List<Question> questions = paperDao.selectQuestionList(question);
		//查询题目列表总记录数
//		Integer count = paperDao.selectQuestionListCount(question);
		//创建Page返回对象
		Page<Question> result = new Page<>();
		result.setRows(questions);
		result.setTotal(count);
		
		return result;
		
	}
	
	// 查询科目列表
	@Override
	public List<Course> findCourseList(){
		Course course = new Course();
		
		List<Course> courseNames = paperDao.selectCourseList(course);
		System.out.println("findCourseName:  " + courseNames.get(0).getCourseName());
		
		return courseNames;
	}
	
	@Override
	public void deletePaper(Long id) {
		
		paperDao.deletePaper(id);
	}
	
	//保存试卷到数据库并生成试卷到word中供下载，返回存储位置
		@Override
		public String paperSave(HttpServletRequest request, Long[] qids, Long courseId, String paperName, String userId, String userName) throws Exception{
			Paper paper = new Paper();
			SimpleDateFormat tempDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String datetime = tempDate.format(new java.util.Date());  
			
			System.out.println("paperQuestionId: ");
			for(int i = 0; i < qids.length; ++i){
				System.out.println(qids[i]);
			}
			
			paper.setId(worker2.nextId());
			paper.setTitle(paperName);
			String Set = Arrays.toString(qids);
			Set = Set.replace(", ", "#");
			paper.setCourseId(courseId);
			paper.setQuestionSet(Set.substring(1, Set.length()-1));
			paper.setJoinTime(datetime);
			paper.setUserId(userId);
			paper.setUserName(userName);
			System.out.println("paperSave id: " + paper.getId() + "   paperName: " + paper.getTitle() + "   courseId: " + paper.getCourseId() + "   questionSet: " + paper.getQuestionSet() + "   joinTime: " + paper.getJoinTime() + "   userId: " + paper.getUserId());
			paperDao.savePaper(paper);
			
			List<Question> questions = new ArrayList();
					for(int i = 0; i < qids.length; ++i){
						Question question = paperDao.selectQuestionListById(qids[i]);
						questions.add(question);
					}
			String paperString = questionToWord(request, questions); //将试题生成到word试卷中
			
//			return "/paper";
			return paperString;
	
		}
	
	
		//将试题生成到word试卷中
		public String questionToWord(HttpServletRequest request, List<Question> questions) throws Exception{
			//题目类型
			String[] questionSeq = {"一", "二", "三", "四", "五", "六"};
			String[] questionType = {"单项选择题（每小题   分，共   分）", "多项选择题（每小题   分，共   分）", "填空题（每小题   分，共   分）", "简答题（每小题   分，共   分）", "应用题（每小题   分，共   分）", "设计题（每小题   分，共   分）"};
			int[] questionNum = {1, 1, 1, 1, 1, 1};
			
			// 设置上传文件保存的地址目录
			String dirpath = request.getServletContext().getRealPath("");
			String[] temp = dirpath.split("\\\\");
			int mark = dirpath.indexOf(".metadata");
			dirpath = dirpath.substring(0, mark) + temp[temp.length-1];
			dirpath = dirpath + "\\questionImg\\";

			System.out.println(dirpath);
			File filepath = new File(dirpath);
			// 如果保存文件的目录不存在，创建upload文件夹
			if (!filepath.exists()) {
				filepath.mkdirs();
			}
			
			String paperPath = dirpath;
			String wordName = UUID.randomUUID() + "_" + "paper.docx";

			
			//提取模板
			String placeholder = "SJ_EX1";
			String toAdd = "";
			WordprocessingMLPackage template = null;
			
			String path = "HelloWord7.docx";
			File file = new File(PaperServiceImpl.class.getClassLoader().getResource(path).getPath());
			String realPath = file.getAbsolutePath();
			template = getTemplate(realPath);
			
			//template = getTemplate("https://github.com/breezelj/Template/raw/master/HelloWord7.docx");
			replaceParagraph(placeholder, toAdd, template, template.getMainDocumentPart());
			
			//设置试卷信息
			examTitle(template,"2008-2009学年第2学期考试试题（B）卷",true);
			examTitle(template,"课程名称  软件体系结构        任课教师签名   刘玮",false);
			examTitle(template,"出题教师签名  刘玮             审题教师签名",false);
			examTitle(template,"考试方式   （开、闭）卷        适用专业     计算机",false);
			examTitle(template,"考试时间   （ 120 ）分钟",false);
			template.getMainDocumentPart().addStyledParagraphOfText("Normal","\n");
			String path1 = "exTable.png";
			File file2 = new File(PaperServiceImpl.class.getClassLoader().getResource(path1).getPath());
			String realPath1 = file2.getAbsolutePath();
			File file1 = new File(realPath1);//得分表格
	        byte[] bytes1 = convertImageToByteArray(file1);
	        addImageToPackage(template, bytes1);
			
			
//			File file1 = new File("https://github.com/breezelj/Template/raw/master/temp.jpg");//得分表格
//	        byte[] bytes1 = convertImageToByteArray(file1);
//	        addImageToPackage(template, bytes1);
			
	        
	        System.out.println("questionToWord: " + questions.size());
	        for(int i = 0; i < questions.size(); ++i){
	        	System.out.println(questions.get(i).getSubject());
	        }
	        int len = questions.size(), i = 0, s = 0;
//	        System.out.println("nums: " + questions.size());
	        //录入单选题
	        
	        boolean fileEnd = false;
	        while(true){
	        	if(fileEnd) break;
	        	
	        	boolean typeFlag = true; //每道题型第一题的标识
	        	while(questions.get(i).getType().equals("单选题")){
	        		
	        		if(typeFlag) {
	        			//template.getMainDocumentPart().addStyledParagraphOfText("Subtitle", questionType[0]);
	        			examTitle(template,questionSeq[s++]+','+questionType[0],false);
	        			typeFlag = false;
	        		}
	        		
	        		template.getMainDocumentPart().addStyledParagraphOfText("Normal",Integer.toString(questionNum[0]++) + "、" + (questions.get(i).getSubject()));
	        		template.getMainDocumentPart().addStyledParagraphOfText("Normal", "A." + (questions.get(i).getOptionA()));
	        		template.getMainDocumentPart().addStyledParagraphOfText("Normal", "B." + (questions.get(i).getOptionB()));
	        		template.getMainDocumentPart().addStyledParagraphOfText("Normal", "C." + (questions.get(i).getOptionC()));
	        		template.getMainDocumentPart().addStyledParagraphOfText("Normal", "D." + (questions.get(i).getOptionD()));
	        		if(StringUtils.isNotBlank((questions.get(i).getOptionE()))){
	        			template.getMainDocumentPart().addStyledParagraphOfText("Normal", "E." + (questions.get(i).getOptionE()));
	        		}else {
	        			if(StringUtils.isNotBlank((questions.get(i).getPictureUrl())))
	        				addPicture(template, questions.get(i).getPictureUrl()); //添加试题的图片
	        			++i; 
	        			if(i >= len){ fileEnd = true; break; }
	        			continue;
	        		}
	        		if(StringUtils.isNotBlank((questions.get(i).getOptionF()))){
	        			template.getMainDocumentPart().addStyledParagraphOfText("Normal", "F." + (questions.get(i).getOptionF()));
	        		}else {
	        			if(StringUtils.isNotBlank((questions.get(i).getPictureUrl())))
	        				addPicture(template, questions.get(i).getPictureUrl()); //添加试题的图片
	        			++i; 
	        			if(i >= len){ fileEnd = true; break; }
	        			continue;
	        		}
	        		if(StringUtils.isNotBlank((questions.get(i).getOptionG()))){
	        			template.getMainDocumentPart().addStyledParagraphOfText("Normal", "G." + (questions.get(i).getOptionG()));
	        		}else {
	        			if(StringUtils.isNotBlank((questions.get(i).getPictureUrl())))
	        				addPicture(template, questions.get(i).getPictureUrl()); //添加试题的图片
	        			++i; 
	        			if(i >= len){ fileEnd = true; break; }
	        			continue;
	        		}
	       
	        		if(StringUtils.isNotBlank((questions.get(i).getPictureUrl())))
	    				addPicture(template, questions.get(i).getPictureUrl()); //添加试题的图片
	        		++i;
	        		if(i >= len){ fileEnd = true; break; }

	        		System.out.println("/paper/question:" + (questions.get(i).getSubject()));
	        	} 	
	        	if(fileEnd) break;
	        	
	        	//录入多选题
	        	typeFlag = true; //每道题型第一题的标识
	        	while(questions.get(i).getType().equals("多选题")){
	        		if(typeFlag) {
	        			examTitle(template,questionSeq[s++]+','+questionType[1],false);
	        			//template.getMainDocumentPart().addStyledParagraphOfText("Subtitle", questionSeq[s++]+','+questionType[1]);
	        			typeFlag = false;
	        		}
	        		
	        		template.getMainDocumentPart().addStyledParagraphOfText("Normal",Integer.toString(questionNum[1]++) + "、" + (questions.get(i).getSubject()));
	        		template.getMainDocumentPart().addStyledParagraphOfText("Normal", "A." + (questions.get(i).getOptionA()));
	        		template.getMainDocumentPart().addStyledParagraphOfText("Normal", "B." + (questions.get(i).getOptionB()));
	        		template.getMainDocumentPart().addStyledParagraphOfText("Normal", "C." + (questions.get(i).getOptionC()));
	        		template.getMainDocumentPart().addStyledParagraphOfText("Normal", "D." + (questions.get(i).getOptionD()));
	        		if(StringUtils.isNotBlank((questions.get(i).getOptionE()))){
	        			template.getMainDocumentPart().addStyledParagraphOfText("Normal", "E." + (questions.get(i).getOptionE()));
	        		}else {
	        			if(StringUtils.isNotBlank((questions.get(i).getPictureUrl())))
	        				addPicture(template, questions.get(i).getPictureUrl()); //添加试题的图片
	        			++i; 
	        			if(i >= len){ fileEnd = true; break; }
	        			continue;
	        		}
	        		if(StringUtils.isNotBlank((questions.get(i).getOptionF()))){
	        			template.getMainDocumentPart().addStyledParagraphOfText("Normal", "F." + (questions.get(i).getOptionF()));
	        		}else {
	        			if(StringUtils.isNotBlank((questions.get(i).getPictureUrl())))
	        				addPicture(template, questions.get(i).getPictureUrl()); //添加试题的图片
	        			++i; 
	        			if(i >= len){ fileEnd = true; break; }
	        			continue;
	        		}
	        		if(StringUtils.isNotBlank((questions.get(i).getOptionG()))){
	        			template.getMainDocumentPart().addStyledParagraphOfText("Normal", "G." + (questions.get(i).getOptionG()));
	        		}else {
	        			if(StringUtils.isNotBlank((questions.get(i).getPictureUrl())))
	        				addPicture(template, questions.get(i).getPictureUrl()); //添加试题的图片
	        			++i; 
	        			if(i >= len){ fileEnd = true; break; }
	        			continue;
	        		}
	            	
	        		if(StringUtils.isNotBlank((questions.get(i).getPictureUrl())))
	    				addPicture(template, questions.get(i).getPictureUrl()); //添加试题的图片
	        		++i;
	        		if(i >= len){ fileEnd = true; break; }
	        		System.out.println("/paper/question:" + (questions.get(i).getSubject()));
	        	} 	
	        	if(fileEnd) break;
	        	
	        	//录入填空题
	        	typeFlag = true;
	        	while(questions.get(i).getType().equals("填空题")){
	        		if(typeFlag) {
	        			examTitle(template,questionSeq[s++]+','+questionType[2],false);
	        			//template.getMainDocumentPart().addStyledParagraphOfText("Subtitle", questionSeq[s++]+','+questionType[2]);
	        			typeFlag = false;
	        		}
	        		
	        		template.getMainDocumentPart().addStyledParagraphOfText("Normal",Integer.toString(questionNum[2]++) + "、" + (questions.get(i).getSubject()));
	        		if(StringUtils.isNotBlank((questions.get(i).getPictureUrl())))
	    				addPicture(template, questions.get(i).getPictureUrl()); //添加试题的图片
	        		++i;
	        		if(i >= len){ fileEnd = true; break; }
	        		System.out.println("/paper/question:" + (questions.get(i).getSubject()));
	        	}
	        	if(fileEnd) break;

	        	
	        	//录入填空题
	        	typeFlag = true;
	        	while(questions.get(i).getType().equals("简答题")){
	        		if(typeFlag) {
	        			examTitle(template,questionSeq[s++]+','+questionType[3],false);
	        			//template.getMainDocumentPart().addStyledParagraphOfText("Subtitle", questionSeq[s++]+','+questionType[3]);
	        			typeFlag = false;
	        		}
	        		
	        		template.getMainDocumentPart().addStyledParagraphOfText("Normal",Integer.toString(questionNum[3]++) + "、" + (questions.get(i).getSubject()));
	        		if(StringUtils.isNotBlank((questions.get(i).getPictureUrl())))
	    				addPicture(template, questions.get(i).getPictureUrl()); //添加试题的图片
	        		++i;
	        		if(i >= len){ fileEnd = true; break; }
	        		System.out.println("/paper/question:" + (questions.get(i).getSubject()));
	        	}
	        	if(fileEnd) break;

	        	
	        	//录入填空题
	        	typeFlag = true;
	        	while(questions.get(i).getType().equals("应用题")){
	        		if(typeFlag) {
	        			examTitle(template,questionSeq[s++]+','+questionType[4],false);
	        			//template.getMainDocumentPart().addStyledParagraphOfText("Subtitle", questionSeq[s++]+','+questionType[4]);
	        			typeFlag = false;
	        		}
	        		
	        		template.getMainDocumentPart().addStyledParagraphOfText("Normal",Integer.toString(questionNum[4]++) + "、" + (questions.get(i).getSubject()));
	        		if(StringUtils.isNotBlank((questions.get(i).getPictureUrl())))
	    				addPicture(template, questions.get(i).getPictureUrl()); //添加试题的图片
	        		++i;
	        		if(i >= len){ fileEnd = true; break; }
	        		System.out.println("/paper/question:" + (questions.get(i).getSubject()));
	        	}
	        	if(fileEnd) break;

	        	
	        	//录入填空题
	        	typeFlag = true;
	        	while(questions.get(i).getType().equals("设计题")){
	        		if(typeFlag) {
	        			examTitle(template,questionSeq[s++]+','+questionType[5],false);
	        			//template.getMainDocumentPart().addStyledParagraphOfText("Subtitle", questionSeq[s++]+','+questionType[5]);
	        			typeFlag = false;
	        		}
	        		
	        		template.getMainDocumentPart().addStyledParagraphOfText("Normal",Integer.toString(questionNum[5]++) + "、" + (questions.get(i).getSubject()));
	        		if(StringUtils.isNotBlank((questions.get(i).getPictureUrl())))
	    				addPicture(template, questions.get(i).getPictureUrl()); //添加试题的图片
	        		++i;
	        		if(i >= len){ fileEnd = true; break; }
	        		System.out.println("/paper/question:" + (questions.get(i).getSubject()));
	        	}
	        	if(fileEnd) break;
	        	
	        	//录入填空题
	        	typeFlag = true;
	        	while(questions.get(i).getType().equals("名次解释")){
	        		if(typeFlag) {
	        			examTitle(template,questionSeq[s++]+','+questionType[6],false);
	        			//template.getMainDocumentPart().addStyledParagraphOfText("Subtitle", questionSeq[s++]+','+questionType[6]);
	        			typeFlag = false;
	        		}
	        		
	        		template.getMainDocumentPart().addStyledParagraphOfText("Normal",Integer.toString(questionNum[6]++) + "、" + (questions.get(i).getSubject()));
	        		if(StringUtils.isNotBlank((questions.get(i).getPictureUrl())))
	    				addPicture(template, questions.get(i).getPictureUrl()); //添加试题的图片
	        		++i;
	        		if(i >= len){ fileEnd = true; break; }
	        		System.out.println("/paper/question:" + (questions.get(i).getSubject()));
	        	}
	        	if(fileEnd) break;

	        	
	        }
	    	
	        	
	        
			writeDocxToStream(template, paperPath+wordName);
			System.out.println(paperPath+wordName);
			return (paperPath + '#' + wordName);
			
		}
	
	public static void addPicture(WordprocessingMLPackage template, String pic) throws Exception{
		String[] quesPic = pic.split("&");
		for(int i = 0; i < quesPic.length; ++i){
			String[] picture = quesPic[i].split("#");
			for(int j = 0; j < picture.length; ++j){
				System.out.println(picture[j]);
				File file = new File(picture[j]);//得分表格
		        byte[] bytes = convertImageToByteArray(file);
		        addImageToPackage(template, bytes);
			}
		}
		
	}
	public static WordprocessingMLPackage getTemplate(String name) throws Docx4JException, FileNotFoundException {
		WordprocessingMLPackage template = WordprocessingMLPackage.load(new FileInputStream(new File(name)));
		return template;
	}
	

	private static List<Object> getAllElementFromObject(Object obj, Class<?> toSearch) {
	    
		//JAXB计算的包装器，允许你针对一个特定的类来搜索指定元素以及它所有的孩子，例如，你可以用它获取文档中所有的表格、表格中所有的行以及其它类似的操作。 
		List<Object> result = new ArrayList<Object>();
		if (obj instanceof JAXBElement) obj = ((JAXBElement<?>) obj).getValue();
		if (obj.getClass().equals(toSearch))
			result.add(obj);
		else if (obj instanceof ContentAccessor) {
			List<?> children = ((ContentAccessor) obj).getContent();
			for (Object child : children) {
				result.addAll(getAllElementFromObject(child, toSearch));
			}
		}
		return result;
	}
	
	
	
	private void replacePlaceholder(WordprocessingMLPackage template, String name, String placeholder ) {
	
		//在前面创建的模版文档中添加一个自定义占位符，我使用SJ_EX1作为占位符，我们将要用name参数来替换这个值。
		//在docx4j中基本的文本元素用org.docx4j.wml.Text类来表示，替换这个简单的占位符
		List<Object> texts = getAllElementFromObject(template.getMainDocumentPart(), Text.class);
		for (Object text : texts) {
			Text textElement = (Text) text;
			if (textElement.getValue().equals(placeholder)) {
				textElement.setValue(name);
			}
		}
	}
	
	
	private static void writeDocxToStream(WordprocessingMLPackage template, String target) throws IOException, Docx4JException {
	
		File f = new File(target);
	
		template.save(f);
	
	}
	
	
	public static void replaceParagraph(String placeholder, String textToAdd, WordprocessingMLPackage template, ContentAccessor addTo) {
	
	//	这个需要下面的几步：
	//
	//	从模版中找到要替换的段落
	//	将输入文本拆分成单独的行
	//	每一行基于模版中的段落创建一个新的段落
	//	移除原来的段落
		// 1. get the paragraph
		List<Object> paragraphs = getAllElementFromObject(template.getMainDocumentPart(), P.class);
		P toReplace = null;
		for (Object p : paragraphs) {
			List<Object> texts = getAllElementFromObject(p, Text.class);
			for (Object t : texts) {
				Text content = (Text) t;
				if (content.getValue().equals(placeholder)) {
					toReplace = (P) p;
					break;
				}
			}
		}
		// we now have the paragraph that contains our placeholder: toReplace
		// 2. split into seperate lines
		String as[] = StringUtils.splitPreserveAllTokens(textToAdd, '\n');
		for (int i = 0; i < as.length; i++) {
			String ptext = as[i];
			// 3. copy the found paragraph to keep styling correct
			P copy = (P) XmlUtils.deepCopy(toReplace);
			// replace the text elements from the copy
			List<?> texts = getAllElementFromObject(copy, Text.class);
			if (texts.size() > 0) {
				Text textToReplace = (Text) texts.get(0);
				textToReplace.setValue(ptext);
			}
			// add the paragraph to the document
			addTo.getContent().add(copy);
		}
		// 4. remove the original one
		((ContentAccessor)toReplace.getParent()).getContent().remove(toReplace);
	}
	
	/**
	 *  Docx4j拥有一个由字节数组创建图片部件的工具方法, 随后将其添加到给定的包中. 为了能将图片添加
	 *  到一个段落中, 我们需要将图片转换成内联对象. 这也有一个方法, 方法需要文件名提示, 替换文本, 
	 *  两个id标识符和一个是嵌入还是链接到的指示作为参数.
	 *  一个id用于文档中绘图对象不可见的属性, 另一个id用于图片本身不可见的绘制属性. 最后我们将内联
	 *  对象添加到段落中并将段落添加到包的主文档部件.
	 *
	 *  @param wordMLPackage 要添加图片的包
	 *  @param bytes         图片对应的字节数组
	 *  @throws Exception    不幸的createImageInline方法抛出一个异常(没有更多具体的异常类型)
	 */
	
	private static void addImageToPackage(WordprocessingMLPackage wordMLPackage,
	                        byte[] bytes) throws Exception {
	    BinaryPartAbstractImage imagePart = BinaryPartAbstractImage.createImagePart(wordMLPackage, bytes);
	    int docPrId = 1;
	    int cNvPrId = 2;
	    Inline inline = imagePart.createImageInline("Filename hint","Alternative text", docPrId, cNvPrId, false);
	    P paragraph = addInlineImageToParagraph(inline);
	    wordMLPackage.getMainDocumentPart().addObject(paragraph);
	}
	
	/**
	 *  创建一个对象工厂并用它创建一个段落和一个可运行块R.
	 *  然后将可运行块添加到段落中. 接下来创建一个图画并将其添加到可运行块R中. 最后我们将内联
	 *  对象添加到图画中并返回段落对象.
	 *
	 * @param   inline 包含图片的内联对象.
	 * @return  包含图片的段落
	 */
	private static P addInlineImageToParagraph(Inline inline) {
	
	    // 添加内联对象到一个段落中
	    ObjectFactory factory = new ObjectFactory();
	    P paragraph = factory.createP();
	    R run = factory.createR();
	    paragraph.getContent().add(run);
	    Drawing drawing = factory.createDrawing();
	    run.getContent().add(drawing);
	    drawing.getAnchorOrInline().add(inline);
	    return paragraph;
	}
	
	
	
	/**
	 * 将图片从文件对象转换成字节数组.
	 * 
	 * @param file  将要转换的文件
	 * @return      包含图片字节数据的字节数组
	 * @throws FileNotFoundException
	 * @throws IOException
	 */
	private static byte[] convertImageToByteArray(File file)
	        throws FileNotFoundException, IOException {
		
	    InputStream is = new FileInputStream(file );
	    long length = file.length();
	    // 不能使用long类型创建数组, 需要用int类型.
	    if (length > Integer.MAX_VALUE) {
	        System.out.println("File too large!!");
	    }
	    byte[] bytes = new byte[(int)length];
	    int offset = 0;
	    int numRead = 0;
	    while (offset < bytes.length && (numRead=is.read(bytes, offset, bytes.length-offset)) >= 0) {
	        offset += numRead;
	    }
	    // 确认所有的字节都没读取
	    if (offset < bytes.length) {
	        System.out.println("Could not completely read file " +file.getName());
	    }
	    is.close();
	    return bytes;
	
	}
	
	/** 
	 * @param jcEnumeration 
	 *            对齐方式 
	 * @param isSpace 
	 *            是否设置段前段后值 
	 * @param before 
	 *            段前磅数 
	 * @param after 
	 *            段后磅数 
	 * @param beforeLines 
	 *            段前行数 
	 * @param afterLines 
	 *            段后行数 
	 * @param isLine 
	 *            是否设置行距 
	 * @param lineValue 
	 *            行距值 
	 * @param sTLineSpacingRule 
	 *            自动auto 固定exact 最小 atLeast 
	 */  
	public static void setParagraphSpacing(ObjectFactory factory, P p,  
	
	        JcEnumeration jcEnumeration, boolean isSpace, String before,  
	        String after, String beforeLines, String afterLines,  
	        boolean isLine, String lineValue,  
	        STLineSpacingRule sTLineSpacingRule) {  
	    PPr pPr = p.getPPr();  
	    if (pPr == null) {  
	        pPr = factory.createPPr();  
	    }  
	    Jc jc = pPr.getJc();  
	    if (jc == null) {  
	        jc = new Jc();  
	    }  
	    jc.setVal(jcEnumeration);  
	    pPr.setJc(jc);  
	
	    Spacing spacing = new Spacing();  
	    if (isSpace) {  
	        if (before != null) {  
	            // 段前磅数  
	            spacing.setBefore(new BigInteger(before));  
	        }  
	        if (after != null) {  
	            // 段后磅数  
	            spacing.setAfter(new BigInteger(after));  
	        }  
	        if (beforeLines != null) {  
	            // 段前行数  
	            spacing.setBeforeLines(new BigInteger(beforeLines));  
	        }  
	        if (afterLines != null) {  
	            // 段后行数  
	            spacing.setAfterLines(new BigInteger(afterLines));  
	        }  
	    }  
	    if (isLine) {  
	        if (lineValue != null) {  
	            spacing.setLine(new BigInteger(lineValue));  
	        }  
	        spacing.setLineRule(sTLineSpacingRule);  
	    }  
	    pPr.setSpacing(spacing);  
	    p.setPPr(pPr);  
	}  
	
	/** 
	 * 创建字体 
	 *  
	 * @param isBlod 
	 *            粗体 
	 * @param isUnderLine 
	 *            下划线 
	 * @param isItalic 
	 *            斜体 
	 * @param isStrike 
	 *            删除线 
	 */  
	public static RPr getRPr(ObjectFactory factory, String fontFamily,  
	        String colorVal, String fontSize, STHint sTHint, boolean isBlod,  
	        boolean isUnderLine, boolean isItalic, boolean isStrike) {  
	    RPr rPr = factory.createRPr();  
	    RFonts rf = new RFonts();  
	    rf.setHint(sTHint);  
	    rf.setAscii(fontFamily);  
	    rf.setHAnsi(fontFamily);  
	    rPr.setRFonts(rf);  
	
	    BooleanDefaultTrue bdt = factory.createBooleanDefaultTrue();  
	    rPr.setBCs(bdt);  
	    if (isBlod) {  
	        rPr.setB(bdt);  
	    }  
	    if (isItalic) {  
	        rPr.setI(bdt);  
	    }  
	    if (isStrike) {  
	        rPr.setStrike(bdt);  
	    }  
	    if (isUnderLine) {  
	        U underline = new U();  
	        underline.setVal(UnderlineEnumeration.SINGLE);  
	        rPr.setU(underline);  
	    }  
	    Color color = new Color();  
	    color.setVal(colorVal);  
	    rPr.setColor(color);  
	
	    HpsMeasure sz = new HpsMeasure();  
	    sz.setVal(new BigInteger(fontSize));  
	    rPr.setSz(sz);  
	    rPr.setSzCs(sz);  
	    return rPr;  
	}  
	
	//设置试卷信息函数
	public static void examTitle(WordprocessingMLPackage template,String str,boolean ty) {
		ObjectFactory factory = new ObjectFactory();
		P paragraph = factory.createP(); 
		RPr fontRPr = getRPr(factory, "黑体", "000000", "24", STHint.EAST_ASIA,  true, false, false, false); 
		Text txt = factory.createText();
		R run = factory.createR();
		if(ty)
		{
			setParagraphSpacing(factory, paragraph, JcEnumeration.CENTER, true,  
	            "0", "0", null, null, true, "240", STLineSpacingRule.AUTO);  
	    txt = factory.createText(); 
	    txt = factory.createText();  
	    txt.setValue(str);  
	    run = factory.createR();
	    fontRPr = getRPr(factory, "黑体", "000000", "28", STHint.EAST_ASIA,  
	            true, false, false, false); 
		}
		else
		{
			setParagraphSpacing(factory, paragraph, JcEnumeration.LEFT, true,  
	                "0", "0", null, null, true, "240", STLineSpacingRule.AUTO);  
	        txt = factory.createText(); 
	        txt = factory.createText();  
	        txt.setValue(str);  
	        run = factory.createR();
	        fontRPr = getRPr(factory, "黑体", "000000", "24", STHint.EAST_ASIA,  
	                true, false, false, false); 
		}
	     
	    run = factory.createR();  
	    run.getContent().add(txt);  
	    run.setRPr(fontRPr);  
	    paragraph.getContent().add(run);  
	    MainDocumentPart t =template.getMainDocumentPart();
		t.addObject(paragraph);
	}
	
}
