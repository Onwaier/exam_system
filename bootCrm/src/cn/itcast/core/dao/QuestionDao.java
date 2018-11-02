package cn.itcast.core.dao;

import java.util.List;
import cn.itcast.core.bean.Question;


public interface QuestionDao {

	List<Question> selectQuestionList(Question question);
	Integer selectQuestionListCount(Question question);
	void deleteQuestion(Long id);
	/*Question getCustomerById(Long id);
	void updateCustomer(Question question);
	void deleteCustomer(Long id);*/
	
}