package cn.itcast.core.bean;

public class Paper {
	private Long id;
	private String title;
	private Long courseId;
	private String courseName;
	private String joinTime;
	private String questionSet;
	private String userId;
	private String userName;
	private Integer scoreAve;
	private Integer typeNum;
	private String typeScore;
	
	private Integer start;
	private Integer rows;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public Long getCourseId() {
		return courseId;
	}

	public void setCourseId(Long courseId) {
		this.courseId = courseId;
	}

	public String getJoinTime() {
		return joinTime;
	}

	public void setJoinTime(String joinTime) {
		this.joinTime = joinTime;
	}

	public String getQuestionSet() {
		return questionSet;
	}

	public void setQuestionSet(String questionSet) {
		this.questionSet = questionSet;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public Integer getScoreAve() {
		return scoreAve;
	}

	public void setScoreAve(Integer scoreAve) {
		this.scoreAve = scoreAve;
	}

	public Integer getTypeNum() {
		return typeNum;
	}

	public void setTypeNum(Integer typeNum) {
		this.typeNum = typeNum;
	}

	public String getTypeScore() {
		return typeScore;
	}

	public void setTypeScore(String typeScore) {
		this.typeScore = typeScore;
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

	public String getCourseName() {
		return courseName;
	}

	public void setCourseName(String courseName) {
		this.courseName = courseName;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

}
