package cn.itcast.core.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Random;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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

	String[] questionType_Array={"", "单选题",  "多选题", "判断题", "填空题", "问答题", "简述题","名词解释"};
	String[] questionDifficulty_Array={"", "简单",  "中等", "困难"};
   
	
	public Page<Question> findQuestionList(Integer page, Integer rows, Integer qid,
			String subject,  String type) {
		Question question = new Question();
		
		
		question.setQid(qid);
		
		if(StringUtils.isNotBlank(subject)){
			question.setSubject(subject);
		}
		
		if(StringUtils.isNotBlank(type)){
			if(type.equals("0"))
				question.setType(null);
			else{	
				question.setType(questionType_Array[Integer.parseInt(type)]);
				System.out.println("type:" + question.getType());
			}
		}
		
		//当前页
		question.setStart((page-1) * rows) ;
		//每页数
		question.setRows(rows);
		//查询客户列表
		List<Question> questions = questionDao.selectQuestionList(question);
		//查询客户列表总记录数
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
	public void addQuestion(Integer qid, String subject, String type, String optionA, String optionB, String optionC, String optionD,  String optionE, String optionF, String optionG, 
			String answer, String courseName, String analysis, String chapter, String knowPoint, String difficulty){
		
		Question question = new Question();
		
		question.setQid(getIdBytime());
		
		if(StringUtils.isNotBlank(subject)){
			question.setSubject(subject);
		}
		
		if(StringUtils.isNotBlank(type)){
			if(type.equals("0"))
				question.setType(null);
			else{	
				question.setType(questionType_Array[Integer.parseInt(type)]);
			}
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

		if(StringUtils.isNotBlank(answer)){
			question.setAnswer(answer);
		}

		if(StringUtils.isNotBlank(courseName)){
			question.setCourseName(courseName);
		}

		if(StringUtils.isNotBlank(analysis)){
			question.setAnalysis(analysis);
		}

		if(StringUtils.isNotBlank(difficulty)){
			if(difficulty.equals("0"))
				question.setDifficulty(null);
			else{	
				question.setDifficulty(questionDifficulty_Array[Integer.parseInt(difficulty)]);
			}
		}
		

		System.out.println("iml " + question.getQid() + "   subject: " + question.getSubject() + "   type: " + question.getType() + "   difficulty: " + question.getDifficulty() + "   analysis: " + question.getAnalysis() + "   answer: " + question.getAnswer() + "   optionA: " + question.getOptionA());

//		if(!question.getType().equals(null)) 
		//要对各个值进行判断是否为空
		questionDao.addQuestionList(question);
	}
		
	//获取当前时间作为题目id
	public Integer getIdBytime()
	{
		long time=System.currentTimeMillis();
		Date date=new Date(time);
		String back = "HHmmss";
		String front = "MMdd";
		
		SimpleDateFormat format1=new SimpleDateFormat(front);
		SimpleDateFormat format2=new SimpleDateFormat(back);
		
		String year = format1.format(date);
		String hour = format2.format(date);
		
		
		Integer x = Integer.parseInt(year);
		Integer y = Integer.parseInt(hour);
		

		
		return x*1000000 + y;
	}
}
