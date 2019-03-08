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

 <!-- 图片样式 -->
<%-- <link href="<%=basePath%>css/pictureStyle.css" rel="stylesheet"> --%>

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

<body onload = "initSelect();">

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
			<!-- /.navbar-static-side --> 
		</nav>

		<div id="page-wrapper">
			
			<div class = "row">
				<ul id="myTab" class="nav nav-pills nav-justified">
					<li class="active col-xs-6" id="navManulInput">
						<a href="#manualInput" data-toggle="tab">
							 手动录入
							
						</a>
					</li>
					<li class = "col-xs-6" id = "navFileInput">
						<a href="#fileInput" data-toggle="tab">
							批量录入
							 <span class = "fileIcon">
							<i class="fa fa-file-excel-o" style = "display: none" id = "excelIcon"></i>
                   			<i class="fa fa-file-word-o" style = "display: none" id = "wordIcon"></i>
							</span>
						</a>
						
                	</li>
				</ul>
			</div>
			
			<div id="myTabContent" class="tab-content">
				
				<div class="tab-pane fade in active" id="manualInput">
					<form class="form-inline" action="${pageContext.request.contextPath }/question/add.action" method="post" 
								method="post" enctype="multipart/form-data" onsubmit="return checkAddQuestion()">		
						<div class="batch-type">
					
									<span class="intro course">科目</span>
									<select	class="form-control" name = "course" style="width:100px;" id = "course" onchange="updateChapterSel();">
										<option value="">--请选择--</option>
									</select>
									<span class="intro chapter">章节</span>
									<select	class="form-control" name = "chapter" style="width:100px;" id = "chapter" onchange="updateKnowpointSel();">
										<option value="">--请选择--</option>
									</select>
									<span class="intro knowpoint">知识点</span>
									<select	class="form-control" name = "knowPoint" style="width:100px;" id = "knowpoint">
										<option value="">--请选择--</option>
									</select>
			
										<span class="intro type">试题类型</span>
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
										<select	class="form-control" name="difficulty">
											<option value="0">--请选择--</option>
											<option value="简单">简单</option>
											<option value="中等">中等</option>
											<option value="困难">困难</option>
										</select>    
								
								
						</div>
						
						<div class="question-content">
							<div class="descPanel" id = "descOfQuestion">
	                                <div class="title">
	                                    <span class="tip">题干</span>
	                                    <span class="intro">这里填写题目描述</span>
	                                </div>
	                                <div class = "editor">
	                                <textarea rows="2" cols="80" type="text"  id="subject" value="" name="subject"></textarea>
	                                </div>
	                                
	                        </div>
	
	                        <div class="keyRadio keyPanel" id = "radioOfQuestion" style="display: block;">
	                        	<div class="title">
	                                    <span class="tip">选项</span>
	                                    <span class="intro">单/多选题的选项范围从&nbsp;2&nbsp;到&nbsp;8&nbsp;</span>
	                            </div>
	                            <div>
		                            	<div class="keyLeft">
	                                         <input type="radio" class="radioOrCheck" name="answerOption" value="A" />
	                                        <textarea rows="2" cols="80" class = "radioEdit" id="edit_optionA"  name="optionA"></textarea>
		                                </div>
	                                   <div class="keyLeft">
	                                       <input type="radio" class="radioOrCheck" name="answerOption" value="B" />
	                                       <textarea rows="2" cols="80" class = "radioEdit" id="edit_optionB"  name="optionB"></textarea>
	                                   </div>
	                                   <div class="keyLeft">
	                                       <input type="radio" class="radioOrCheck" name="answerOption" value="C" />
	                                       <textarea rows="2" cols="80" class = "radioEdit" id="edit_optionC"  name="optionC"></textarea>
	                                       <span class = "removeKey" onclick="removeKeys(this)"><i class="fa fa-trash" aria-hidden="true"></i></span>
	                                   </div>
	                                   <div class="keyLeft">
	                                       <input type="radio" class="radioOrCheck" name="answerOption" value="D" />
	                                       <textarea rows="2" cols="80" class = "radioEdit" id="edit_optionD"  name="optionD"></textarea>
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
	                                    <input type="text" name="answerFill[]" class="bootstrap-tagsinput" id="answerFill[]" data-role="tagsinput" placeholder="请输入答案，按下回车添加同义词。">
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
	                                
	                                <input type="radio" class="hidden"  name="answerJudge" id="judgeYes" value="正确">
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
		                                <textarea rows="2" cols="80" id="answerCloze"  name="answerCloze"></textarea>
	                                </div>
	                          </div>
	                          
	                        <div class="analysisPanel" id = "analysisOfQuestion" style="display: block;">
	                          		<div class="title">
	                                    <span class="tip">解析</span>
	                                    <span class="intro">这里填写该问题对应的答案解释</span>
	                                </div>
	                                <div>
	                                	<textarea rows="2" cols="80"   id="analysis" value="" name="analysis"></textarea>
	                                </div>
	                          </div>                         
						</div>
					
			
						<div class="lccid">
							<p class="title">
							<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
									题干图片</p>
							<img src="" / class="img">
							<input id = "subjectPic" type="file" class="file" placeholder="ICCID" accept="image/*" capture="camera" name="uploadfile" multiple="multiple">
						</div>
						

						<div class="lccid">
							<p class="title">
							<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
									答案图片</p>
							<img src="" / class="img">
							<input type="file" class="file" placeholder="ICCID" accept="image/*" capture="camera" name="uploadfile" multiple="multiple">
						</div>
						
