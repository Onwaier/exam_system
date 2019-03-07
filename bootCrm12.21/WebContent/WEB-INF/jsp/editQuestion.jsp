<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="itcast" uri="http://itcast.cn/common/"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<title>编辑试题</title>

<!-- Bootstrap Core CSS -->
<link href="<%=basePath%>css/bootstrap.min.css" rel="stylesheet">

<!-- MetisMenu CSS -->
<link href="<%=basePath%>css/metisMenu.min.css" rel="stylesheet">

<!-- DataTables CSS -->
<link href="<%=basePath%>css/dataTables.bootstrap.css" rel="stylesheet">


<!-- Custom Fonts -->
<link href="<%=basePath%>css/font-awesome.min.css" rel="stylesheet"
	type="text/css">
<link href="<%=basePath%>css/boot-crm.css" rel="stylesheet"
	type="text/css">
<!-- Custom CSS -->
<link href="<%=basePath%>css/sb-admin-2.css" rel="stylesheet">
<link href="<%=basePath%>css/addQuestion.css" rel="stylesheet">
<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>

<body>

	<div id="wrapper">

		<!-- Navigation -->
		<nav class="navbar navbar-default navbar-static-top" role="navigation"
			style="margin-bottom: 0">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse"
				data-target=".navbar-collapse">
				<span class="sr-only">Toggle navigation</span> </span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="${pageContext.request.contextPath }/question/list.action">e卷题库抽题组卷系统v1.0</a>
		</div>
		<!-- /.navbar-header -->
		
		
		 
		<!-- /.navbar-top-links -->

		<div class="navbar-default sidebar" role="navigation" id = "question-sidebar">
			<div class="sidebar-nav navbar-collapse">
				<ul class="nav" id="side-menu">
					<li><a href="${pageContext.request.contextPath }/question/list.action" class="active"><i
							class="fa fa-edit fa-fw"></i> 题目管理</a></li>
					<li><a href="${pageContext.request.contextPath }/paper/list.action"><i
							class="fa fa-dashboard fa-fw"></i> 试卷管理</a></li>
				</ul>
			</div>
			<!-- /.sidebar-collapse -->
		</div>
		<!-- /.navbar-static-side --> </nav>

		<div id="page-wrapper">
			
			
			
			<div id="myTabContent" class="tab-content">
				
				<div class="tab-pane fade in active" id="manualInput">
					<c:forEach items="${page.rows}" var="row">
						<form class="form-inline" action="${pageContext.request.contextPath }/question/update.action" method="post" enctype="multipart/form-data" onsubmit="return checkAddQuestion()">	

							<div class="batch-type">
										<span class="intro course">科目</span>
										<input id="editQuestionCourse" type="hidden"  value="${row.courseName}" >
										<select	class="form-control" id = "questionCourse" style="width:100px;" name = "courseName" onchange="updateChapterSel();">
											<option value="">--请选择--</option>
										</select>
										<span class="intro chapter">章节</span>
										<input id="editQuestionChapter" type="hidden"  value="${row.chapter}" >
										<select	class="form-control"  id = "questionChapter" style="width:100px;" name = "chapter" onchange="updateKnowpointSel();">
											<option value="">--请选择--</option>
										</select>
										<span class="intro knowpoint">知识点</span>
										<input id="editQuestionKnowpoint" type="hidden"  value="${row.knowPoint}" >
										<select	class="form-control" id = "questionKnowpoint" style="width:100px;" name = "knowPoint">
											<option value="">--请选择--</option>
										</select>
				
											<span class="intro type">试题类型</span>
											<input id="editQuestionType" type="hidden"  value="${row.type}" >
											<select	class="form-control" id="questionType" name="type">
												<option value="0">--请选择--</option>
												<option value="单选题">单选题</option>
												<option value="多选题">多选题</option>
												<option value="判断题">判断题</option>
												<option value="填空题">填空题</option>
												<option value="简答题">简答题</option>
												<option value="应用题">应用题</option>
												<option value="设计题">设计题</option>	
											</select> 
				
											<span class="intro difficulty">难度</span>
											<input id="editQuestionDifficulty" type="hidden"  value="${row.difficulty}" >
											<select	class="form-control" id="questionDifficulty" name="difficulty">
												<option value="0">--请选择--</option>
												<option value="简单">简单</option>
												<option value="中等">中等</option>
												<option value="困难">困难</option>
											</select>    			
							</div>
							
							<div class="question-content">
							<input id="questionId" type="hidden"  name = "qid" value="${row.qid}">
								<div class="descPanel" id = "descOfQuestion">
		                                <div class="title">
		                                    <span class="tip">题干</span>
		                                    <span class="intro">这里填写题目描述</span>
		                                </div>
		                                <div class = "editor">
		                                	<textarea rows="2" cols="80" type="text"  id="subject" value="" name="subject">${row.subject}</textarea> 
		                                </div>
		                                
		                        </div>
		
		                        <div class="keyRadio keyPanel" id = "radioOfQuestion" style="display: block;">
		                        	<div class="title">
		                                    <span class="tip">选项</span>
		                                    <span class="intro">单/多选题的选项范围从&nbsp;2&nbsp;到&nbsp;8&nbsp;</span>
		                            </div>
		                            <div>
			                            	<div class="keyLeft">
		                                        <input type="radio" class="radioOrCheck" name="answerOption" value="A" onclick="getValue()" />
		                                        <textarea rows="2" cols="80" class = "radioEdit" id="edit_optionA"  name="optionA">${row.optionA}</textarea>
			                                </div>
		                                    <div class="keyLeft">
		                                       <input type="radio" class="radioOrCheck" name="answerOption" value="B" />
		                                       <textarea rows="2" cols="80" class = "radioEdit" id="edit_optionB"  name="optionB">${row.optionB}</textarea>
		                                    </div>
		                                    <div class="keyLeft">
		                                       <input type="radio" class="radioOrCheck" name="answerOption" value="C" />
		                                       <textarea rows="2" cols="80" class = "radioEdit" id="edit_optionC"  name="optionC">${row.optionC}</textarea>
		                                       <span class = "removeKey" onclick="removeKeys(this)"><i class="fa fa-trash" aria-hidden="true"></i></span>
		                                    </div>
		                                    <div class="keyLeft">
		                                       <input type="radio" class="radioOrCheck" name="answerOption" value="D" />
		                                       <textarea rows="2" cols="80" class = "radioEdit" id="edit_optionD"  name="optionD">${row.optionD}</textarea>
		                                       <span class = "removeKey" onclick="removeKeys(this)"><i class="fa fa-trash" aria-hidden="true"></i></span>
		                                    </div>
		                                    <div class="addKeyBtn">
		                                    	<button type="button" class="btn btn-l-gray addKey"><i class="plus-style icons8-plus"></i>添加一个选项</button>
		                                	</div>
		                            </div>
								</div>
							
								<div class="keyFill keyPanel" id = "fillOfQuestion" style="display: none;">
									<div class="title">
		                                 <span class="tip">答案</span>
		                                 <span class="intro">
		                                 		请填写每个填空的答案
		                                 </span> 
		                            </div>
		                            <div class="keyFillContent" style="display: block;">
		                                <div class="input-group">
		                                    <span class="input-group-addon keyFillNum">1</span>
		                                    <input type="text" name="answerFill[]" class="bootstrap-tagsinput" id="answerFill[]" data-role="tagsinput" placeholder="请输入答案，按下回车添加同义词。" style="display: block;">
		                                </div>
		                               
		                           	</div>
		                            <div class="addKeyFillBtn">
		                                    <button type="button" class="btn btn-l-gray addKeyFill"><i class="plus-style icons8-plus" style="top: 0"></i>增加一个填空</button>
		                            </div>
		                        </div>
		                          
		                        <div class="keyJudge keyPanel" id = "judgeOfQuestion" style="display: none;">
		                                <div class="title">
		                                    <span class="tip">选项</span>
		                                    <span class="intro">选择正确或者错误（默认正确）</span>
		                                </div>
		                                
		                                <input type="radio" class="hidden"  name="answerJudge" id="judgeYes" value="正确" checked>
		                                <label for="judgeYes" class="btn btn-border-gray">正确</label>
		                                <input type="radio" class="hidden"  name="answerJudge" id="judgeNo" value="错误">
		                                <label for="judgeNo" class="btn btn-border-gray">错误</label> 
		                         </div>
		                            
		                        <div class="keyCloze keyPanel" id = "clozeOfQuestion" style="display: none;">
		                          		<div class="title">
		                                    <span class="tip">答案</span>
		                                    <span class="intro">这里填写答案</span>
		                                </div>
		                                <div class = "editor">
			                                <textarea rows="2" cols="80" id="answerCloze"  name="answerCloze">${row.answer}</textarea>
		                                </div>
		                        </div>
		                          
		                        <div class="analysisPanel" id = "analysisOfQuestion" style="display: block;">
		                          		<div class="title">
		                                    <span class="tip">解析</span>
		                                    <span class="intro">这里填写该问题对应的答案解释</span>
		                                </div>
		                                <div>
		                                	<textarea rows="2" cols="80"   id="analysis" value="${analysis}" name="analysis">${row.analysis}</textarea>
		                                </div>
		                        </div>
	                             
			                     <div class="lccid">
									<p class="title">
									<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
											题干图片</p>
									<img src="<%=basePath%>images/questionImg/${subjectPic}" / class="img">
