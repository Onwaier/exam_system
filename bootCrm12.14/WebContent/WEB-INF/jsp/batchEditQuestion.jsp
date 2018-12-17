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

<title>添加试题</title>

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
							class="fa fa-edit fa-fw"></i> 题库管理</a></li>
					<li><a href="${pageContext.request.contextPath }/customer/list.action"><i
							class="fa fa-dashboard fa-fw"></i> 试卷管理</a></li>
				</ul>
			</div>
			<!-- /.sidebar-collapse -->
		</div>
		<!-- /.navbar-static-side --> </nav>

		<div id="page-wrapper">
			
			
			
			<div id="myTabContent" class="tab-content">
				
				<div class="tab-pane fade in active" id="manualInput">

					
					<!-- <form class="form-inline questionForm" action="${pageContext.request.contextPath }/question/update.action" method="post" onsubmit="return checkAddQuestion(this)" class = "questionForm">
						<div class = "quesIntro">
							<i class="fa fa-plus-square-o" aria-hidden="true" onclick = "openAndCloseQuestion(this)"></i>
							<span class = "intro quesIdDes">题目id</span>
							<span class = "intro quesId"></span>
						</div>
						
						<!-- 分割线 -->
						<!--
						<HR style="FILTER: alpha(opacity=100,finishopacity=0,style=3)" width="80%" color=#987cb9 SIZE=3>		
						<div class="batch-type" style="display: none">
							<span class="intro chapter">章节</span>
							<select	class="form-control" name = "chapter">
								<option value="">--请选择--</option>
							</select>
							<span class="intro knowpoint">知识点</span>
							<select	class="form-control" name = "knowPoint">
								<option value="">--请选择--</option>
							</select>
							<span class="intro type">试题类型</span>
							<select	class="form-control questionType">
								<option value="0">--请选择--</option>
								<option value="单选题">单选题</option>
								<option value="多选题">多选题</option>
								<option value="判断题">判断题</option>
								<option value="填空题">填空题</option>
								<option value="问答题">问答题</option>
								<option value="简述题">简述题</option>
								<option value="名词解释">名词解释</option>	
							</select> 

							<span class="intro difficulty">难度</span>
							<select	class="form-control questionDifficulty" name="difficulty">
								<option value="0">--请选择--</option>
								<option value="简单">简单</option>
								<option value="中等">中等</option>
								<option value="困难">困难</option>
							</select>    											
						</div>
						
						<div class="question-content" style = "display: none">
							<input id="questionId" type="hidden"  name = "qid" value="">
							<div class="descPanel descOfQuestion">
                                <div class="title">
                                    <span class="tip">题干</span>
                                    <span class="intro">这里填写题目描述</span>
                                </div>
                                <div class = "editor">
                                <textarea rows="2" cols="80" type="text"  class="subject" value="" name="subject"></textarea> 
                                
                                </div>       
	                        </div>
	
	                        <div class="keyRadio keyPanel radioOfQuestion" style="display: block;">
	                        	<div class="title">
                                    <span class="tip">选项</span>
                                    <span class="intro">单/多选题的选项范围从&nbsp;2&nbsp;到&nbsp;8&nbsp;</span>
	                            </div>
	                            <div>
		                            <div class="keyLeft">
                                        <input type="radio" class="radioOrCheck" name="answerOption" value="A"/>
                                        <textarea rows="2" cols="80" class = "radioEdit"  name="optionA"></textarea>
		                            </div>
	                                <div class="keyLeft">
                                    	<input type="radio" class="radioOrCheck" name="answerOption" value="B" />
                                        <textarea rows="2" cols="80" class = "radioEdit"  name="optionB"></textarea>
	                                </div>
                                    <div class="keyLeft">
                                    	<input type="radio" class="radioOrCheck" name="answerOption" value="C" />
                                    	<textarea rows="2" cols="80" class = "radioEdit"  name="optionC"></textarea>
                                    	<span class = "removeKey" onclick="removeKeys(this)"><i class="fa fa-trash" aria-hidden="true"></i></span>
                                    </div>
                                    <div class="keyLeft">
                                    	<input type="radio" class="radioOrCheck" name="answerOption" value="D" />
                                    	<textarea rows="2" cols="80" class = "radioEdit" name="optionD"></textarea>
                                    	<span class = "removeKey" onclick="removeKeys(this)"><i class="fa fa-trash" aria-hidden="true"></i></span>
                                    </div>
	                                <div class="addKeyBtn">
	                                    <button type="button" class="btn btn-l-gray addKey"><i class="plus-style icons8-plus"></i>添加一个选项</button>
	                                </div>
	                            </div>
							</div>
						
							<div class="keyFill keyPanel fillOfQuestion" style="display: none;">
								<div class="title">
	                                 <span class="tip">答案</span>
	                                 <span class="intro">
	                                 		请填写每个填空的答案
	                                 </span> 
	                            </div>
	                            <div class="keyFillContent" style="display: block;">
	                                <div class="input-group">
	                                    <span class="input-group-addon keyFillNum">1</span>
	                                    <input type="text" name="answerFill[]" class="bootstrap-tagsinput answerFill" data-role="tagsinput" placeholder="请输入答案，按下回车添加同义词。" style="display: block;">
	                                </div>
	                               
	                           	</div>
	                            <div class="addKeyFillBtn">
	                                    <button type="button" class="btn btn-l-gray addKeyFill"><i class="plus-style icons8-plus" style="top: 0"></i>增加一个填空</button>
	                            </div>
	                        </div>
	                          
	                        <div class="keyJudge keyPanel judgeOfQuestion" style="display: none;">
	                                <div class="title">
	                                    <span class="tip">选项</span>
	                                    <span class="intro">选择正确或者错误（默认正确）</span>
	                                </div>
	                                
	                                <input type="radio" class="hidden judgeYes"  name="answerJudge" value="正确" checked>
	                                <label for="judgeYes" class="btn btn-border-gray">正确</label>
	                                <input type="radio" class="hidden judgeNo"  name="answerJudge" value="错误">
	                                <label for="judgeNo" class="btn btn-border-gray">错误</label> 
	                        </div>
	                            
	                        <div class="keyCloze keyPanel clozeOfQuestion" style="display: none;">
                          		<div class="title">
                                    <span class="tip">答案</span>
                                    <span class="intro">这里填写答案</span>
                                </div>
                                <div class = "editor">
	                                <textarea rows="2" cols="80" class="answerCloze"  name="answerCloze"></textarea>
                                </div>
	                        </div>
	                          
	                        <div class="analysisPanel analysisOfQuestion" style="display: block;">
	                          		<div class="title">
	                                    <span class="tip">解析</span>
	                                    <span class="intro">这里填写该问题对应的答案解释</span>
	                                </div>
	                                <div>
	                                <textarea rows="2" cols="80"   class="analysis" value="" name="analysis"></textarea>
	                                </div>
	                        </div>                
						</div>
					
						<button class="btn btn-primary navbar-input-button" onclick="window.open('${pageContext.request.contextPath }/question/fileUpload.action', 'loadPicture')" type="button" style="display: none">添加图片</button>				
						<button type="submit" class="btn btn-primary" style="display: none">录入题目</button>
					</form> -->
					<button id = "addQuestionItem" onclick="add()" style = "display:none">添加</button>
					<button id = "updtrQuestions" onclick = "updateQuestions()">提交</button>
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
		function typeChange(obj){
			var questionForm = $(obj).parent().parent();
			var typeArray = new Array("radioOfQuestion", "fillOfQuestion", "judgeOfQuestion", "clozeOfQuestion");
			var typeDict = {"0":0, "单选题":1, "多选题":2, "判断题":3, "填空题":4, "问答题":5, "简述题":6, "名词解释":7};
			var type = $(questionForm).find(".questionType");
			var val = typeDict[type.val()];
			var index;
			for(index in typeArray){
				$(questionForm).find("." + typeArray[index]).hide();
			}
			switch(val){
				case 1:$(questionForm).find("." + typeArray[0]).show();
				var radioOrChecks = document.getElementsByClassName("radioOrCheck");
				var i;
				for(i in radioOrChecks)
					radioOrChecks[i].type = "radio";
				break;
				case 2:$(questionForm).find("." + typeArray[0]).show();
				var radioOrChecks = document.getElementsByClassName("radioOrCheck");
				var i;
				for(i in radioOrChecks)
					radioOrChecks[i].type = "checkbox";
				break;
				case 3:$(questionForm).find("." + typeArray[2]).show();
				break;
				case 4:$(questionForm).find("." + typeArray[1]).show();
				break;
				case 5:$(questionForm).find("." + typeArray[3]).show();
				break;
				case 6:$(questionForm).find("." + typeArray[3]).show();
				break;
				case 7:$(questionForm).find("." + typeArray[3]).show();
				break;
				default:
				alert("其它");
				break;
			}
		}
		var typeArray = new Array("radioOfQuestion", "fillOfQuestion", "judgeOfQuestion", "clozeOfQuestion");
		var typeDict = {"0":0, "单选题":1, "多选题":2, "判断题":3, "填空题":4, "问答题":5, "简述题":6, "名词解释":7};
		for(var i = 0; i < $(".questionForm").length; ++i){
			$(".questionForm:eq(" + i + ") questionType").change(function(){
				alert(i);
				var val = typeDict[type.val()];
				var index;
				for(index in typeArray){
					$(".questionForm:eq(" + i + ") ." + typeArray[index]).hide();
				}
				switch(val){
					case 1:$(".questionForm:eq(" + i + ") ." + typeArray[0]).show();
					var radioOrChecks = document.getElementsByClassName("radioOrCheck");
					var i;
					for(i in radioOrChecks)
						radioOrChecks[i].type = "radio";
					break;
					case 2:$(".questionForm:eq(" + i + ") ." + typeArray[0]).show();
					var radioOrChecks = document.getElementsByClassName("radioOrCheck");
					var i;
					for(i in radioOrChecks)
						radioOrChecks[i].type = "checkbox";
					break;
					case 3:$(".questionForm:eq(" + i + ") ." + typeArray[2]).show();
					break;
					case 4:$(".questionForm:eq(" + i + ") ." + typeArray[1]).show();
					break;
					case 5:$(".questionForm:eq(" + i + ") ." + typeArray[3]).show();
					break;
					case 6:$(".questionForm:eq(" + i + ") ." + typeArray[3]).show();
					break;
					case 7:$(".questionForm:eq(" + i + ") ." + typeArray[3]).show();
					break;
					default:
					alert("其它");
					break;
				}
			});
		}
		
	</script>
	
	
	<!--添加与删除选项-->
	<script type="text/javascript">
		function addOption(obj){
			var questionForm = $(obj).parent().parent();
			var optionArray = new Array("A", "B", "C", "D", "E", "F", "G")
		    var input_type = $(questionForm).find(".questionType").val()=="单选题" ? "radio" : "checkbox";
		    var html =  '<div class="keyLeft">'+
							'<input type=' + input_type +
							' class="radioOrCheck" name="answerOption" value="C" />'+
							'<textarea rows="2" cols="80" class = "radioEdit"  name="optionC"></textarea>'+
							'<span class = "removeKey" onclick="removeKeys(this)"><i class="fa fa-trash" aria-hidden="true"></i></span>'+
						'</div>';
		    $(obj).before(html);
		    var keyLefts = $(obj).parents(".keyRadio").find(".keyLeft");
		    for(var i = 0; i < keyLefts.length; i++){
		    		$(keyLefts[i]).find("input").attr("value", optionArray[i]);
					$(keyLefts[i]).find("textarea").attr("name", "option" + optionArray[i]);
			}
		    if (keyLefts.length==7) {
		        $(obj).css("display", "none");
		        return false;
		    }
		}
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
		    $(obj).parents(".keyRadio").find(".addKeyBtn").css("display", "block");
		    $(obj).parents(".keyLeft").remove();
		    var keyLefts = $(obj).parents(".keyLeft");
		    for(var i = 0; i < keyLefts.length; i++){
		    		$(keyLefts[i]).find("input").attr("value", optionArray[i]);
					$(keyLefts[i]).find("textarea").attr("name", "option" + optionArray[i]);
			}
		}
	</script>
	
	<!--添加与删除填空-->
	<script type = "text/javascript">
		function addFill(obj){
			var html =  '<div class="keyFillContent" style="display: block;">'+
	                        '        <div class="input-group">'+
	                        '            <span class="keyFillNum input-group-addon">1</span>'+
	                        '            <input type="text" name="answerFill[]"                        class="bootstrap-tagsinput answerFill" data-role="tagsinput" placeholder="请输入答案，按下回车添加同义词。">'+
	                        '		<span class = "removeKey" onclick="removeFill(this)">'+
	                        '            <i class="fa fa-trash" aria-hidden="true"></i>'+
	                        '		</span>'+
	                        '        </div>'+
	                    ' </div>';
			$(obj).before(html);
			var keyFills = $(obj).parents(".keyFill").find(".keyFillNum");
			for(var i = 0; i < keyFills.length; i++){
					$(keyFills[i]).text(i + 1);//DOM对象不能使用text方法
			}
		}
		
		function removeFill(obj){
			$(obj).parents(".keyFillContent").remove();
			$(".addKeyFillBtn").css("display", "block");
			var keyFills = $(obj).parents(".keyFill").find(".keyFillNum");
			for(var i = 0; i < keyFills.length; i++){
					$(keyFills[i]).text(i + 1);//DOM对象不能使用text方法
			}
		}
	</script>

