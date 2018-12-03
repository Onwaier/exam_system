package cn.itcast.core.service;



import java.io.IOException;

import org.springframework.web.bind.annotation.RequestParam;

import cn.itcast.common.utils.Page;
import cn.itcast.core.bean.Paper;



public interface PaperService {

	// 查询试卷列表
	public Page<Paper> findPaperList(Integer page, Integer rows, Long qid);

		
}