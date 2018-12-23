package cn.itcast.core.bean;

import net.sf.json.JSONObject;

public class Question {
	private Long qid;
	private String subject;
	private String courseName;
	private Long courseId;
	private String chapter;
	private String difficulty;
	private String type;
	private Integer start;
	private Integer rows;
	private String optionA;
	private String optionB;
	private String optionC;
	public String getSpendTime() {
		return spendTime;
	}

	public void setSpendTime(String spendTime) {
		this.spendTime = spendTime;
	}

	public String getScore() {
		return score;
	}

	public void setScore(String score) {
		this.score = score;
	}

	private String optionD;
	private String optionE;
	private String optionF;
	private String optionG;
	private String answer;
	private String analysis;
	private String knowPoint;
	private String pictureUrl;
	private String spendTime;
	private String score;
	
	public String getPictureUrl() {
		return pictureUrl;
	}

	public void setPictureUrl(String pictureUrl) {
		this.pictureUrl = pictureUrl;
	}



	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getCourseName() {
		return courseName;
	}

	public void setCourseName(String courseName) {
		this.courseName = courseName;
	}

	public String getChapter() {
		return chapter;
	}

	public void setChapter(String chapter) {
		this.chapter = chapter;
	}

	public String getDifficulty() {
		return difficulty;
	}

	public void setDifficulty(String difficulty) {
		this.difficulty = difficulty;
	}
	
	public Integer getStart() {
		return start;
	}

	public void setStart(Integer start) {
		this.start = start;
	}

	public Integer getRows() {
		return rows;
	}

	public void setRows(Integer rows) {
		this.rows = rows;
	}

	public String getOptionA() {
		return optionA;
	}

	public void setOptionA(String optionA) {
		this.optionA = optionA;
	}

	public String getOptionB() {
		return optionB;
	}

	public void setOptionB(String optionB) {
		this.optionB = optionB;
	}

	public String getOptionC() {
		return optionC;
	}

	public void setOptionC(String optionC) {
		this.optionC = optionC;
	}

	public String getOptionD() {
		return optionD;
	}

	public void setOptionD(String optionD) {
		this.optionD = optionD;
	}

	public String getOptionE() {
		return optionE;
	}

	public void setOptionE(String optionE) {
		this.optionE = optionE;
	}

	public String getOptionF() {
		return optionF;
	}

	public void setOptionF(String optionF) {
		this.optionF = optionF;
	}

	public String getOptionG() {
		return optionG;
	}

	public void setOptionG(String optionG) {
		this.optionG = optionG;
	}



	public String getAnalysis() {
		return analysis;
	}



	public String getAnswer() {
		return answer;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}

	public void setAnalysis(String analysis) {
		this.analysis = analysis;
	}

	public String getKnowPoint() {
		return knowPoint;
	}

	public void setKnowPoint(String knowPoint) {
		this.knowPoint = knowPoint;
	}

	public Long getQid() {
		return qid;
	}

	public void setQid(Long qid) {
		this.qid = qid;
	}

	@Override
	public String toString() {
		JSONObject json = JSONObject.fromObject(this);//将java对象转换为json对象
		String str = json.toString();//将json对象转换为字符串
		System.out.println("改前:" + str);
		str = str.replace("\"", "\\\"");//对json字符串中的双引号转义
		str = str.replace("\'","\\\'");//对json字符串中的单引号转义
		str = str.replace("\\n", "\\\\n");//对json字符串的\n转义
		System.out.println("改后：" + str);
		return str;
//		return "Question [qid=" + qid + ", subject=" + subject + ", courseName=" + courseName + ", chapter=" + chapter
//				+ ", difficulty=" + difficulty + ", type=" + type + ", start=" + start + ", rows=" + rows + ", optionA="
//				+ optionA + ", optionB=" + optionB + ", optionC=" + optionC + ", optionD=" + optionD + ", optionE="
//				+ optionE + ", optionF=" + optionF + ", optionG=" + optionG + ", answer=" + answer + ", analysis="
//				+ analysis + ", knowPoint=" + knowPoint + ", pictureUrl=" + pictureUrl + "]";
	}

	public Long getCourseId() {
		return courseId;
	}

	public void setCourseId(Long courseId) {
		this.courseId = courseId;
	}

	
}