<!-- 录入题目前进行表单验证 -->
	<script type="text/javascript">
		function checkAddQuestion(obj){
			var typeDict = {"0":0, "单选题":1, "多选题":2, "判断题":3, "填空题":4, "问答题":5, "简述题":6, "名词解释":7};
			var type = $(obj).find(".questionType");
			var typeNum =typeDict[type.val()];
			var subject = $(obj).find(".subject").val();
			var difficulty = $(obj).find("select[name = 'difficulty']").val();
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
					var keyLefts = $(obj).find(".keyLeft");
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
					
					var keyLefts = $(obj).find(".keyLeft");
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
					var fills = $(obj).find(".keyFillContent").find("input");
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
					var answer = $(obj).find(".answerCloze").val();
					if(answer == null || answer == ""){
						alert("答案不能为空！");
						return false;
					}
					break;
			}
			return true;
		}
	</script>
<!-- 获取多选与单选选项个数 -->
<script type = "text/javascript">
		function getOptionNum(obj){
			var optionNum = 0;
			if(obj.optionA == ''){
     			optionNum = 0;
     		}
     		else if(obj.optionB == ''){
     			optionNum = 1;
     		}
     		else if(obj.optionC == ''){
     			optionNum = 2;
     		}
     		else if(obj.optionD == ''){
     			optionNum = 3;
     		}
     		else if(obj.optionE == ''){
     			optionNum = 4;
     		}
     		else if(obj.optionF == ''){
     			optionNum = 5;
     		}
     		else if(obj.optionG == ''){
     			optionNum = 6;
     		}
     		else{
     			optionNum = 7;
     		}
     		return optionNum;

		}
