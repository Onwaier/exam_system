package cn.itcast.core.dao;

import java.util.List;
import cn.itcast.core.bean.Paper;


public interface PaperDao {

	List<Paper> selectPaperList(Paper question);
	Integer selectPaperListCount(Paper question);
	
	
}