<!-- 						<div class="lccid"> -->
<!-- 							<p class="title"> -->
<!-- 							<span class="glyphicon glyphicon-plus" aria-hidden="true"></span> -->
<!-- 									选项图片</p> -->
<!-- 							<img src="" / class="img"> -->
<!-- 							<input type="file" class="file" placeholder="ICCID" accept="image/*" capture="camera" name="uploadfile" multiple="multiple"> -->
<!-- 						</div> -->
						
<!-- 						<div class="lccid"> -->
<!-- 							<p class="title"> -->
<!-- 							<span class="glyphicon glyphicon-plus" aria-hidden="true"></span> -->
<!-- 									解析图片</p> -->
<!-- 							<img src="" / class="img"> -->
<!-- 							<input type="file" class="file" placeholder="ICCID" accept="image/*" capture="camera" name="uploadfile" multiple="multiple"> -->
<!-- 						</div> -->
						

				
				
<%-- 						<button class="btn btn-primary navbar-input-button" onclick="window.open('${pageContext.request.contextPath }/question/fileUpload.action', 'loadPicture')" type="button">添加图片</button>				 --%>
						<button type="submit" class="btn btn-primary">录入题目</button>
	
	
	
						<form  enctype="multipart/form-data">
						    <ul class='carouselbox'>
						    	
						        
						    </ul>
<!-- 						    <div class='preview_footer'> -->
<!-- 						        <input type="button" value='添加' id="carouselplus" class="preview_btn" >&nbsp; -->
<!-- 						        <input type="button" value='保存' id="carouselsubmit" class="preview_btn" > -->
<!-- 						    </div> -->
						</form>
						
	
					</form>
					
				</div>
				
				<div class="tab-pane fade" id="fileInput">
						<div id="excelImport">
				            <div class="btn-row" style="text-align: center;">
				                <img style="margin-top: 50px;" src="<%=basePath%>images/batch-add-excel.png" alt="">
				            </div>
				            <img src='<%=basePath%>images/loading_jump.gif' class="loading" style="position:absolute;top: 30%;left: 40%;width:250px;display:none;border-radius: 30px;box-shadow: 2px 2px 5px #ccc;"/>
				            <div class="btn-row" style="text-align: center;">
				                <a class="btn btn-primary download" href="https://github.com/breezelj/Template/raw/master/excel%E6%89%B9%E9%87%8F%E5%AF%BC%E5%85%A5%E6%B5%8B%E8%AF%95%E6%A1%88%E4%BE%8B%E5%8F%8A%E6%A8%A1%E6%9D%BF%E8%AF%B4%E6%98%8E.xlsx" style="margin-right: 205px;">下载模版</a>

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
<%-- 					             <button class="btn btn-primary download" style="margin-right: 205px;" onclick="window.location.href='${pageContext.request.contextPath }/question/showFile.action'" type="button"> --%>
<!-- 									下载模板 -->
<!-- 								 </button> -->
							<a class="btn btn-primary download" href="https://github.com/breezelj/Template/raw/master/e%E5%8D%B7%E9%A2%98%E5%BA%93%E6%8A%BD%E9%A2%98%E7%BB%84%E5%8D%B7%E7%B3%BB%E7%BB%9Fword%E6%89%B9%E9%87%8F%E5%AF%BC%E5%85%A5%E6%A8%A1%E6%9D%BFV1.0.docx" style="margin-right: 205px;">下载模版</a>

				                <form id="uploadForm" class="upload-form">
				                    <button class="btn btn-primary upload" onclick="window.location.href='${pageContext.request.contextPath }/question/wordInput.action'" type="button">上传word</button>
				                    <div class="tip">word大小限制为1MB以下</div>
				                </form>
				                
				                
				                
				            </div>
				            
				        </div>
				        <div id="demo"></div>
				   
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
	
 <!-- 	添加图片 --> 
