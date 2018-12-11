package cn.itcast.core.service.impl;

import java.io.File;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

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

/**
 * 试题管理
 * @author lx
 *
 */

@Service("paperService")
@Transactional
public class PaperServiceImpl implements PaperService {

	// 定义dao属性
	@Autowired
	private PaperDao paperDao;


	IdWorker worker2 = new IdWorker(1);
   
//	查询试卷列表
	public Page<Paper> findPaperList(Integer page, Integer rows, Long qid) {
		Paper paper = new Paper();
		
		
		paper.setId(qid);
		

		
		System.out.println("\nfindPaperList: " + paper.getId());
		
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
		
		Pattern p=Pattern.compile("\"(.*?)\"");
		checkNodes = checkNodes.substring(1, checkNodes.length()-1);
//		System.out.println(checkNodes);

		String[] strArray = checkNodes.split("],"); //分割各个章节
		String[] chapterKnowpoints = new String[strArray.length];
        for (int i = 0; i < strArray.length; i++) { //从分割的各个章节中提取中章节与知识点
        	 String temp = "";
        	 Matcher m=p.matcher(strArray[i]);
             while(m.find()){
//                 System.out.println(m.group());
                 temp = temp + m.group().substring(1, m.group().length()-1) + '#';
             }
            chapterKnowpoints[i] = temp;
            //其他操作   
        }
        
        //如果可以考虑优化为先查询所有章节的试题，然后在用相应知识点进行刷选
        List<Question> questions = new ArrayList();
        Integer count = 0;
        for(int i = 0; i < chapterKnowpoints.length; ++i){
        	String[] chapterKnowpoint = chapterKnowpoints[i].split("#");
        	question.setChapter(chapterKnowpoint[0]);
        	List<Question> questionTemp = paperDao.selectQuestionList(question);
        	for(int j = 0; j < questionTemp.size(); ++j){
        		for(int k = 1; k < chapterKnowpoint.length; ++k){
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

}
