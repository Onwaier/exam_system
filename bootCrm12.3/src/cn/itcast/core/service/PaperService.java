package cn.itcast.core.service;



import java.util.ArrayList;

import cn.itcast.common.utils.Page;
import cn.itcast.core.bean.Paper;



public interface PaperService {

	// 查询试卷列表
	public Page<Paper> findPaperList(Integer page, Integer rows, Long qid);
	//查询章节列表
	public ArrayList<String>findChapterList(Integer courseId);
	
	//查询知识点列表
	public ArrayList<String>findKnowpointList(Integer courseId, String chapter);
		
}