<%-- 									<img src='"<%=basePath%>images/questionImg/"+"add.png"'  class="img"> --%>
									<input id = "subjectPic" type="file" class="file" placeholder="ICCID" accept="image/*" capture="camera" name="uploadfile" multiple="multiple">
									<input type="checkbox" class="radioOrCheck" name="deleteSubjectPic" value="deleteSubjectPic" />
								</div>
								
								<div class="lccid">
									<p class="title">
									<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
											答案图片</p>
									<img src="<%=basePath%>images/questionImg/${answerPic }" / class="img">
									<input type="file" class="file" placeholder="ICCID" accept="image/*" capture="camera" name="uploadfile" multiple="multiple">
									<input type="checkbox" class="radioOrCheck" name="deleteAnswerPic" value="deleteAnswerPic" />
								</div>        
					

							<button type="submit" class="btn btn-primary">录入题目</button>
						</form>
					</c:forEach> 
				</div>
				
				<div class="tab-pane fade" id="fileInput">
						<div id="excelImport">
				            <div class="btn-row" style="text-align: center;">
				                <img style="margin-top: 50px;" src="<%=basePath%>images/batch-add-excel.png" alt="">
				            </div>
				            <img src='<%=basePath%>images/loading.gif' class="loading" style="position:absolute;top: 30%;left: 40%;width:250px;display:none;border-radius: 30px;box-shadow: 2px 2px 5px #ccc;"/>
				            <div class="btn-row" style="text-align: center;">
				                <a class="btn btn-primary download" href="https://cdn.oss.kaoshixing.com/exam_teamplate_test.xls" style="margin-right: 205px;">下载模版</a>
				                <!-- <input id="file_upload" name="file_upload" type="file" multiple="true"/> -->
				                <form id="uploadForm" class="upload-form">
				                    <div class="btn btn-primary upload">上传excel<input type="file" onchange="importf(this)" name="uploadFile" id="excelUpload"/></div>
				                    <div class="tip">excel表格大小限制为1MB以下</div>
				                </form>
				            </div>
				        </div>
				        <div id="wordImport" style="display:none">
				            <div class="btn-row" style="text-align: center;">
				                <img style="margin-top: 50px;" src="<%=basePath%>images/batch-add-word.png" alt="">
				            </div>
				            <img src='<%=basePath%>images/loading.gif' class="loading" style="position:absolute;top: 30%;left: 40%;width:250px;display:none;border-radius: 30px;box-shadow: 2px 2px 5px #ccc;"/>
				            <div class="btn-row" style="text-align: center;">
					             <button class="btn btn-primary download" style="margin-right: 205px;" onclick="window.location.href='${pageContext.request.contextPath }/question/showFile.action'" type="button">
									下载模板
								 </button>
				                <!-- <input id="file_upload" name="file_upload" type="file" multiple="true"/> -->
				                <form id="uploadForm" class="upload-form">
				                    <button class="btn btn-primary upload" onclick="window.location.href='${pageContext.request.contextPath }/question/wordInput.action'" type="button">上传word</button>
				                    <div class="tip">word大小限制为1MB以下</div>
				                </form>
				                
				                
				                
				            </div>
				            
				        </div>
				   
				</div>
	
		   </div>


		</div>
	</div>
	
	
	<!-- 客户编辑对话框 -->
	
	<!-- /#wrapper -->

	<!-- jQuery -->
	<script src="<%=basePath%>js/jquery.min.js"></script>

	<!-- Bootstrap Core JavaScript -->
	<script src="<%=basePath%>js/bootstrap.min.js"></script>

	<!-- Metis Menu Plugin JavaScript -->
	<script src="<%=basePath%>js/metisMenu.min.js"></script>

	<!-- DataTables JavaScript -->
	<script src="<%=basePath%>js/jquery.dataTables.min.js"></script>
	<script src="<%=basePath%>js/dataTables.bootstrap.min.js"></script>

	<!-- Custom Theme JavaScript -->
	<script src="<%=basePath%>js/sb-admin-2.js"></script>
	
	<!-- 操作xlsx的js -->
	<script src="<%=basePath%>js/xlsx.full.min.js"></script>
	
	<script type="text/javascript">
		function editCustomer(id) {
			alert("编辑用户信息")
		}
		function updateCustomer() {
		}
		
		function deleteQuestion(id) {
			if(confirm('确实要删除该题目吗?')) {
				$.post("<%=basePath%>question/delete.action",{"id":id},function(data){
					alert("客户删除更新成功！");
					window.location.reload();
				});
			}
		}
	</script>

	

	
	
	<!--根据题型显示不同的录入界面-->
	<script type="text/javascript">
		var typeArray = new Array("radioOfQuestion", "fillOfQuestion", "judgeOfQuestion", "clozeOfQuestion");
		var typeDict = {"--请选择--":0, "单选题":1, "多选题":2, "判断题":3, "填空题":4, "简答题":5, "应用题":6, "设计题":7};
		var type = document.getElementById("questionType");
		type.onchange = function(){
			var val = typeDict[type.value];
			var index;
			for(index in typeArray){
				document.getElementById(typeArray[index]).style.display = "none";
			}
			switch(val){
				case 1:$("#" + typeArray[0]).show();
				var radioOrChecks = document.getElementsByClassName("radioOrCheck");
				var i;
				for(i in radioOrChecks)
					radioOrChecks[i].type = "radio";
				break;
				case 2:$("#" + typeArray[0]).show();
				var radioOrChecks = document.getElementsByClassName("radioOrCheck");
				var i;
				for(i in radioOrChecks)
					radioOrChecks[i].type = "checkbox";
				break;
				case 3:$("#" + typeArray[2]).show();
				break;
				case 4:$("#" + typeArray[1]).show();
				break;
				case 5:$("#" + typeArray[3]).show();
				break;
				case 6:$("#" + typeArray[3]).show();
				break;
				case 7:$("#" + typeArray[3]).show();
				break;
				default:
// 				alert("其它");
				break;
			}
		}
	</script>
	
	
	<!--添加与删除选项-->
	<script type="text/javascript">
		$(".addKeyBtn").click(function(e){
			var optionArray = new Array("A", "B", "C", "D", "E", "F", "G")
		    var input_type = $("#questionType").val()=="单选题" ? "radio" : "checkbox";
		    var html =  '   <div class="keyLeft">'+
		                '        <input type="' + input_type + '" class="radioOrCheck" name="answerOption" value = "" onclick = "getValue()"/>'+
		                '	 	<textarea rows="2" cols="80" class = "radioEdit" id = "edit_option" name = "option"></textarea>'+
                        '		<span class = "removeKey" value = "haha" onclick="removeKeys(this)">'+
                        '            <i class="fa fa-trash" aria-hidden="true"></i>'+
                        '		</span>'+
                        '	</div>';
		    $(".addKeyBtn").before(html);
		    var keyLefts = $(".keyLeft");
		    for(var i = 0; i < keyLefts.length; i++){
		    		$(keyLefts[i]).find("input").attr("value", optionArray[i]);
					$(keyLefts[i]).find("textarea").attr("name", "option" + optionArray[i]);
					$(keyLefts[i]).find("textarea").attr("id", "edit_option" + optionArray[i]);
			}
		    if (keyLefts.length==7) {
		        $(".addKeyBtn").css("display", "none");
		        return false;
		    }
		});

		function removeKeys(obj){
			var optionArray = new Array("A", "B", "C", "D", "E", "F", "G");
		    $(".addKeyBtn").css("display", "block");
		    $(obj).parents(".keyLeft").remove();
		    var keyLefts = $(".keyLeft");
		    for(var i = 0; i < keyLefts.length; i++){
		    		$(keyLefts[i]).find("input").attr("value", optionArray[i]);
					$(keyLefts[i]).find("textarea").attr("name", "option" + optionArray[i]);
					$(keyLefts[i]).find("textarea").attr("id", "edit_option" + optionArray[i]);
			}
		}
	</script>
	
	<!--添加与删除填空-->
	<script type = "text/javascript">
		$(".addKeyFillBtn").click(function(e){
		    var html =  '<div class="keyFillContent" style="display: block;">'+
                        '        <div class="input-group">'+
                        '            <span class="keyFillNum input-group-addon">1</span>'+
                        '            <input type="text" name="answerFill[]"                        class="bootstrap-tagsinput" id="answerFill[]" data-role="tagsinput" placeholder="请输入答案，按下回车添加同义词。">'+
                        '		<span class = "removeKey" onclick="removeFill(this)">'+
                        '            <i class="fa fa-trash" aria-hidden="true"></i>'+
                        '		</span>'+
                        '        </div>'+
                        ' </div>';
		    $(".addKeyFillBtn").before(html);
		    var keyFills = $(".keyFill").find(".keyFillNum");
			for(var i = 0; i < keyFills.length; i++){
					$(keyFills[i]).text(i + 1);//DOM对象不能使用text方法
			}
			// if(keyFills.length >= 8){
			// 	$(".addKeyFillBtn").css("display", "none");
			// }
		});
		function removeFill(obj){
			$(obj).parents(".keyFillContent").remove();
			$(".addKeyFillBtn").css("display", "block");
			var keyFills = $(".keyFill").find(".keyFillNum");
			for(var i = 0; i < keyFills.length; i++){
					$(keyFills[i]).text(i + 1);//DOM对象不能使用text方法
			}
		}
	</script>

