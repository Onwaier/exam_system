package cn.itcast.core.service.impl;

import java.io.File;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hwpf.extractor.WordExtractor;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFParagraph;
import org.apache.poi.xwpf.usermodel.XWPFPictureData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import cn.itcast.common.utils.CosineSimilarAlgorithm;
import cn.itcast.common.utils.IdWorker;
import cn.itcast.common.utils.Page;
import cn.itcast.common.utils.XWPFUtils;
import cn.itcast.core.bean.Paper;
import cn.itcast.core.dao.PaperDao;
import cn.itcast.core.service.PaperService;
import org.apache.commons.collections.CollectionUtils;
import org.apache.poi.xwpf.extractor.XWPFWordExtractor;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import org.apache.poi.hwpf.extractor.WordExtractor;
import org.apache.poi.xwpf.usermodel.XWPFPicture;

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



}
