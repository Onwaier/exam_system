package cn.itcast.core.service;





import java.util.ArrayList;
import java.util.List;

import cn.itcast.common.utils.Page;
import cn.itcast.core.bean.Paper;
import cn.itcast.core.bean.Question;
import cn.itcast.core.bean.Course;



public interface PaperService {

	// 查询试卷列表
	public Page<Paper> findPaperList(Integer page, Integer rows, Long qid, Long courseId);

	//查询章节列表
	public ArrayList<String>findChapterList(Integer courseId);
	
	//查询知识点列表
	public ArrayList<String>findKnowpointList(Integer courseId, String chapter);	
	
	// 查询问题列表
	public Page<Question> findQuestionList(String type, Long courseId, String difficulty, String checkNodes);
	
	//查询所有科目
	public List<Course> findCourseList();
	
	//保存试卷到数据库并生成试卷到word中供下载
	public String paperSave(Long[] qids, Long courseId, String paperName, String userId, String userName) throws Exception;
		

	//删除试卷
	public void deletePaper(Long id);
	
	// 查询试卷列表,供试卷选题
	public Page<Paper> findPaper(Long courseId);
}