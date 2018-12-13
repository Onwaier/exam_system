package cn.itcast.core.dao;

import java.util.ArrayList;
import java.util.List;
import cn.itcast.core.bean.Paper;
import cn.itcast.core.bean.Question;
import cn.itcast.core.bean.Course;


public interface PaperDao {

	List<Paper> selectPaperList(Paper question);
	Integer selectPaperListCount(Paper question);
	
	ArrayList<String> selectChapterList(int courseId);
	ArrayList<String> selectKnowpointList(int courseId, String chapter);
	
	List<Question> selectQuestionList(Question question);
	Integer selectQuestionListCount(Question question);
	List<Course> selectCourseList(Course course);
	void deletePaper(Long id);
}