</script>

<!-- 	根据后台的传值选择需要编辑题目的题型与难度 -->
	<script type="text/javascript">
		$(document).ready(function(){ 
			var cnt = 0, judgeNum = 0;
			<c:forEach items="${page.rows}" var="row">
				//添加题目
				add();
			    //根据值让option选中 
			    $(".questionForm:eq(" + cnt + ") .questionId").val('${row.qid}');
			    // 题型
		        $(".questionForm:eq(" + cnt + ") .questionType option[value='"+'${row.type}'+"']").attr("selected","selected");
		        // 难度
		        $(".questionForm:eq(" + cnt + ") .questionDifficulty option[value='"+'${row.difficulty}'+"']").attr("selected","selected");
			   
			   	
			   /*  根据type显示不同的界面 */
			   	var typeArray = new Array("radioOfQuestion", "fillOfQuestion", "judgeOfQuestion", "clozeOfQuestion");
			    var typeDict = {"--请选择--":0, "单选题":1, "多选题":2, "判断题":3, "填空题":4, "问答题":5, "简述题":6, "名词解释":7};
			    var alphaDict = {"A":0, "B":1, "C":2, "D":3, "E":4, "F":5, "G":6};
			    var optionArray = new Array("A", "B", "C", "D", "E", "F", "G");
			    //题干内容缩略
			    $(".questionForm:eq(" + cnt + ") .quesBrief").html('${row.subject}');
			    // 题干
			    $(".questionForm:eq(" + cnt + ") .subject").val('${row.subject}');
			    $(".questionForm:eq(" + cnt + ") .analysis").val('${row.analysis}');
			    var val = typeDict['${row.type}'];
				switch(val){
		     	case 1:$(".questionForm:eq(" + cnt + ") ." + typeArray[0]).show();
		     		var optionAnswerIndex = alphaDict['${row.answer}'];
		     		var str = '${row}';		     		
		     		var objArr = eval("(" + str + ")");
					var optionNum = getOptionNum(objArr);
		     		var keyLefts = $(".questionForm:eq(" + cnt + ") .keyLeft");
		     		$(keyLefts[0]).find("textarea").val('${row.optionA}');
		     		$(keyLefts[1]).find("textarea").val('${row.optionB}');
		     		$(keyLefts[2]).find("textarea").val('${row.optionC}');
		     		$(keyLefts[3]).find("textarea").val('${row.optionD}');
		     		for(var i = 4; i < optionNum; ++i){
		     			var html =  
		     			'<div class="keyLeft">'+
							'<input type="radio" class="radioOrCheck" name="answerOption" value="C" />'+
							'<textarea rows="2" cols="80" class = "radioEdit"  name="optionC"></textarea>'+
							'<span class = "removeKey" onclick="removeKeys(this)"><i class="fa fa-trash" aria-hidden="true"></i></span>'+
						'</div>';
					    $(".questionForm:eq(" + cnt + ") .addKeyBtn").before(html);
					    if(i == 4){
					    	var keyLefts = $(".questionForm:eq(" + cnt + ") .keyLeft");
					    	$(keyLefts[4]).find("textarea").val('${row.optionE}');
					    }
					    else if(i == 5){
					    	var keyLefts = $(".questionForm:eq(" + cnt + ") .keyLeft");
					    	$(keyLefts[5]).find("textarea").val('${row.optionF}');
					    }
					    else if(i == 6){
					    	var keyLefts = $(".questionForm:eq(" + cnt + ") .keyLeft");
					    	$(keyLefts[6]).find("textarea").val('${row.optionG}');
					    }
			    	}

			    	var keyLefts = $(".questionForm:eq(" + cnt + ") .keyLeft");
				    for(var i = 0; i < keyLefts.length; i++){
				    		$(keyLefts[i]).find("input").attr("value", optionArray[i]);
							$(keyLefts[i]).find("textarea").attr("name", "option" + optionArray[i]);
					}
				    if (keyLefts.length==7) {
				        $(".addKeyBtn").css("display", "none");
				        return false;
				    }

					var radioOrChecks = document.getElementsByClassName("radioOrCheck");
					var radios = $(".questionForm:eq(" + cnt + ") .radioOrCheck");
		     		
					for(var i = 0; i < radios.length; ++i){
						$(radios[i]).attr("type", "radio");
					}

					$(radios[optionAnswerIndex]).prop("checked", true);
					break;
				case 2:$(".questionForm:eq(" + cnt + ") ." + typeArray[0]).show();
					var answer = '${row.answer}'.split(",");
					var keyLefts = $(".questionForm:eq(" + cnt + ") .keyLeft");
		     		$(keyLefts[0]).find("textarea").val('${row.optionA}');
		     		$(keyLefts[1]).find("textarea").val('${row.optionB}');
		     		$(keyLefts[2]).find("textarea").val('${row.optionC}');
		     		$(keyLefts[3]).find("textarea").val('${row.optionD}');
		     		var str = '${row}';		     		
		     		var objArr = eval("(" + str + ")");
					var optionNum = getOptionNum(objArr);

		     		for(var i = 4; i < optionNum; ++i){
		     			var html =  
		     			'<div class="keyLeft">'+
							'<input type="radio" class="radioOrCheck" name="answerOption" value="C" />'+
							'<textarea rows="2" cols="80" class = "radioEdit"  name="optionC"></textarea>'+
							'<span class = "removeKey" onclick="removeKeys(this)"><i class="fa fa-trash" aria-hidden="true"></i></span>'+
						'</div>';
					    $(".questionForm:eq(" + cnt + ") .addKeyBtn").before(html);
					    if(i == 4){
					    	var keyLefts = $(".questionForm:eq(" + cnt + ") .keyLeft");
					    	$(keyLefts[4]).find("textarea").val('${row.optionE}');
					    }
					    else if(i == 5){
					    	var keyLefts = $(".questionForm:eq(" + cnt + ") .keyLeft");
					    	$(keyLefts[5]).find("textarea").val('${row.optionF}');
					    }
					    else if(i == 6){
					    	var keyLefts = $(".questionForm:eq(" + cnt + ") .keyLeft");
					    	$(keyLefts[6]).find("textarea").val('${row.optionG}');
					    }
					}
					var keyLefts = $(".questionForm:eq(" + cnt + ") .keyLeft");
					for(var i = 0; i < keyLefts.length; i++){
					    		$(keyLefts[i]).find("input").attr("value", optionArray[i]);
								$(keyLefts[i]).find("textarea").attr("name", "option" + optionArray[i]);
					}
				    if (keyLefts.length==7) {
				        $(".questionForm:eq(" + cnt + ") .addKeyBtn").css("display", "none");
				        return false;
				    }

					var radioOrChecks = document.getElementsByClassName("radioOrCheck");
					var checks = $(".questionForm:eq(" + cnt + ") .radioOrCheck");

					var i;
					for(i in checks){
						$(checks[i]).attr("type", "checkbox");
					}
					for(var i = 0; i < answer.length; ++i){
						$(checks[alphaDict[answer[i]]]).prop("checked", true);
					}
					break;
				case 3:
					var answer = '${row.answer}';
					var judge = $(".questionForm:eq(" + cnt + ") .keyJudge").find("input");
					var labels = $(".questionForm:eq(" + cnt + ") .keyJudge").find("label");
					$(judge[0]).attr("id", "judgeYes" + judgeNum);
					$(labels[0]).attr("for", "judgeYes" + judgeNum);
					$(judge[1]).attr("id", "judgeNo" + judgeNum);
					$(labels[1]).attr("for", "judgeNo" + judgeNum);
					++judgeNum;
					if(answer == "正确"){
						$(judge[0]).prop("checked", true);
					}
					else if(answer == "错误"){
						$(judge[1]).prop("checked", true);
					}
					$("." + typeArray[0]).hide();
					$("." + typeArray[2]).show();
					break;
				case 4:
					var answer = '${row.answer}'.split("#");
					alert(answer);
					var fill = $(".questionForm:eq(" + cnt + ") .keyFillContent");
					$(fill).find("input").val(answer[0]);
					for(var i = 1; i < answer.length; ++i){
						var html =  
						'<div class="keyFillContent" style="display: block;">'+
	                        '        <div class="input-group">'+
	                        '            <span class="keyFillNum input-group-addon">1</span>'+
	                        '            <input type="text" name="answerFill[]"                        class="bootstrap-tagsinput answerFill" data-role="tagsinput" placeholder="请输入答案，按下回车添加同义词。">'+
	                        '		<span class = "removeKey" onclick="removeFill(this)">'+
	                        '            <i class="fa fa-trash" aria-hidden="true"></i>'+
	                        '		</span>'+
	                        '        </div>'+
	                    ' </div>';
			    		$(".questionForm:eq(" + cnt + ") .addKeyFillBtn").before(html);
			    		judges = $(".questionForm:eq(" + cnt + ") .keyFillContent").find("input");
			    		$(judges[i]).val(answer[i]);
					    var keyFills = $(".questionForm:eq(" + cnt + ") .keyFill").find(".keyFillNum");
						for(var j = 0; j < keyFills.length; j++){
							$(keyFills[j]).text(j + 1);//DOM对象不能使用text方法
						}
					}
					$(".questionForm:eq(" + cnt + ") ." + typeArray[0]).hide();
					$(".questionForm:eq(" + cnt + ") ." + typeArray[1]).show();
					break;
				case 5:
					$(".questionForm:eq(" + cnt + ") ." + typeArray[0]).hide();
					$(".questionForm:eq(" + cnt + ") ." + typeArray[3]).show();
					$(".questionForm:eq(" + cnt + ") .clozeOfQuestion").find("textarea").val('${row.answer}');
					break;
				case 6:
					$(".questionForm:eq(" + cnt + ") ." + typeArray[0]).hide();
					$(".questionForm:eq(" + cnt + ") ." + typeArray[3]).show();
					$(".questionForm:eq(" + cnt + ") .clozeOfQuestion").find("textarea").val('${row.answer}');
					break;
				case 7:
					$(".questionForm:eq(" + cnt + ") ." + typeArray[0]).hide();
					$(".questionForm:eq(" + cnt + ") ." + typeArray[3]).show();
					$(".questionForm:eq(" + cnt + ") .clozeOfQuestion").find("textarea").val('${row.answer}');
					break;
				default:
					alert("其它");
			};
			++cnt;
			</c:forEach>

		}); 
	</script>
	
	