<%--     <script src="<%=basePath%>/pictureCss/jquery-1.9.1.min.js"></script> --%>
<%--     <script src="<%=basePath%>/pictureCss/layer.js" type="text/javascript"></script> --%>
   
    
   
  

	
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

	
	<script type="text/javascript">
	function getValue(){
		var radio = document.getElementsByName("answer");
		for (i=0; i<radio.length; i++) {
			if (radio[i].checked) {
				return (radio[i].value);
			}
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
				case 1:document.getElementById(typeArray[0]).style.display = "block";
				var radioOrChecks = document.getElementsByClassName("radioOrCheck");
				var i;
				for(i in radioOrChecks)
					radioOrChecks[i].type = "radio";
				break;
				case 2:document.getElementById(typeArray[0]).style.display = "block";
				var radioOrChecks = document.getElementsByClassName("radioOrCheck");
				var i;
				for(i in radioOrChecks)
					radioOrChecks[i].type = "checkbox";
				break;
				case 3:document.getElementById(typeArray[2]).style.display = "block";
				break;
				case 4:document.getElementById(typeArray[1]).style.display = "block";
				break;
				case 5:document.getElementById(typeArray[3]).style.display = "block";
				break;
				case 6:document.getElementById(typeArray[3]).style.display = "block";
				break;
				case 7:document.getElementById(typeArray[3]).style.display = "block";
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
			var optionArray = new Array("A", "B", "C", "D", "E", "F", "G")
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
			if(keyFills.length >= 8){
				$(".addKeyFillBtn").css("display", "none");
			}
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
// 					alert(keyLefts.length);
					for(var i = 0; i < keyLefts.length; ++i){
						var radioEdit = $(keyLefts[i]).find("textarea").val();
						if(radioEdit == "" || radioEdit == null){
							alert("选项内容不能为空");
							return false;
						}
						
						//alert($(keyLefts[i]).find("input").attr("checked"));
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
// 						alert($(keyLefts[i]).find("input").prop("checked"));
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
			alert("添加成功");
			return true;
		}
	</script>
	
	
<!-- 从excel中导入题目 -->
	<script type="text/javascript">
            /*
            FileReader共有4种读取方法：
            1.readAsArrayBuffer(file)：将文件读取为ArrayBuffer。
            2.readAsBinaryString(file)：将文件读取为二进制字符串
            3.readAsDataURL(file)：将文件读取为Data URL
            4.readAsText(file, [encoding])：将文件读取为文本，encoding缺省值为'UTF-8'
                         */
            var wb;//读取完成的数据
            var rABS = false; //是否将文件读取为二进制字符串

            function importf(obj) {//导入
                if(!obj.files) {
                    return;
                }
                var f = obj.files[0];
                var reader = new FileReader();
                reader.onload = function(e) {
                    var data = e.target.result;
                    if(rABS) {
                        wb = XLSX.read(btoa(fixdata(data)), {//手动转化
                            type: 'base64'
                        });
                    } else {
                        wb = XLSX.read(data, {
                            type: 'binary'
                        });
                    }
                    //wb.SheetNames[0]是获取Sheets中第一个Sheet的名字
                    //wb.Sheets[Sheet名]获取第一个Sheet的数据
                    //document.getElementById("demo").innerHTML= JSON.stringify( XLSX.utils.sheet_to_json(wb.Sheets[wb.SheetNames[0]]) );
                    var sheetNames = ["课程题库", "混合题", "单选题", "多选题", "判断题", "填空题", "简答题", "应用题", "设计题"];
                    var str = JSON.stringify( XLSX.utils.sheet_to_json(wb.Sheets[wb.SheetNames[0]]) );
                    var successCnt = 0;
                    var failCnt = 0;
                    var questions = [];//存储excel中的question
                    obj = eval(str);
                    $(".loading").show();
                    for(var i = 0; i < wb.SheetNames.length; ++i){
                    	console.log(wb.SheetNames[i]);
                    	sheetArray = wb.SheetNames[i].split("-");
                    	console.log(sheetArray);
                    	var flag = false;
                    	for(var j = 0; j < sheetNames.length; ++j){
                    		if(sheetArray[0] == sheetNames[j]){
                    			flag = true;
                    			break;
                    		}
                    	}
                    	if(flag){
                    		var str = JSON.stringify( XLSX.utils.sheet_to_json(wb.Sheets[wb.SheetNames[i]]));
                            obj = eval(str);
                            if(sheetArray[0] == "课程题库"){
                            	for(var j = 0; j < obj.length; ++j){
                            		/* 对题干处理*/
                            		obj[j].subject = obj[j].题干;
                            		/* 对难度进行处理 */
                            		obj[j].difficulty = obj[j].难易度;
                                	if(obj[j].difficulty == "难" || obj[j].difficulty == "困难"){
                              			obj[j].difficulty = "困难";
                              		}
                              		else if(obj[j].difficulty == "中" || obj[j].difficulty == "中等"){
                              			obj[j].difficulty = "中等";
                              		}
                              		else if(obj[j].difficulty == "易" || obj[j].difficulty == "困难"){
                              			obj[j].difficulty = "简单";
                              		}
                              		else{
                              			//处理：当难度用小数表示时
                              			var floatDifficulty = parseFloat(obj[j].difficulty);
                              			if(!isNaN(floatDifficulty)){
                              				if(floatDifficulty >= 0.1 && floatDifficulty <= 0.3){
                              					obj[j].difficulty = "简单";
                              				}
                              				else if(floatDifficulty >= 0.4 && floatDifficulty <= 0.6){
                              					obj[j].difficulty = "中等";
                              				}
                              				else{
                              					obj[j].difficulty = "困难";
                              				}
                              			}
                              		}
                                	/*  对解析处理*/
                                	obj[j].analysis = obj[j].答案解析;
                                	/* 对题型处理*/
                                	obj[j].type = obj[j].题型;
                                	/*题型的容错处理*/
                                	/* if(obj[j].type == "简答题"){
                                		obj[j].type = "问答题";
                                	}
                                	if(obj[j].type == "论述题"){
                                		obj[j].type = "简述题";
                                	} */
                                	/*对选项处理*/
                                	obj[j].optionA = obj[j].A;
                                	obj[j].optionB = obj[j].B;
                                	obj[j].optionC = obj[j].C;
                                	obj[j].optionD = obj[j].D;
                                	obj[j].optionE = obj[j].E;
                                	obj[j].optionF = obj[j].F;
                                	obj[j].optionG = obj[j].G;
                                	/*对选项数处理*/
                                	obj[j].optionNum = obj[j].选项数;
                                	/* 对答案处理*/
                                	obj[j].answer = obj[j].正确答案;
                                	if(obj[j].type == "单选题"){
                                		//不用处理
                                	}
                                	else if(obj[j].type == "多选题"){
                                		var str = obj[j].answer.split('').join(',');
                                		obj[j].answer = str;	
                                	}
                                	else if(obj[j].type == "判断题"){
                                		obj[j].answer = obj[j][obj[j].answer];
                                	}
                                	else if(obj[j].type == "填空题"){
                                		var arr = obj[j].answer.split('');
                                		var res = [];
                                		for(var i = 0; i < arr.length; ++i){
                                			res.push(obj[j][arr[i]]);
                                		}
                                		obj[j].answer = res.join("#");
                                	}
                                	else if(obj[j].type == "简答题" || obj[j].type == "应用题" || obj[j].type == "设计题"){
                                		obj[j].answer = obj[j][obj[j].answer];
                                	}
                                	obj[j].answerOption = obj[j].answer;
                                	obj[j].answerJudge = obj[j].answer;
                                	obj[j].type == "填空题"?obj[j].answerFill = obj[j].answer.split("#"):obj[j].answerFill = [];
                                	obj[j].answerCloze = obj[j].answer;
                                	/* 对章节进行处理 */
                                	console.log(obj[j]);
                            		questions.push(obj[j]);
                            	}
                            }
                            else{
                            	for(var j = 1; j < obj.length; ++j){
                            		if(sheetArray[0] != "混合题"){
                            			obj[j].type = sheetArray[0];
                            		}
                                	if(obj[j].subject == null || obj[j].answer == null || obj[j].type == null){
                                		alert("模板不规范,请检查后重试");
                                		break;
                                	}
                                	if(sheetArray.length == 2){
                                		obj[j].courseName = sheetArray[1];
                                	}
                                	/* 对答案进行处理 */
                                	obj[j].answerOption = obj[j].answer;
                                	obj[j].answerJudge = obj[j].answer;
                                	obj[j].type == "填空题"?obj[j].answerFill = obj[j].answer.split("#"):obj[j].answerFill = [];
                                	obj[j].answerCloze = obj[j].answer;
                                	/* 对难度进行处理 */
                                	if(obj[j].difficulty == "难" || obj[j].difficulty == "困难"){
                              			obj[j].difficulty = "困难";
                              		}
                              		else if(obj[j].difficulty == "中" || obj[j].difficulty == "中等"){
                              			obj[j].difficulty = "中等";
                              		}
                              		else if(obj[j].difficulty == "易" || obj[j].difficulty == "困难"){
                              			obj[j].difficulty = "简单";
                              		}
                              		else{
                              			//处理：当难度用小数表示时
                              			var floatDifficulty = parseFloat(obj[j].difficulty);
                              			if(!isNaN(floatDifficulty)){
                              				if(floatDifficulty >= 0.1 && floatDifficulty <= 0.3){
                              					obj[j].difficulty = "简单";
                              				}
                              				else if(floatDifficulty >= 0.4 && floatDifficulty <= 0.6){
                              					obj[j].difficulty = "中等";
                              				}
                              				else{
                              					obj[j].difficulty = "困难";
                              				}
                              			}
                              		}
                                	/* 对章节进行处理 */
                                	console.log(obj[j]);
                            		questions.push(obj[j]);
                            	}
                            }
                    	}
                    }
                    for(var k = 0; k < questions.length; ++k){
                    	setTimeout((function (k) {
				            return function () {
				                $.ajax({
				                    type:'post',  
					                dataType : "text",
					                async:true,
					                url: "<%=basePath%>question/excelAdd.action",
					                data:questions[k],  
				                    success: function (response) {
				                    	if(response == "success"){
				                    		++successCnt;
				                    	}
				                    	else{
				                    		++failCnt;
				                    	}
				                    	console.log(response);
						                console.log(successCnt);
				                        if((successCnt + failCnt) == questions.length - 1){
				                        var mes = "录入成功";
				                       	 alert(mes);
				                       	 $(".loading").hide();
				                      }
				                    },
				                    failure: function (response) { 
				                    	
				                    }
                
				                });
				            }
				        })(k), 10);
                    }
                   
                }; 
                if(rABS) {
                    reader.readAsArrayBuffer(f);
                } else {
                    reader.readAsBinaryString(f);
                }
            }

            function fixdata(data) { //文件流转BinaryString
                var o = "",
                    l = 0,
                    w = 10240;
                for(; l < data.byteLength / w; ++l) o += String.fromCharCode.apply(null, new Uint8Array(data.slice(l * w, l * w + w)));
                o += String.fromCharCode.apply(null, new Uint8Array(data.slice(l * w)));
                return o;
            }
        </script>
        

        
        
        <script type="text/javascript">
        	$("#navManulInput").click(function(e){
        		$("#excelIcon").hide();
        		$("#wordIcon").hide();
        	});
        	$("#navFileInput").click(function(e){
        		$("#excelIcon").show();
        		$("#wordIcon").show();
        		$("#excelIcon").css("background-color", "#000");
        	});
        	$("#excelIcon").click(function(e){
        		e.stopPropagation();
        		$("#excelImport").show();
        		$("#wordImport").hide();
				$("#excelIcon").css("background-color", "#000");
				$("#wordIcon").css("background-color", "#337AB7");
        	});
        	$("#wordIcon").click(function(e){
        		e.stopPropagation();
        		$("#excelImport").hide();
        		$("#wordImport").show();
        		$("#wordIcon").css("background-color", "#000");
        		$("#excelIcon").css("background-color", "#337AB7");
        	})
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

	<!-- 级联展现科目、章节、知识点 -->
	<script type = "text/javascript">
		var courseList = eval('${course}');
		var courses = eval('${course}');
	    var chapters = eval('${chapter}');
		var knowpoints = eval('${knowpoint}');
	    var courseSelNode;
	    var chapterSelNode;
		var knowpointSelNode;
	    function initSelect(){
	    	/* alert("courses: " + courses);
			alert("chapters: " + chapters);
 			alert("knowpoints: " + knowpoints); */
	        //初始化科目、章节和知识点下拉菜单
	
	       	courseSelNode = document.getElementById("course");
	        chapterSelNode = document.getElementById("chapter");
	        knowpointSelNode = document.getElementById("knowpoint");
	        //1.初始化科目下拉菜单
	        for(var i=0;i<courses.length;i++){
	
	            //更简洁的操作
	            var optNode = new Option(courses[i],courses[i]);
	            courseSelNode.appendChild(optNode);
	        }
	
	        //2.初始化章节下拉菜单
	        if(chapters.length > 0 && chapters[0].length > 0){
	        	for(var i=0;i<chapters[0].length;i++){
	        		
		            var optNode = new Option(chapters[0][i],chapters[0][i]);
		            chapterSelNode.appendChild(optNode);
		        }
	        }
	         
	        
	        //3.初始化知识点下拉菜章
	        if(knowpoints.length > 0 && knowpoints[0].length > 0 && knowpoints[0][0].length > 0){
	        	for(var i=0;i<knowpoints[0][0].length;i++){
		            var optNode = new Option(knowpoints[0][0][i],knowpoints[0][0][i]);
		            knowpointSelNode.appendChild(optNode);
		        }

	        	
	        }
	        	        
	        var courseList = eval('${course}');
	        //console.log(courseList[0]);
	    }
	    function updateChapterSel(){
	        //清空章节下拉菜单
	       chapterSelNode.options.length = 0;
			//清空知识点下拉菜单
			knowpointSelNode.options.length = 0;
	        //更新章节下拉菜单
	        var index = courseSelNode.selectedIndex - 1;
	        for(var i=0;i<chapters[index].length;i++){
	            var optNode = new Option(chapters[index][i],chapters[index][i]);
	            chapterSelNode.appendChild(optNode);
	            if(i == 0){
	            	for(var j=0;j<knowpoints[index][0].length; j++){
	            		var optNode = new Option(knowpoints[index][0][j],knowpoints[index][0][j]);
	     	            knowpointSelNode.appendChild(optNode);
	            	}
	            }
	        } 
	    }
	    function updateKnowpointSel(){
	    	//清空知识点下拉菜单
			knowpointSelNode.options.length = 0;
			var index1 = courseSelNode.selectedIndex - 1;
			var index2 = chapterSelNode.selectedIndex;
			for(var i=0;i<knowpoints[index1][index2].length;i++){
	            var optNode = new Option(knowpoints[index1][index2][i],knowpoints[index1][index2][i]);
	            knowpointSelNode.appendChild(optNode);
	        } 
	    }
	</script>




</body>

</html>