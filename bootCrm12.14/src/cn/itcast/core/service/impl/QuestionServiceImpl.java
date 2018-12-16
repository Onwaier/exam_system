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
import cn.itcast.core.bean.Customer;
import cn.itcast.core.bean.Question;
import cn.itcast.core.dao.BaseDictDao;
import cn.itcast.core.dao.CustomerDao;
import cn.itcast.core.dao.QuestionDao;
import cn.itcast.core.service.CustomerService;
import cn.itcast.core.service.QuestionService;
import org.apache.commons.collections.CollectionUtils;

import org.apache.poi.xwpf.extractor.XWPFWordExtractor;
//import org.apache.commons.lang.StringUtils;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFParagraph;
import org.apache.poi.xwpf.usermodel.XWPFPictureData;


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

@Service("questionService")
@Transactional
public class QuestionServiceImpl implements QuestionService {

	// 定义dao属性
	@Autowired
	private QuestionDao questionDao;
	@Autowired
	private BaseDictDao baseDictDao;

	IdWorker worker2 = new IdWorker(1);
   
	
	public Page<Question> findQuestionList(Integer page, Integer rows, Long qid,
			String subject,  String type) {
		Question question = new Question();
		
		
		question.setQid(qid);
		
		if(StringUtils.isNotBlank(subject)){
			question.setSubject(subject);
		}
		
		if(StringUtils.isNotBlank(type)){	
			if(!type.equals("0"))
				question.setType(type);
		}
		
		System.out.println("\nfindQuestionList " + question.getQid() + "   subject: " + question.getSubject() + "   type: " + question.getType());
		
		//当前页
		question.setStart((page-1) * rows) ;
		//每页数
		question.setRows(rows);
		//查询题目列表
		List<Question> questions = questionDao.selectQuestionList(question);
		//查询题目列表总记录数
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
	
	@Override
	public void updateQuestion(String qid, String subject, String type, String optionA, String optionB, String optionC, String optionD,  String optionE, String optionF, String optionG, 
			String answerOption, String answerJudge, String[] answerFill, String answerCloze, 
			String courseName, String analysis, String chapter, String knowPoint, String difficulty, String pictureUrl){
			Question question = new Question();
			System.out.println("qid:" + qid);
			
			question.setQid(Long.parseLong(qid));
			if(StringUtils.isNotBlank(subject)){
				question.setSubject(subject);
			}
			
			if(StringUtils.isNotBlank(type)){
					question.setType(type);
			}
			
			if(StringUtils.isNotBlank(optionA)){
				question.setOptionA(optionA);
			}
			
			if(StringUtils.isNotBlank(optionB)){
				question.setOptionB(optionB);
			}
			
			if(StringUtils.isNotBlank(optionC)){
				question.setOptionC(optionC);
			}
			
			if(StringUtils.isNotBlank(optionD)){
				question.setOptionD(optionD);
			}
			
			if(StringUtils.isNotBlank(optionE)){
				question.setOptionE(optionE);
			}
			
			if(StringUtils.isNotBlank(optionF)){
				question.setOptionF(optionF);
			}
			
			if(StringUtils.isNotBlank(optionG)){
				question.setOptionG(optionG);
			}
			

			if(StringUtils.isNotBlank(answerOption)){
				question.setAnswer(answerOption);
			}

			if(StringUtils.isNotBlank(courseName)){
				question.setCourseName(courseName);
			}

			if(StringUtils.isNotBlank(analysis)){
				question.setAnalysis(analysis);
			}

			if(StringUtils.isNotBlank(difficulty)){
					question.setDifficulty(difficulty);
			}
			
			if(StringUtils.isNotBlank(pictureUrl)){
				question.setPictureUrl(pictureUrl);
			}
			//根据题型对answer进行赋值
			System.out.println("type:" + type);
			if(type.equals("单选题") || type.equals("多选题")) question.setAnswer(answerOption);
			if(type.equals("判断题")) question.setAnswer(answerJudge);
			if(type.equals("问答题") || type.equals("简述题") || type.equals("名词解释")) question.setAnswer(answerCloze);
			if(type.equals("填空题")) {
				String temp = "";
				for(int i = 0; i < answerFill.length-1; ++i)
					temp = temp + answerFill[i] + '#';
				temp = temp + answerFill[answerFill.length-1];
				question.setAnswer(temp);
			}
			//在修改题目后插入前无需进行查重判断，因为对题目的修改一般都是局部，与原题相似度较高。
			//避免刷新时进行题目更新
			if(StringUtils.isNotBlank(question.getType())){
				questionDao.updateQuestion(question);
				System.out.println("题目更新成功!");
			}
	}

//	手动添加试题
	@Override
	public Boolean addQuestion(Long qid, String subject, String type, String optionA, String optionB, String optionC, String optionD,  String optionE, String optionF, String optionG, 
			String answerOption, String answerJudge, String[] answerFill, String answerCloze,  
			String courseName, String analysis, String chapter, String knowPoint, String difficulty, String pictureUrl){
		
		Question question = new Question();
		

		question.setQid(worker2.nextId());
		
		if(StringUtils.isNotBlank(subject)){
			question.setSubject(subject);
		}
		
		if(StringUtils.isNotBlank(type)){
				question.setType(type);
		}
		
		if(StringUtils.isNotBlank(optionA)){
			question.setOptionA(optionA);
		}
		
		if(StringUtils.isNotBlank(optionB)){
			question.setOptionB(optionB);
		}
		
		if(StringUtils.isNotBlank(optionC)){
			question.setOptionC(optionC);
		}
		
		if(StringUtils.isNotBlank(optionD)){
			question.setOptionD(optionD);
		}
		
		if(StringUtils.isNotBlank(optionE)){
			question.setOptionE(optionE);
		}
		
		if(StringUtils.isNotBlank(optionF)){
			question.setOptionF(optionF);
		}
		
		if(StringUtils.isNotBlank(optionG)){
			question.setOptionG(optionG);
		}
		

		if(StringUtils.isNotBlank(answerOption)){
			question.setAnswer(answerOption);
		}

		if(StringUtils.isNotBlank(courseName)){
			question.setCourseName(courseName);
		}

		if(StringUtils.isNotBlank(analysis)){
			question.setAnalysis(analysis);
		}

		if(StringUtils.isNotBlank(difficulty)){
				question.setDifficulty(difficulty);
		}
		
		if(StringUtils.isNotBlank(pictureUrl)){
			question.setPictureUrl(pictureUrl);
	}
		
		System.out.print("\niml " +  "  answerOption: " + answerOption + "   answerJudge: " + answerJudge + "   answerCloze: " + answerCloze);
		System.out.print("  answerFill: " + answerFill.length);
		for(int i = 0; i < answerFill.length; ++i)
			System.out.print("  " + answerFill[i] + " ");
		
		
		//根据题型对answer进行赋值
		if(type.equals("单选题") || type.equals("多选题")) question.setAnswer(answerOption);
		if(type.equals("判断题")) question.setAnswer(answerJudge);
		if(type.equals("问答题") || type.equals("简述题") || type.equals("名词解释")) question.setAnswer(answerCloze);
		if(type.equals("填空题")) {
			String temp = "";
			for(int i = 0; i < answerFill.length-1; ++i)
				temp = temp + answerFill[i] + '#';
			temp = temp + answerFill[answerFill.length-1];
			question.setAnswer(temp);
		}
		

		System.out.println("\niml " + question.getQid() + "   subject: " + question.getSubject() + "   type: " + question.getType() + "   difficulty: " + question.getDifficulty() + "   analysis: " + question.getAnalysis() +  "   optionA: " + question.getOptionA() + "   optionE: " + question.getOptionE() + "   answer: " + question.getAnswer()+ "   pictureUrl: " + question.getPictureUrl() + "\n");


		//要对各个值进行判断是否为空
		if(StringUtils.isNotBlank(question.getType())){
			if(judgeQuestionSimilar(question)){ //进行试题查重判断，不存在重复题目侧插入试题
				questionDao.addQuestionList(question);
				return true;
			}
			else{
				return false;
			}
		}
		else{
			return false;
		}

	}
	
//	通过word模板添加试题
	@Override
	public void addQuestionByword(String position)  throws IOException{
		List<String> pictureLastParagraphText = new ArrayList(); //保存各个图片的上文
		List<String> pictureUrl = new ArrayList(); //保存各个图片的存储位置
		String path =  position; //模板的位置
		
		
		//获取word中图片的上文
        InputStream in = new FileInputStream(path);
        XWPFDocument xwpfDocument = new XWPFDocument(in);
        List<XWPFParagraph> paragraphList = xwpfDocument.getParagraphs();
        System.out.println("图片的索引\t|图片名称\t|图片上一段文字的内容\t");
        System.out.println("------------------------------------------");
        for(int i = 0;i < paragraphList.size();i++){
            List<String> imageBundleList = XWPFUtils.readImageInParagraph(paragraphList.get(i));
            if(CollectionUtils.isNotEmpty(imageBundleList)){
                for(String pictureId:imageBundleList){
                    XWPFPictureData pictureData = xwpfDocument.getPictureDataByID(pictureId);
                    String imageName = pictureData.getFileName();
                    String lastParagraphText = paragraphList.get(i-1).getParagraphText();
                    System.out.println(pictureId +"\t|" + imageName + "\t|" + lastParagraphText);
                    pictureLastParagraphText.add(lastParagraphText); //存储每张图片的上文
                }
            }
        }
        
        //-----考虑把找到图片上文与存储图片合并-------------处理其余冗余---------------------------------------------------------------------//
        
//        处理word（docx）中的文字与图片
		File file = new File(path);     
		FileInputStream fis = new FileInputStream(file);
		XWPFDocument document = new XWPFDocument(fis);
		XWPFWordExtractor xwpfWordExtractor = new XWPFWordExtractor(document);
		
		
		//存储图片位置
	    List<XWPFPictureData> picList = document.getAllPictures();
		int length = 0;
		for (XWPFPictureData pic : picList) {
			System.out.println(length + ": " + pic.getPictureType() + file.separator + pic.suggestFileExtension()
					+file.separator+pic.getFileName());
			byte[] bytev = pic.getData();
			FileOutputStream fos = new FileOutputStream("d:\\"+ "a" + pic.getFileName()); 
			pictureUrl.add("d:\\"+ "a" + pic.getFileName()); //存储每张图片的位置
			fos.write(bytev);
			length++;
		}
			
		fis.close();
		
		
		//对word中题目进行录入
		int numQuestion = 0;
		
		String text = xwpfWordExtractor.getText();
		String[]  paragraph =text.split("\n");
		
		
//		test(paragraph);
		
		int i = 0, len = paragraph.length;
		String courseName = paragraph[i++];
		
		while(paragraph[i++].equals("\n"));
		Question question = new Question();
		
		while(i < len)
		{
			try{
	//			对单选题与多选题进行录入
				if(paragraph[i].equals("单选题") || paragraph[i].equals("多选题")){
					IdWorker worker2 = new IdWorker(1);
					question.setQid(worker2.nextId());
					question.setCourseName(courseName);
					question.setType(paragraph[i++]);
					int numOption = Integer.parseInt(paragraph[i++]);
					question.setSubject(paragraph[i++]);
					for(int j = 0; j < numOption; ++j){
						switch(j){
				        case 0:
				            question.setOptionA(paragraph[i++]);
				            break;
				        case 1:
				        	question.setOptionB(paragraph[i++]);
				        	break;
				        case 2:
				        	question.setOptionC(paragraph[i++]);
				        	break;
				        case 3:
				        	question.setOptionD(paragraph[i++]);
				        	break;
				        case 4:
				        	question.setOptionE(paragraph[i++]);
				        	break;
				        case 5:
				        	question.setOptionF(paragraph[i++]);
				        	break;
				        case 6:
				        	question.setOptionG(paragraph[i++]);
				        	break;
				        }
					}
					
					question.setAnswer(paragraph[i++]);
					question.setAnalysis(paragraph[i++]);
					question.setPictureUrl(paragraph[i]);
					
	//				解决一道题可能有多张图片的问题
					judegWithPicture(question, paragraph[i], pictureLastParagraphText, pictureUrl);
					int k = i+2;
					if(!judgeBoundary(k, len, question)) break; 
					while(paragraph[i].equals(paragraph[k])){
						i = k; k = k+2;
						if(!judgeBoundary(k, len, question)) return; 
					};
					
					++i;
					if(!judgeBoundary(i, len, question)) break; 
					while((paragraph[i].equals("\n") || paragraph[i].equals("")) && (i < len)) ++i;
					dispQuestion(question);
					if(judgeQuestionSimilar(question)){ //进行试题查重判断，不存在重复题目侧插入试题
						questionDao.addQuestionList(question);
					}
					++numQuestion; //记录当前题目为第几题
					continue;
					
				}else if(paragraph[i].equals("判断题") || paragraph[i].equals("填空题") || paragraph[i].equals("问答题")){ //对判断题，填空题，问答题进行录入
					IdWorker worker2 = new IdWorker(1);
					question.setQid(worker2.nextId());
					question.setCourseName(courseName);
					question.setType(paragraph[i++]);
					question.setSubject(paragraph[i++]);
					question.setAnswer(paragraph[i++]);
					question.setAnalysis(paragraph[i++]);
					question.setPictureUrl(paragraph[i]);
					
	//				解决一道题可能有多张图片的问题
					judegWithPicture(question, paragraph[i], pictureLastParagraphText, pictureUrl);
					int k = i+2;
					if(!judgeBoundary(k, len, question)) break; 
					while(paragraph[i].equals(paragraph[k])){
						i = k; k = k+2;
						if(!judgeBoundary(k, len, question)) return; 
					};
					
					
					++i;
					if(!judgeBoundary(i, len, question)) break; 
					while((paragraph[i].equals("\n") || paragraph[i].equals("")) && (i < len))
						++i;
					dispQuestion(question);
					if(judgeQuestionSimilar(question)){ //进行试题查重判断，不存在重复题目侧插入试题
						questionDao.addQuestionList(question);
					}
					++numQuestion; //记录当前题目为第几题
					continue;
					
				}else{
//					System.out.println(numQuestion + "identify error！！！");
				}
				
				while((paragraph[i].equals("\n") || paragraph[i].equals("")) && (i < len)) ++i;
				
			}catch (IndexOutOfBoundsException  e1){            
				System.out.println(numQuestion + "空指针异常");
			}catch (Exception e){  //所有异常的父类          
				System.out.println(numQuestion + "未知异常");
			}
			
		}
		
    }
	
//	输出题目
	  static void dispQuestion(Question question){
    	 System.out.println("\n"  + "courseName: " + question.getCourseName() + "\ntype: " + question.getType() + "\nsubject: " + question.getSubject() +  
    			 "\noptionA: " + question.getOptionA() + "\noptionB: " + question.getOptionB() + "\noptionC: " + question.getOptionC() + "\noptionD: " + question.getOptionD() + "\noptionE: " + question.getOptionE() + "\noptionF: " + question.getOptionF() + "\noptionG: " + question.getOptionG() + 
    			 "\nanswer: " + question.getAnswer() + "\nanalysis: " + question.getAnalysis() +    "\npictureUrl: " + question.getPictureUrl() + "\n");
    }
	  
//	  将图片位置赋值给对应题目
	  public void  judegWithPicture(Question question, String pictureMark, List<String> pictureLastParagraphText, List<String> pictureUrl){
		  int len = pictureLastParagraphText.size();
		  String[] pictureText = pictureLastParagraphText.toArray(new String[pictureLastParagraphText.size()]);  
		  String[] Url = pictureUrl.toArray(new String[pictureUrl.size()]);  
		  String tempUrl = "";
		  
		  for(int i = 0; i < len; ++i){
			  if(pictureMark.equals( pictureText[i] )){
				  tempUrl = tempUrl + Url[i] + "#";
			  }
		  }
		  
		  question.setPictureUrl(tempUrl);
	  }
	  
//	  判断是否到达word最后一行，避免数组越界
	  public boolean judgeBoundary(int k, int len, Question question){
			if(k >= len){
				dispQuestion(question);
				if(judgeQuestionSimilar(question)){ //进行试题查重判断，不存在重复题目侧插入试题
					questionDao.addQuestionList(question);
				}
				return false;
			}
			
			return true;
	  }
	  
//	  判断数据库是否存在与带插入题目相似的题目
	  public boolean judgeQuestionSimilar(Question question){
		  	Question temp = new Question();
		  	temp.setType(question.getType());
		  	
		  	
			List questionSimilar = new ArrayList(); //存储相似题目
			List questionSameType = new ArrayList(); //存储与带查重题目相同类型的题目
			CosineSimilarAlgorithm c = new CosineSimilarAlgorithm();
			
			String doc1=null; //要插入的题目
	    	String doc2=null;
			questionSameType =  questionDao.selectQuestionList(temp);
			doc1 = question.getSubject();
			int i = 0;
			for(; i < questionSameType.size(); ++i){
				doc2 = ((Question) questionSameType.get(i)).getSubject();
				if(doc2 == null)
    			{
    				//如果数据库中题干为空，什么也不做
    			}
    			else if(c.getSimilarity(doc1,doc2)>0.95)//相似度大于0.95时，认为题目重复题目
	    		{
    				questionSimilar.add(questionSameType.get(i));
  
	    			break;
	    		}
			}
			
			
			if(i == questionSameType.size()){
				dispQuestion(question);
				return true;
			}
			else{
				System.out.println("\n" + "存在相似题目：\n");
				System.out.println("\n带插入题目：\n"  + "courseName: " + question.getCourseName() + "\ntype: " + question.getType() + "\nsubject: " + question.getSubject() +  
		    			 "\noptionA: " + question.getOptionA() + "\noptionB: " + question.getOptionB() + "\noptionC: " + question.getOptionC() + "\noptionD: " + question.getOptionD() + "\noptionE: " + question.getOptionE() + "\noptionF: " + question.getOptionF() + "\noptionG: " + question.getOptionG() + 
		    			 "\nanswer: " + question.getAnswer() + "\nanalysis: " + question.getAnalysis() +    "\npictureUrl: " + question.getPictureUrl() + "\n");
				System.out.println("\n相似题目：\n"  + "courseName: " + ((Question) questionSimilar.get(0)).getQid() + "\ntype: " + ((Question) questionSimilar.get(0)).getType() + "\nsubject: " + ((Question) questionSimilar.get(0)).getSubject() +  
		    			 "\noptionA: " + ((Question) questionSimilar.get(0)).getOptionA() + "\noptionB: " + ((Question) questionSimilar.get(0)).getOptionB() + "\noptionC: " + ((Question) questionSimilar.get(0)).getOptionC() + "\noptionD: " + ((Question) questionSimilar.get(0)).getOptionD() + "\noptionE: " + ((Question) questionSimilar.get(0)).getOptionE() + "\noptionF: " + ((Question) questionSimilar.get(0)).getOptionF() + "\noptionG: " + ((Question) questionSimilar.get(0)).getOptionG() + 
		    			 "\nanswer: " + ((Question) questionSimilar.get(0)).getAnswer() + "\nanalysis: " + ((Question) questionSimilar.get(0)).getAnalysis() +    "\npictureUrl: " + ((Question) questionSimilar.get(0)).getPictureUrl() + "\n");
				return false;
			}
			
	  }
	
	@Override
	public Page<Question> findQuestionListByIds(Integer page, Integer rows, Long[] qids) {
		//查询题目列表
		List<Question> questions = questionDao.selectQuestionListByIds(qids);
		//查询题目列表总记录数
		Integer count = qids.length;
		//创建Page返回对象
		Page<Question> result = new Page<>();
		result.setPage(page);
		result.setRows(questions);
		result.setSize(rows);
		result.setTotal(count);
		return result;
	}
}