<!-- 录入题目前进行表单验证 -->
	<script type="text/javascript">
		function checkAddQuestion(){
			var typeDict = {"0":0, "单选题":1, "多选题":2, "判断题":3, "填空题":4, "简答题":5, "应用题":6, "设计题":7};
			var type = $("#questionType");
			var typeNum =typeDict[type.val()];
			var subject = $("#subject").val();
			var difficulty = $("select[name = 'difficulty']").val();
			if(typeNum == 0){
				alert("未设置题目类型");
				return false;
			}
			if(difficulty == "0"){
				alert("未设置题目难度");
				return false;
			} 
			if(subject == "" || subject == null){
				alert("题干不能空！");
				return false;
			}
			switch(typeNum){
				// 对于单选题进行验证
				case 1:
					var keyLefts = $(".keyLeft");
					var flag = false;
					for(var i = 0; i < keyLefts.length; ++i){
						var radioEdit = $(keyLefts[i]).find("textarea").val();
						if(radioEdit == "" || radioEdit == null){
							alert("选项内容不能为空");
							return false;
						}
						if($(keyLefts[i]).find("input").prop("checked") != false){
							flag = true;
						} 
					}
					 if(!flag){
						alert("未选中任何选项！");
						return false;
					} 
					break;
				case 2:
					
					var keyLefts = $(".keyLeft");
					var cnt = 0;
					for(var i = 0; i < keyLefts.length; ++i){
						var radioEdit = $(keyLefts[i]).find("textarea").val();
						if(radioEdit == "" || radioEdit == null){
							alert("选项内容不能为空");
							return false;
						}
						if($(keyLefts[i]).find("input").prop("checked") != false){
							++cnt;
						}
					}
					if(cnt < 2){
						alert("选中任何选项少于2个！");
						return false;
					}
					break; 
				case 3:

					break;
				case 4:
					var fills = $(".keyFillContent").find("input");
					for(var i = 0; i < fills.length; ++i){
						if($(fills[i]).val() == ""){
							alert("填空答案不能为空！");
							return false;
						}

					}
					break;
				case 5:
				case 6:
				case 7:
					var answer = $("#answerCloze").val();
					if(answer == null || answer == ""){
						alert("答案不能为空！");
						return false;
					}
					break;
			}
			alert("修改成功");
			return true;
		}
	</script>

	<script type = "text/javascript">
		function getOptionNum(){
			<c:forEach items="${page.rows}" var="row">
			var optionNum = 0;
			if('${row.optionA}' == ''){
     			optionNum = 0;
     		}
     		else if('${row.optionB}' == ''){
     			optionNum = 1;
     		}
     		else if('${row.optionC}' == ''){
     			optionNum = 2;
     		}
     		else if('${row.optionD}' == ''){
     			optionNum = 3;
     		}
     		else if('${row.optionE}' == ''){
     			optionNum = 4;
     		}
     		else if('${row.optionF}' == ''){
     			optionNum = 5;
     		}
     		else if('${row.optionG}' == ''){
     			optionNum = 6;
     		}
     		else{
     			optionNum = 7;
     		}
     		</c:forEach>
     		return optionNum;

		}
	</script>

