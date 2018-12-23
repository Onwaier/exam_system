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

<title>e卷题库抽题组卷系统</title>

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
<link href="<%=basePath%>css/previewPaper.css" rel="stylesheet">

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
		</nav>

		<div id="page-wrapper">
			<div class="group_main"></div>
		</div>
		<!-- /#page-wrapper -->

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
	
	
	<script type="text/javascript">
		$(document).ready(function(){
			//alert('${page}');
			var str = JSON.stringify(${page});
            var obj = eval(str);
			for(var i = 0; i < obj.length; ++i){
				for(var j = 0; j < obj[i].rows.length; ++j){
					console.log(obj[i].rows[j]);
					var question = obj[i].rows[j];
					addQuestionInPage(question);
				}
			}
		});
	</script>
	
	<!-- 在页面中添加试题 -->
	<script type = "text/javascript">
		function addQuestionInPage(question){
			var type = question.type;
			console.log(type);
			var typeDict = {"0":0, "单选题":1, "多选题":2, "判断题":3, "填空题":4, "问答题":5, "简述题":6, "名词解释":7};
			var resNum = typeDict[type], idx;
			var mainHtml = 
				'<div class="group_simple" num="' + resNum + '">'+
				'					<div class="questions-title">' + type + '(共<span class = "quesNum">0</span>题)</div>'+
				'					<div class="questions-group">'+
				'						<div class="group_questionShow">'+
				'				        </div>  '+
				'					</div>  '+
				'            	</div>';
			console.log($(".group_main").html());
			if($(".group_main").html() == ""){
				$(".group_main").append(mainHtml);
				idx = 0;
			}
			else{
				var groupSimples = $(".group_simple");
				var i = 0, tmpNum = 0;
				var isExist = false;
				for(; i < groupSimples.length; ++i){
					tmpNum = parseInt($(groupSimples[i]).attr("num"));
					if(tmpNum == resNum){
						isExist = true;
						break;
					}
				}
				if(isExist){
					idx = i;
				}
				else{
					$(".emptyTip").hide();
					$(groupSimples[i - 1]).after(mainHtml);
					idx = i;
				}
			}
			var questionHtml = '<div class="question-content" style="display: block">'+
			'		<input name="qid" class="questionId" type="hidden" value="' + question.qid +'">		'+
			'		<div class="descPanel descOfQuestion">            '+
			'			<div class="content">' + question.subject+'</div>               '+
			'		</div>        '+
			'		<div class="keyRadio keyPanel radioOfQuestion" style="display: block;">            '+
			'			<div class="optionContent content">                '+
			'				<div class="keyLeft">                    '+
			'					<span class="optionDes">A.&nbsp;&nbsp;</span>                    '+
			'					<span class="content">' + question.optionA +'</span>                '+
			'				</div>                '+
			'				<div class="keyLeft">                	'+
			'					<span class="optionDes">B.&nbsp;&nbsp;</span>                    '+
			'					<span class="content">' + question.optionB +'</span>                '+
			'				</div>                '+
			'				<div class="keyLeft">                	'+
			'					<span class="optionDes">C.&nbsp;&nbsp;</span>                	'+
			'					<span class="content">' + question.optionC +'</span>                '+
			'				</div>                '+
			'				<div class="keyLeft">                	'+
			'					<span class="optionDes">D.&nbsp;&nbsp;</span>                	'+
			'					<span class="content">' + question.optionD +'</span>                '+
			'				</div>            '+
			'			</div>            '+
			'			<div class="content answer">			 	'+
			'				<span class="answerDes">答案:&nbsp;&nbsp;</span>                '+
			'				<span>' + question.answer +'</span>            '+
			'			</div>		'+
			'		</div>			'+
			'		<div class="keyFill keyPanel fillOfQuestion" style="display: none;">            '+
			'			<div class="keyFillContent content" style="display: block;">			 	'+
			'				<span class="answerDes">答案:&nbsp;&nbsp;</span>				'+
			'				<span class="content">' +question.answer +'</span>           	'+
			'			</div>        '+
			'		</div>                  '+
			'		<div class="keyJudge keyPanel judgeOfQuestion" style="display: none;">            '+
			'			<div class="content">			 	'+
			'				<span class="answerDes">答案:&nbsp;&nbsp;</span>                '+
			'				<span>' + question.answer+'</span>            '+
			'			</div>        '+
			'		</div>                    '+
			'		<div class="keyCloze keyPanel clozeOfQuestion" style="display: none;">            '+
			'			<div class="content">			 	'+
			'				<span class="answerDes">答案:&nbsp;&nbsp;</span>                '+
			'				<span>' + question.answer+'</span>            '+
			'			</div>        '+
			'		</div>                  '+
			'		<div class="analysisPanel analysisOfQuestion" style="display: none;">            '+
			'			<div class="content">			 	'+
			'				<span class="analysisDes">解析:&nbsp;&nbsp;</span>            	'+
			'				<span>' +question.analysis +'</span>            '+
			'			</div>        '+
			'		</div>                        '+
			'		<div class="chapterPanel chapterOfQuestion" style="display: none;">            '+
			'			<div class="content">			 	'+
			'				<span class="chapterDes">章节:&nbsp;&nbsp;</span>            	'+
			'				<span>' + question.chapter +'</span>            '+
			'			</div>        '+
			'		</div>                        '+
			'		<div class="knowpointPanel knowpointOfQuestion" style="display: none;">            '+
			'			<div class="content">			 	'+
			'				<span class="knowpointDes">知识点:&nbsp;&nbsp;</span>            	'+
			'				<span>' + question.knowPoint +'</span>            '+
			'			</div>        '+
			'		</div>                		 '+
			'		<i class="fa fa-plus-square-o" aria-hidden="true" onclick = "showMore(this, \'' + question.type + '\')">点击查看更多</i>'+
			'	</div>';
			console.log("idx:" + idx);
			var groupQuestionShow = $(".group_simple:eq(" + idx + ") .group_questionShow"); 
			var typeArray = new Array("radioOfQuestion", "fillOfQuestion", "judgeOfQuestion", "clozeOfQuestion");
			var alphaDict = {"A":0, "B":1, "C":2, "D":3, "E":4, "F":5, "G":6};
			var quesNum = parseInt($(".group_simple:eq(" + idx + ") .quesNum").html());
			console.log("quesNum:" + quesNum);
			$(groupQuestionShow).append(questionHtml);
			$(".group_simple:eq(" + idx + ") .quesNum").html(quesNum + 1);
			console.log("resNum:" + resNum);
			/* 根据题目类型显示 不同字段 */
			var index;
			for(index in typeArray){
				$(groupQuestionShow).find("." + typeArray[index]).hide();
				
			}
			switch(resNum){
			case 1:$(groupQuestionShow).find("." + typeArray[0]).show();
			$(groupQuestionShow).find("." + typeArray[0]).find(".answer").hide();
				var options = $(groupQuestionShow).find("." + typeArray[0] + ":last").find(".keyLeft");
				$(options[alphaDict[question.answer]]).addClass("correctAnswer");
			break;
			case 2:$(groupQuestionShow).find("." + typeArray[0]).show();
			break;
			case 3:
				$(groupQuestionShow).find("." + typeArray[2]).hide();
			break;
			case 4:
				$(groupQuestionShow).find("." + typeArray[1]).hide();
			break;
			case 5:$(groupQuestionShow).find("." + typeArray[3]).hide();
			break;
			case 6:$(groupQuestionShow).find("." + typeArray[3]).hide();
			break;
			case 7:$(groupQuestionShow).find("." + typeArray[3]).hide();
			break;
			default:
			alert("其它");
			break;
		}
		}
	</script>

	//显示试题的更多内容
	<script type="text/javascript">
		function showMore(obj, type){
			var typeDict = {"0":0, "单选题":1, "多选题":2, "判断题":3, "填空题":4, "问答题":5, "简述题":6, "名词解释":7};
			var typeNum = typeDict[type];
			var typeArray = new Array("radioOfQuestion", "fillOfQuestion", "judgeOfQuestion", "clozeOfQuestion");
			if($(obj).attr("class") == "fa fa-minus-square-o"){
				$(obj).parents(".question-content").find(".analysisOfQuestion").hide();
				$(obj).parents(".question-content").find(".chapterOfQuestion").hide();
				$(obj).parents(".question-content").find(".knowpointOfQuestion").hide();
				switch(typeNum){
				case 1:
					$(obj).parents(".question-content").find(".answer").hide();
					
					break;
				case 2:
					$(obj).parents(".question-content").find(".answer").hide();
					break;
				case 3:
					$(obj).parents(".question-content").find("." + typeArray[2]).hide();
					break;
				case 4:
					$(obj).parents(".question-content").find("." + typeArray[1]).hide();
					break;
				case 5:
					$(obj).parents(".question-content").find("." + typeArray[3]).hide();
					break;
				case 6:
					$(obj).parents(".question-content").find("." + typeArray[3]).hide();
					break;
				case 7:
					$(obj).parents(".question-content").find("." + typeArray[3]).hide();
					break;
				}
				$(obj).attr("class",  "fa fa-plus-square-o");
				$(obj).html("点击查看更多");
			}
			else if($(obj).attr("class") == "fa fa-plus-square-o"){
				$(obj).parents(".question-content").find(".analysisOfQuestion").show();
				$(obj).parents(".question-content").find(".chapterOfQuestion").show();
				$(obj).parents(".question-content").find(".knowpointOfQuestion").show();
				switch(typeNum){
				case 1:
					$(obj).parents(".question-content").find(".answer").show();
					
					break;
				case 2:
					$(obj).parents(".question-content").find(".answer").show();
					break;
				case 3:
					$(obj).parents(".question-content").find("." + typeArray[2]).show();
					break;
				case 4:
					$(obj).parents(".question-content").find("." + typeArray[1]).show();
					break;
				case 5:
					$(obj).parents(".question-content").find("." + typeArray[3]).show();
					break;
				case 6:
					$(obj).parents(".question-content").find("." + typeArray[3]).show();
					break;
				case 7:
					$(obj).parents(".question-content").find("." + typeArray[3]).show();
					break;
				}
				$(obj).attr("class",  "fa fa-minus-square-o");
				$(obj).html("收起");
			}
			
		}
	</script>
	
</body>

</html>