package cn.itcast.core.service.impl;

import java.util.List;

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

	
	public Page<Question> findQuestionList(Integer page, Integer rows, Integer qid,
			String subject,  String type) {
		Question question = new Question();
		//判断客户名称(公司名称)
		
		question.setQid(qid);
		//判断客户信息来源
		if(StringUtils.isNotBlank(subject)){
			question.setSubject(subject);
		}
		//判断客户所属行业
		if(StringUtils.isNotBlank(type)){
			question.setType(type);
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


}
