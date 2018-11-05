package cn.itcast.core.service;

import cn.itcast.common.utils.Page;
import cn.itcast.core.bean.Question;



public interface QuestionService {

	// 查询问题列表
	public Page<Question> findQuestionList(Integer page, Integer rows, Integer qid,
			String subject,  String type);
	
	//删除问题
	public void deleteQuestion(Long id);
	
	//添加问题
	public void addQuestion(Integer qid, String subject, String type, String optionA, String optionB, String optionC, String optionD,  String optionE, String optionF, String optionG, 
			String answer, String courseName, String analysis, String chapter, String knowPoint, String difficulty);
		
}