package cn.itcast.core.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.itcast.common.utils.IdWorker;
import cn.itcast.common.utils.Page;
import cn.itcast.core.bean.Paper;
import cn.itcast.core.dao.PaperDao;
import cn.itcast.core.service.PaperService;

/**
 * 试题管理
 * @author lx
 *
 */

@Service("paperService")
@Transactional
public class PaperServiceImpl implements PaperService {

	// 定义dao属性
	@Autowired
	private PaperDao paperDao;


	IdWorker worker2 = new IdWorker(1);
   
	
	public Page<Paper> findPaperList(Integer page, Integer rows, Long qid) {
		Paper paper = new Paper();
		
		
		paper.setId(qid);
		

		
		System.out.println("\nfindPaperList: " + paper.getId());
		
		//当前页
		paper.setStart((page-1) * rows) ;
		//每页数
		paper.setRows(rows);
		//查询试卷列表
		List<Paper> papers = paperDao.selectPaperList(paper);
		//查询题目列表总记录数
		Integer count = paperDao.selectPaperListCount(paper);
		//创建Page返回对象
		Page<Paper> result = new Page<>();
		result.setPage(page);
		result.setRows(papers);
		result.setSize(rows);
		result.setTotal(count);
		
		return result;
	}

	//获取 chapter列表
	@Override
	public ArrayList<String> findChapterList(Integer courseId) {
		
		ArrayList<String>chapterList = paperDao.selectChapterList(courseId);
		return chapterList;
	}

//	获取知识点列表
	@Override
	public ArrayList<String> findKnowpointList(Integer courseId, String chapter) {
		ArrayList<String>knowpointList = paperDao.selectKnowpointList(courseId, chapter);
		return knowpointList;
	}


}
