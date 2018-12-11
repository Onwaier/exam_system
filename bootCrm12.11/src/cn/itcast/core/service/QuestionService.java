package cn.itcast.core.service;

import java.io.IOException;

import org.springframework.web.bind.annotation.RequestParam;

import cn.itcast.common.utils.Page;
import cn.itcast.core.bean.Question;



public interface QuestionService {

	// 查询问题列表
	public Page<Question> findQuestionList(Integer page, Integer rows, Long qid,
			String subject,  String type);
	
	//删除问题
	public void deleteQuestion(Long id);
	
	//添加问题
	public void addQuestion(Long qid, String subject, String type, String optionA, String optionB, String optionC, String optionD,  String optionE, String optionF, String optionG, 
			String answerOption, String answerJudge, String[] answerFill, String answerCloze, 
			String courseName, String analysis, String chapter, String knowPoint, String difficulty, String pictureUrl);
	
//	用word导入题目到数据库
	public void addQuestionByword(String position) throws IOException;

	//根据多个id查询题目列表
	public Page<Question> findQuestionListByIds(Integer page, Integer rows, Long[] qids);

	//更新题目
	public void updateQuestion(String qid, String subject, String type, String optionA, String optionB, String optionC,
			String optionD, String optionE, String optionF, String optionG, String answerOption, String answerJudge,
			String[] answerFills, String answerCloze, String courseName, String analysis, String chapter,
			String knowPoint, String difficulty, String pictureUrl);
		
}