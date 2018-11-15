package cn.itcast.core.service.impl;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Random;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hwpf.extractor.WordExtractor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.itcast.common.utils.IdWorker;
import cn.itcast.common.utils.Page;
import cn.itcast.core.bean.Customer;
import cn.itcast.core.bean.Question;
import cn.itcast.core.dao.BaseDictDao;
import cn.itcast.core.dao.CustomerDao;
import cn.itcast.core.dao.QuestionDao;
import cn.itcast.core.service.CustomerService;
import cn.itcast.core.service.QuestionService;

/**
 * 客户管理
 * @author lx
 *
 */

@Service("questionService")
@Transactional
public class QuestionServiceImpl implements QuestionService {

	// 定义dao属性
	@Autowired
	private QuestionDao questionDao;
	@Autowired
	private BaseDictDao baseDictDao;

   
	
	public Page<Question> findQuestionList(Integer page, Integer rows, Long qid,
			String subject,  String type) {
		Question question = new Question();
		
		
		question.setQid(qid);
		
		if(StringUtils.isNotBlank(subject)){
			question.setSubject(subject);
		}
		
		if(StringUtils.isNotBlank(type)){	
			if(!type.equals("0"))
				question.setType(type);
		}
		
		System.out.println("\nfindQuestionList " + question.getQid() + "   subject: " + question.getSubject() + "   type: " + question.getType());
		
		//当前页
		question.setStart((page-1) * rows) ;
		//每页数
		question.setRows(rows);
		//查询题目列表
		List<Question> questions = questionDao.selectQuestionList(question);
		//查询题目列表总记录数
		Integer count = questionDao.selectQuestionListCount(question);
		//创建Page返回对象
		Page<Question> result = new Page<>();
		result.setPage(page);
		result.setRows(questions);
		result.setSize(rows);
		result.setTotal(count);
		return result;

	}


	@Override
	public void deleteQuestion(Long id) {
		questionDao.deleteQuestion(id);
		
	}

	@Override
	public void addQuestion(Long qid, String subject, String type, String optionA, String optionB, String optionC, String optionD,  String optionE, String optionF, String optionG, 
			String answerOption, String answerJudge, String[] answerFill, String answerCloze,  
			String courseName, String analysis, String chapter, String knowPoint, String difficulty, String pictureUrl){
		
		Question question = new Question();
		
		IdWorker worker2 = new IdWorker(1);
		question.setQid(worker2.nextId());
		
		if(StringUtils.isNotBlank(subject)){
			question.setSubject(subject);
		}
		
		if(StringUtils.isNotBlank(type)){
				question.setType(type);
		}
		
		if(StringUtils.isNotBlank(optionA)){
			question.setOptionA(optionA);
		}
		
		if(StringUtils.isNotBlank(optionB)){
			question.setOptionB(optionB);
		}
		
		if(StringUtils.isNotBlank(optionC)){
			question.setOptionC(optionC);
		}
		
		if(StringUtils.isNotBlank(optionD)){
			question.setOptionD(optionD);
		}
		
		if(StringUtils.isNotBlank(optionE)){
			question.setOptionE(optionE);
		}
		
		if(StringUtils.isNotBlank(optionF)){
			question.setOptionF(optionF);
		}
		
		if(StringUtils.isNotBlank(optionG)){
			question.setOptionG(optionG);
		}
		

		if(StringUtils.isNotBlank(answerOption)){
			question.setAnswer(answerOption);
		}

		if(StringUtils.isNotBlank(courseName)){
			question.setCourseName(courseName);
		}

		if(StringUtils.isNotBlank(analysis)){
			question.setAnalysis(analysis);
		}

		if(StringUtils.isNotBlank(difficulty)){
				question.setDifficulty(difficulty);
		}
		
		if(StringUtils.isNotBlank(pictureUrl)){
			question.setPictureUrl(pictureUrl);
	}
		
		System.out.print("\niml " +  "  answerOption: " + answerOption + "   answerJudge: " + answerJudge + "   answerCloze: " + answerCloze);
		System.out.print("  answerFill: " + answerFill.length);
		for(int i = 0; i < answerFill.length; ++i)
			System.out.print("  " + answerFill[i] + " ");
		
		
		//根据题型对answer进行赋值
		if(type.equals("单选题") || type.equals("多选题")) question.setAnswer(answerOption);
		if(type.equals("判断题")) question.setAnswer(answerJudge);
		if(type.equals("问答题") || type.equals("简述题") || type.equals("名词解释")) question.setAnswer(answerCloze);
		if(type.equals("填空题")) {
			String temp = "";
			for(int i = 0; i < answerFill.length; ++i)
				temp = temp + answerFill[i] + ',';
			
			question.setAnswer(temp);
		}
		

		System.out.println("\niml " + question.getQid() + "   subject: " + question.getSubject() + "   type: " + question.getType() + "   difficulty: " + question.getDifficulty() + "   analysis: " + question.getAnalysis() +  "   optionA: " + question.getOptionA() + "   optionE: " + question.getOptionE() + "   answer: " + question.getAnswer()+ "   pictureUrl: " + question.getPictureUrl() + "\n");

//		if(!question.getType().equals(null)) 
		//要对各个值进行判断是否为空
		if(StringUtils.isNotBlank(question.getType()))
			questionDao.addQuestionList(question);
	}

	
	
	@Override
	public void addQuestionByword(String position){
		File file = new File(position);
		Random random = new Random();
		   
		   try {
		    FileInputStream fis = new FileInputStream(file);
		    WordExtractor wordExtractor = new WordExtractor(fis);
		    
		    
		    String[] paragraph = wordExtractor.getParagraphText();
		    
		    
		    Question[] question = new Question[paragraph.length/7];
		    for(int i=0;i<paragraph.length/7;i++)
		    	question[i]=new Question();
		    
		    
		    int j=0;
		    IdWorker worker2 = new IdWorker(1);
		    for(int i=0;i<question.length;i++)
		    {
		    	question[i].setSubject(paragraph[j++]);
		    	question[i].setOptionA(paragraph[j++]);
		    	question[i].setOptionB(paragraph[j++]);
		    	question[i].setOptionC(paragraph[j++]);
		    	question[i].setOptionD(paragraph[j++]);
		    	question[i].setAnswer(paragraph[j++]);
		    	question[i].setAnalysis(paragraph[j++]);
		    	question[i].setQid(worker2.nextId());
		    }
		    
		    
		    
		    for(int i=0;i<question.length;i++)
		    {
		    	System.out.println(question[i].getSubject());
		    	System.out.println(question[i].getOptionA());
		    	System.out.println(question[i].getOptionB());
		    	System.out.println(question[i].getOptionC());
		    	System.out.println(question[i].getOptionD());
		    	System.out.println(question[i].getAnswer());
		    	System.out.println(question[i].getAnalysis());
		    	
		    	questionDao.addQuestionList(question[i]);
		    }
		   } catch (FileNotFoundException e) {
		    e.printStackTrace();
		   } catch (IOException e) {
		   e.printStackTrace();
		}
		   	   
	}
	
}