<!--  在页面中添加一道题-->
	<script type = "text/javascript">
		function add(){
			var html = 
			'<form class="form-inline questionForm" action="${pageContext.request.contextPath }/question/update.action" method="post" onsubmit="return checkAddQuestion(this)" class = "questionForm">'+
'						<div class = "quesIntro">'+
'							<i class="fa fa-plus-square-o" aria-hidden="true" onclick = "openAndCloseQuestion(this)"></i>'+
'							<span class = "intro quesDesBrief">题干缩略&nbsp&nbsp</span>'+
'							<p class = "intro quesBrief"></p>'+
'						</div>'+
'						'+
'						<!-- 分割线 -->'+
'						<HR style="FILTER: alpha(opacity=100,finishopacity=0,style=3)" width="80%" color=#987cb9 SIZE=3>		'+
'						<div class="batch-type" style="display: none">'+
'							<span class="intro chapter">章节</span>'+
'							<select	class="form-control" name = "chapter">'+
'								<option value="">--请选择--</option>'+
'							</select>'+
'							<span class="intro knowpoint">知识点</span>'+
'							<select	class="form-control" name = "knowPoint">'+
'								<option value="">--请选择--</option>'+
'							</select>'+
'							<span class="intro type">试题类型</span>'+
'							<select	class="form-control questionType" name = "type" onchange = "typeChange(this)">'+
'								<option value="0">--请选择--</option>'+
'								<option value="单选题">单选题</option>'+
'								<option value="多选题">多选题</option>'+
'								<option value="判断题">判断题</option>'+
'								<option value="填空题">填空题</option>'+
'								<option value="问答题">问答题</option>'+
'								<option value="简述题">简述题</option>'+
'								<option value="名词解释">名词解释</option>	'+
'							</select> '+
'							<span class="intro difficulty">难度</span>'+
'							<select	class="form-control questionDifficulty" name="difficulty">'+
'								<option value="0">--请选择--</option>'+
'								<option value="简单">简单</option>'+
'								<option value="中等">中等</option>'+
'								<option value="困难">困难</option>'+
'							</select>    											'+
'						</div>'+
'						'+
'						<div class="question-content" style = "display: none">'+
'                           <input class="questionId" type="hidden"  name = "qid" value="">'+
'							<div class="descPanel descOfQuestion">'+
'                                <div class="title">'+
'                                    <span class="tip">题干</span>'+
'                                    <span class="intro">这里填写题目描述(必填项)</span>'+
'                                </div>'+
'                                <div class = "editor">'+
'                                <textarea rows="2" cols="80" type="text"  class="subject" value="" name="subject"></textarea> '+
'                                '+
'                                </div>       '+
'	                        </div>'+
'	'+
'	                        <div class="keyRadio keyPanel radioOfQuestion" style="display: block;">'+
'	                        	<div class="title">'+
'                                    <span class="tip">选项</span>'+
'                                    <span class="intro">单/多选题的选项范围从&nbsp;2&nbsp;到&nbsp;7&nbsp;(设置答案只需要选中相应的选项,必填项)</span>'+
'	                            </div>'+
'	                            <div>'+
'		                            <div class="keyLeft">'+
'                                        <input type="radio" class="radioOrCheck" name="answerOption" value="A"/>'+
'                                        <textarea rows="2" cols="80" class = "radioEdit"  name="optionA"></textarea>'+
'		                            </div>'+
'	                                <div class="keyLeft">'+
'                                    	<input type="radio" class="radioOrCheck" name="answerOption" value="B" />'+
'                                        <textarea rows="2" cols="80" class = "radioEdit"  name="optionB"></textarea>'+
'	                                </div>'+
'                                    <div class="keyLeft">'+
'                                    	<input type="radio" class="radioOrCheck" name="answerOption" value="C" />'+
'                                    	<textarea rows="2" cols="80" class = "radioEdit"  name="optionC"></textarea>'+
'                                    	<span class = "removeKey" onclick="removeKeys(this)"><i class="fa fa-trash" aria-hidden="true"></i></span>'+
'                                    </div>'+
'                                    <div class="keyLeft">'+
'                                    	<input type="radio" class="radioOrCheck" name="answerOption" value="D" />'+
'                                    	<textarea rows="2" cols="80" class = "radioEdit" name="optionD"></textarea>'+
'                                    	<span class = "removeKey" onclick="removeKeys(this)"><i class="fa fa-trash" aria-hidden="true"></i></span>'+
'                                    </div>'+
'	                                <div class="addKeyBtn">'+
'	                                    <button type="button" class="btn btn-l-gray addKey" onclick = "addOption(this)"><i class="plus-style icons8-plus"></i>添加一个选项</button>'+
'	                                </div>'+
'	                            </div>'+
'							</div>'+
'						'+
'							<div class="keyFill keyPanel fillOfQuestion" style="display: none;">'+
'								<div class="title">'+
'	                                 <span class="tip">答案</span>'+
'	                                 <span class="intro">'+
'	                                 		请填写每个填空的答案(一个位置填写一个填空项,最多7个,必填项)'+
'	                                 </span> '+
'	                            </div>'+
'	                            <div class="keyFillContent" style="display: block;">'+
'	                                <div class="input-group">'+
'	                                    <span class="input-group-addon keyFillNum">1</span>'+
'	                                    <input type="text" name="answerFill[]" class="bootstrap-tagsinput answerFill" data-role="tagsinput" placeholder="请输入答案，按下回车添加同义词。" style="display: block;">'+
'	                                </div>'+
'	                               '+
'	                           	</div>'+
'	                            <div class="addKeyFillBtn">'+
'	                                    <button type="button" class="btn btn-l-gray addKeyFill" onclick = "addFill(this)"><i class="plus-style icons8-plus" style="top: 0"></i>增加一个填空</button>'+
'	                            </div>'+
'	                        </div>'+
'	                          '+
'	                        <div class="keyJudge keyPanel judgeOfQuestion" style="display: none;">'+
'	                                <div class="title">'+
'	                                    <span class="tip">选项</span>'+
'	                                    <span class="intro">选择正确或者错误（默认正确）</span>'+
'	                                </div>'+
'	                                '+
'	                                <input type="radio" class="hidden judgeYes"  name="answerJudge" value="正确" checked>'+
'	                                <label for="judgeYes" class="btn btn-border-gray">正确</label>'+
'	                                <input type="radio" class="hidden judgeNo"  name="answerJudge" value="错误">'+
'	                                <label for="judgeNo" class="btn btn-border-gray">错误</label> '+
'	                        </div>'+
'	                            '+
'	                        <div class="keyCloze keyPanel clozeOfQuestion" style="display: none;">'+
'                          		<div class="title">'+
'                                    <span class="tip">答案</span>'+
'                                    <span class="intro">这里填写答案(必填项)</span>'+
'                                </div>'+
'                                <div class = "editor">'+
'	                                <textarea rows="2" cols="80" class="answerCloze"  name="answerCloze"></textarea>'+
'                                </div>'+
'	                        </div>'+
'	                          '+
'	                        <div class="analysisPanel analysisOfQuestion" style="display: block;">'+
'	                          		<div class="title">'+
'	                                    <span class="tip">解析</span>'+
'	                                    <span class="intro">这里填写该问题对应的答案解释(非必填项)</span>'+
'	                                </div>'+
'	                                <div>'+
'	                                <textarea rows="2" cols="80"   class="analysis" value="" name="analysis"></textarea>'+
'	                                </div>'+
'	                        </div>                '+
'						</div>'+
'					'+
'						<button class="btn btn-primary navbar-input-button" onclick="window.open(\'${pageContext.request.contextPath }/question/fileUpload.action\', \'loadPicture\')" type="button" style="display: none">添加图片</button>				'+
'						<button type="submit" class="btn btn-primary" style="display: none">录入题目</button>'+
'					</form>';
			$("#addQuestionItem").before(html);

		}
	</script>

