package cn.itcast.core.service;

import cn.itcast.common.utils.Page;
import cn.itcast.core.bean.Question;



public interface QuestionService {

	// 查询客户列表
	public Page<Question> findQuestionList(Integer page, Integer rows, Integer qid,
			String subject,  String type);
	
	public void deleteQuestion(Long id);
}