<!-- 	根据后台的传值选择需要编辑题目的题型与难度 -->
<!--    选择科目 章节 知识点 -->
	<script type="text/javascript">
		var courseList = eval('${course}');
	    var chapterList = eval('${chapter}');
	    var knowpointList = eval('${knowpoint}');
	    //根据值让option选中 
	    courseSelNode = document.getElementById("questionCourse");
	    chapterSelNode = document.getElementById("questionChapter");
    	knowpointSelNode = document.getElementById("questionKnowpoint");
    	
		$(document).ready(function(){ 
		var flagCourse = $("#editQuestionCourse").val();
		var flagChapter = $("#editQuestionChapter").val();
		var flagKnowpoint = $("#editQuestionKnowpoint").val();
	    var flagType=$("#editQuestionType").val();
	    var flagDifficulty=$("#editQuestionDifficulty").val();
	    
	    
        //1.初始化科目下拉菜单
        for(var i=0;i<courseList.length;i++){

            //更简洁的操作
            var optNode = new Option(courseList[i],courseList[i]);
            courseSelNode.appendChild(optNode);
        }
       
       console.log("course: " + flagCourse);
       $("#questionCourse option[value='"+flagCourse+"']").attr("selected","selected");
       var index1 = courseSelNode.selectedIndex - 1;
       
     	//清空章节下拉菜单
       chapterSelNode.options.length = 0;
       for(var i=0;i<chapterList[index1].length;i++){
           var optNode = new Option(chapterList[index1][i],chapterList[index1][i]);
           chapterSelNode.appendChild(optNode);
       } 
       console.log("course: " + flagChapter);
       $("#questionChapter option[value='"+flagChapter+"']").attr("selected","selected");
       var index2 = chapterSelNode.selectedIndex;
     	//清空知识点下拉菜单
		knowpointSelNode.options.length = 0;
       for(var i=0;i<knowpointList[index1][index2].length;i++){
           var optNode = new Option(knowpointList[index1][index2][i],knowpointList[index1][index2][i]);
           knowpointSelNode.appendChild(optNode);
       } 
       $("#questionKnowpoint option[value='"+flagKnowpoint+"']").attr("selected","selected");
       $("#questionType option[value='"+flagType+"']").attr("selected","selected");
       $("#questionDifficulty option[value='"+flagDifficulty+"']").attr("selected","selected");
	   
       
	   	
	   /*  根据type显示不同的界面 */
	   	var typeArray = new Array("radioOfQuestion", "fillOfQuestion", "judgeOfQuestion", "clozeOfQuestion");
	    var typeDict = {"--请选择--":0, "单选题":1, "多选题":2, "判断题":3, "填空题":4, "简答题":5, "应用题":6, "设计题":7};
	    var alphaDict = {"A":0, "B":1, "C":2, "D":3, "E":4, "F":5, "G":6};
	    var optionArray = new Array("A", "B", "C", "D", "E", "F", "G");
	    var val = typeDict[flagType];
	     
		<c:forEach items="${page.rows}" var="row">

			switch(val){
	     	case 1:$("#" + typeArray[0]).show();
	     		var optionAnswerIndex = alphaDict['${row.answer}'];
	     		var optionNum = getOptionNum();

	     		for(var i = 4; i < optionNum; ++i){
	     			var html =  '   <div class="keyLeft">'+
		                '        <input type="' + 'radio' + '" class="radioOrCheck" name="answerOption" value = "" onclick = "getValue()"/>'+
		                '	 	<textarea rows="2" cols="80" class = "radioEdit" id = "edit_option" name = "option"></textarea>'+
                        '		<span class = "removeKey" value = "haha" onclick="removeKeys(this)">'+
                        '            <i class="fa fa-trash" aria-hidden="true"></i>'+
                        '		</span>'+
                        '	</div>';
				    $(".addKeyBtn").before(html);
				    if(i == 4){
				    	var keyLefts = $(".keyLeft");
				    	$(keyLefts[4]).find("textarea").val('${row.optionE}');
				    }
				    else if(i == 5){
				    	var keyLefts = $(".keyLeft");
				    	$(keyLefts[5]).find("textarea").val('${row.optionF}');
				    }
				    else if(i == 6){
				    	var keyLefts = $(".keyLeft");
				    	$(keyLefts[6]).find("textarea").val('${row.optionG}');
				    }
		    	}

		    	var keyLefts = $(".keyLeft");
			    for(var i = 0; i < keyLefts.length; i++){
			    		$(keyLefts[i]).find("input").attr("value", optionArray[i]);
						$(keyLefts[i]).find("textarea").attr("name", "option" + optionArray[i]);
						$(keyLefts[i]).find("textarea").attr("id", "edit_option" + optionArray[i]);
				}
			    if (keyLefts.length==7) {
			        $(".addKeyBtn").css("display", "none");
			    }

				var radioOrChecks = document.getElementsByClassName("radioOrCheck");
				var radios = $(".radioOrCheck");
	     		
				for(var i = 0; i < radioOrChecks.length; ++i){
					radioOrChecks[i].type = "radio";
				}

				$(radios[optionAnswerIndex]).prop("checked", true);
				break;
			case 2:$("#" + typeArray[0]).show();
				var answer = '${row.answer}'.split(",");

				var optionNum = getOptionNum();

	     		for(var i = 4; i < optionNum; ++i){
	     			var html =  '   <div class="keyLeft">'+
		                '        <input type="' + 'radio' + '" class="radioOrCheck" name="answerOption" value = "" onclick = "getValue()"/>'+
		                '	 	<textarea rows="2" cols="80" class = "radioEdit" id = "edit_option" name = "option"></textarea>'+
                        '		<span class = "removeKey" value = "haha" onclick="removeKeys(this)">'+
                        '            <i class="fa fa-trash" aria-hidden="true"></i>'+
                        '		</span>'+
                        '	</div>';
				    $(".addKeyBtn").before(html);
				    if(i == 4){
				    	var keyLefts = $(".keyLeft");
				    	$(keyLefts[4]).find("textarea").val('${row.optionE}');
				    }
				    else if(i == 5){
				    	var keyLefts = $(".keyLeft");
				    	$(keyLefts[5]).find("textarea").val('${row.optionF}');
				    }
				    else if(i == 6){
				    	var keyLefts = $(".keyLeft");
				    	$(keyLefts[6]).find("textarea").val('${row.optionG}');
				    }
				}
				var keyLefts = $(".keyLeft");
				for(var i = 0; i < keyLefts.length; i++){
				    		$(keyLefts[i]).find("input").attr("value", optionArray[i]);
							$(keyLefts[i]).find("textarea").attr("name", "option" + optionArray[i]);
							$(keyLefts[i]).find("textarea").attr("id", "edit_option" + optionArray[i]);
				}
			    if (keyLefts.length==7) {
			        $(".addKeyBtn").css("display", "none");
			    }

				var radioOrChecks = document.getElementsByClassName("radioOrCheck");
				var checks = $(".radioOrCheck");

				var i;
				for(i in radioOrChecks){
					radioOrChecks[i].type = "checkbox";
				}
				for(var i = 0; i < answer.length; ++i){
					$(checks[alphaDict[answer[i]]]).prop("checked", true);
				}
				break;
			case 3:
				var answer = '${row.answer}';//为answer赋初值
				var judge = $(".keyJudge").find("input");
				if(answer == "正确"){
					$(judge[0]).prop("checked", true);
				}
				else if(answer == "错误"){
					$(judge[1]).prop("checked", true);
				}
				$("#" + typeArray[0]).hide();
				$("#" + typeArray[2]).show();
				break;
			case 4:
				var answer = '${row.answer}'.split("#");
// 				alert(answer);
				var fill = $(".keyFillContent");
				$(fill).find("input").val(answer[0]);
				for(var i = 1; i < answer.length; ++i){
					var html =  '<div class="keyFillContent" style="display: block;">'+
                        '        <div class="input-group">'+
                        '            <span class="keyFillNum input-group-addon">1</span>'+
                        '            <input type="text" name="answerFill[]"                        class="bootstrap-tagsinput" id="answerFill[]" data-role="tagsinput" placeholder="请输入答案，按下回车添加同义词。">'+
                        '		<span class = "removeKey" onclick="removeFill(this)">'+
                        '            <i class="fa fa-trash" aria-hidden="true"></i>'+
                        '		</span>'+
                        '        </div>'+
                        ' </div>';
		    		$(".addKeyFillBtn").before(html);
		    		judges = $(".keyFillContent").find("input");
		    		$(judges[i]).val(answer[i]);
				    var keyFills = $(".keyFill").find(".keyFillNum");
					for(var j = 0; j < keyFills.length; j++){
						$(keyFills[j]).text(j + 1);//DOM对象不能使用text方法
					}
				}
				$("#" + typeArray[0]).hide();
				$("#" + typeArray[1]).show();
				break;
			case 5:
				$("#" + typeArray[0]).hide();
				$("#" + typeArray[3]).show();
				break;
			case 6:
				$("#" + typeArray[0]).hide();
				$("#" + typeArray[3]).show();
				break;
			case 7:
				$("#" + typeArray[0]).hide();
				$("#" + typeArray[3]).show();
				break;
			default:
// 			alert("其它");
		};

		</c:forEach>

		}); 
		
		//更新章节下拉列表
		function updateChapterSel(){
	        //清空章节下拉菜单
	       chapterSelNode.options.length = 0;
			//清空知识点下拉菜单
			knowpointSelNode.options.length = 0;
	        //更新章节下拉菜单
	        var index = courseSelNode.selectedIndex - 1;
	        if(index < 0 || (chapterList[index].length == 0 || chapterList[index] == [] || typeof chapterList[index] == "undefined")){
	        	chapterSelNode.options.length = 0;
	        	knowpointSelNode.options.length = 0;
	        }
	        else{
	        	for(var i=0;i<chapterList[index].length;i++){
		            var optNode = new Option(chapterList[index][i],chapterList[index][i]);
		            chapterSelNode.appendChild(optNode);
		            if(i == 0){
		            	for(var j=0;j<knowpointList[index][0].length; j++){
		            		var optNode = new Option(knowpointList[index][0][j],knowpointList[index][0][j]);
		     	            knowpointSelNode.appendChild(optNode);
		            	}
		            }
		        }
	        }
	         
	    }
		//更新知识点下拉列表
	    function updateKnowpointSel(){
	    	//清空知识点下拉菜单
			knowpointSelNode.options.length = 0;
			var index1 = courseSelNode.selectedIndex - 1;
			var index2 = chapterSelNode.selectedIndex;
			if(knowpointList[index1][index2].length == 0 || knowpointList[index1][index2] == [] || typeof knowpointList[index1][index2] == "undefined"){
				knowpointSelNode.options.length = 0;
			}
			else{
				for(var i=0;i<knowpointList[index1][index2].length;i++){
		            var optNode = new Option(knowpointList[index1][index2][i],knowpointList[index1][index2][i]);
		            knowpointSelNode.appendChild(optNode);
		        } 
			}
			
	    }
	</script>
	

	<!--         显示上传的图片 -->

         <script type="text/javascript">
			$(".lccid").on("change", "input[type=file]", function() {

				$(this).prev().css("opacity","1")

				var filePath = $(this).val();//读取图片路径
				var fr = new FileReader();//创建new FileReader()对象
				var imgObj = this.files[0];//获取图片
				fr.readAsDataURL(imgObj);//将图片读取为DataURL
				var obj = $(this).prev()[0];//
	

				if(filePath.indexOf("jpg") != -1 || filePath.indexOf("JPG") != -1 || filePath.indexOf("PNG") != -1 || filePath.indexOf("png") != -1) {
					var arr = filePath.split('\\');
					var fileName = arr[arr.length - 1];
// 					alert(fileName)
				

					$(this).parent().next().show();
					fr.onload = function() {
						obj.src = this.result;
					};
				} else {
					$(this).parent().next().show();
					$(this).parent().next().children("i").html("您未上传文件，或者您上传文件类型有误！").css("color", "red");
					//$(this).parent().next().html("您未上传文件，或者您上传文件类型有误！").css("color","red");
					return false
				}
			});
	</script>
	


</body>

</html>