<!-- 展开收起题目 -->
	<script type="text/javascript">
		function openAndCloseQuestion(obj){
			if($(obj).attr("class") == "fa fa-minus-square-o"){
				$(obj).parents(".questionForm").find(".batch-type").hide();
				$(obj).parents(".questionForm").find(".question-content").hide();
				$(obj).attr("class",  "fa fa-plus-square-o");
			}
			else if($(obj).attr("class") == "fa fa-plus-square-o"){
				$(obj).parents(".questionForm").find(".batch-type").show();
				$(obj).parents(".questionForm").find(".question-content").show();
				$(obj).attr("class",  "fa fa-minus-square-o");
			}
		}

	</script>

<!-- 批量提交修改 -->
	<script type="text/javascript">
		function updateQuestions(){
			questionForms = $(".questionForm");
			for(var i = 0; i < questionForms.length; ++i){
				$.ajax({
		            //几个参数需要注意一下
		                type: "POST",//方法类型
		                dataType: "text",//预期服务器返回的数据类型
		                url:  "${pageContext.request.contextPath }/question/update.action",//url
		                data: $(questionForms[i]).serialize(),
		                success: function (result) {
		                	alert("SUCCESS");
		                },
		                error : function() {
		                    alert("异常！");
		                }
		            });
				}
			window.location.href = "${pageContext.request.contextPath }/question/list.action";			
		}
	</script>
</body>

</html>
