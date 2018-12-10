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
<link href="<%=basePath%>css/pictureStyle.css" rel="stylesheet">

<!-- Bootstrap Core CSS -->
<link href="<%=basePath%>css/bootstrap.min.css" rel="stylesheet">


<!-- MetisMenu CSS -->
<link href="<%=basePath%>css/metisMenu.min.css" rel="stylesheet">

<!-- DataTables CSS -->
<link href="<%=basePath%>css/dataTables.bootstrap.css" rel="stylesheet">


<!-- Custom Fonts -->
<link href="<%=basePath%>cssz/font-awesome.min.css" rel="stylesheet"
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
		
		<div>	
	        <form class="navbar-form navbar-right navbar-search-form" role="form">
	        	<div class="input-group">
					<span class="input-group-btn">
						</button>
						<button class="btn btn-primary navbar-input-button" onclick="window.location.href='${pageContext.request.contextPath }/question/showFile.action'" type="button">
							下载模板
						</button>
						<button class="btn btn-primary navbar-input-button" onclick="window.location.href='${pageContext.request.contextPath }/question/wordInput.action'" type="button">
							word题目导入数据库
						</button>
					</span>
				</div><!-- /input-group -->	            
	        </form> 
    	</div>
		 
		<!-- /.navbar-top-links -->

		<div class="navbar-default sidebar" role="navigation" id = "question-sidebar">
			<div class="sidebar-nav navbar-collapse">
				<ul class="nav" id="side-menu">
					<li><a href="${pageContext.request.contextPath }/question/list.action" class="active"><i
							class="fa fa-edit fa-fw"></i> 题库管理</a></li>
					<li><a href="${pageContext.request.contextPath }/paper/list.action"><i
							class="fa fa-dashboard fa-fw"></i> 试卷管理</a></li>
				</ul>
			</div>
			<!-- /.sidebar-collapse -->
		</div>
		<!-- /.navbar-static-side --> </nav>

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
					
									<span class="intro chapter">章节</span>
									<select	class="form-control" name = "chapter">
										<option value="">--请选择--</option>
									</select>
									<span class="intro knowpoint">知识点</span>
									<select	class="form-control" name = "knowPoint">
										<option value="">--请选择--</option>
									</select>
			
										<span class="intro type">试题类型</span>
										<select	class="form-control" id="questionType" name="type">
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
	                                <textarea rows="2" cols="80" type="text"  id="subject" value="${subject }" name="subject"></textarea>
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
	                                	<textarea rows="2" cols="80"   id="analysis" value="${analysis}" name="analysis"></textarea>
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
									选项图片</p>
							<img src="" / class="img">
							<input type="file" class="file" placeholder="ICCID" accept="image/*" capture="camera" name="uploadfile" multiple="multiple">
						</div>
						
						<div class="lccid">
							<p class="title">
							<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
									解析图片</p>
							<img src="" / class="img">
							<input type="file" class="file" placeholder="ICCID" accept="image/*" capture="camera" name="uploadfile" multiple="multiple">
						</div>
						
						<div class="lccid">
							<p class="title">
							<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
									答案图片</p>
							<img src="" / class="img">
							<input type="file" class="file" placeholder="ICCID" accept="image/*" capture="camera" name="uploadfile" multiple="multiple">
						</div>
				
				
						<button class="btn btn-primary navbar-input-button" onclick="window.open('${pageContext.request.contextPath }/question/fileUpload.action', 'loadPicture')" type="button">添加图片</button>				
						<button type="submit" class="btn btn-primary">录入题目</button>
	
	
	
						<form  enctype="multipart/form-data">
						    <ul class='carouselbox'>
						    	
						        
						    </ul>
						    <div class='preview_footer'>
						        <input type="button" value='添加' id="carouselplus" class="preview_btn" >&nbsp;
						        <input type="button" value='保存' id="carouselsubmit" class="preview_btn" >
						    </div>
						</form>
						
	
					</form>
					
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
    <script src="<%=basePath%>/pictureCss/jquery-1.9.1.min.js"></script>
    <script src="<%=basePath%>/pictureCss/layer.js" type="text/javascript"></script>
   
    
   
  

	
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
		var typeDict = {"--请选择--":0, "单选题":1, "多选题":2, "判断题":3, "填空题":4, "问答题":5, "简述题":6, "名词解释":7};
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
				alert("其它");
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
			var typeDict = {"0":0, "单选题":1, "多选题":2, "判断题":3, "填空题":4, "问答题":5, "简述题":6, "名词解释":7};
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
					alert(keyLefts.length);
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
						alert($(keyLefts[i]).find("input").prop("checked"));
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
					var answer = $("#questionAnswer").val();
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
                    var str = JSON.stringify( XLSX.utils.sheet_to_json(wb.Sheets[wb.SheetNames[0]]) );
                    obj = eval(str);
                    $(".loading").show();
                    for(var i = 0; i < obj.length; ++i){
                    	obj[i].answerOption = obj[i].answer;
                    	obj[i].answerJudge = obj[i].answer;
                    	obj[i].type == "填空题"?obj[i].answerFill = obj[i].answer.split("#"):obj[i].answerFill = [];
                    	obj[i].answerCloze = obj[i].answer;
                  /*   	post方法不得行,各种问题...改为ajax就阔以了. */
                  
                  		setTimeout((function (i) {
				            return function () {
				                $.ajax({
				                    type:'post',  
					                dataType : "text",
					                async:false,
					                url: "<%=basePath%>question/add.action",
					                data:obj[i],  
				                    success: function (response) {
						                console.log(i);
				                        if(i == obj.length - 1){
				                       	 alert("录入完成");
				                       	 $(".loading").hide();
				                      }
				                    },
				                    failure: function (response) { 
				                    }
				                });
				            }
				        })(i), 10);

	                    <%-- $.ajax({  
	                        type:'post',  
	                        dataType : "text",
	                        async:false,
	                        url: "<%=basePath%>question/add.action",
	                        data:obj[i],  
	                        success:function(data){  
	                        	//alert("题目批量添加成功！");
	                             //debugger;
	                             console.log(i);
	                             if(i == obj.length - 1){
	                            	 alert("录入完成");
	                            	 $(".loading").hide();
	                             }
	                        }  
	                    });   --%>  
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
					alert(fileName)
				

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


<script>
    //JavaScript代码区域
    $(function () {
        $("ul").on("change", ".carselcon",togglePic ); //图片替换
        function togglePic(){
                console.log(this.files[0]);
                var srcs = getObjectURL(this.files[0]);   //获取路径
                $(this).siblings('p').hide();//隐藏+号，文字
                $(this).siblings('img').attr("src", srcs);//展示图片
        }
        $("ul").on("click", ".carselpreview",function () { //图片预览
            var imgdiv=$(this).parent('.previewimgbtn').siblings('.carselconborder').children('.previewimg');
            console.log(imgdiv.attr('src'));
            if(imgdiv.attr('src')){
                //页面层-
                let picHtml=`<img src="`+imgdiv.attr("src")+`" alt="" style="width: 700px;height: 500px" >`;
                layer.open({
                    type: 1,
                    title: false,
                    closeBtn: 0,
                    area: ['700px', '500px'],
                    skin: 'layui-layer-nobg', //没有背景色
                    shadeClose: true,
                    content:picHtml
                });
            }else {
                layer.msg('您还未上传图片，无法预览', {icon: 5});
            }
            //icon= 0-叹号；1-对号；2-×号；3-问号；4-锁号；5-哭脸；6-笑脸
        } );
        $("ul").on("click", ".carseldelete",function () { //图片删除
            console.log($(this).text());
            console.log($(this).parent('.previewimgbtn').parent('li'));
            $(this).parent('.previewimgbtn').parent('li').css("display","none")
        } );

        $('#carouselplus').on('click',function () {  //添加一个轮播图框
            console.log($('.carselhead>span'));
            var numarr=$('.carselhead>span');
            console.log(numarr.length);
            var index;
            if(!$('.carselhead>span').text()){
                index=1;
            }else {
                index=Number($(numarr[numarr.length - 1]).text())+1;
            }
            var imgHtml=`<li>
            <div class="carselhead">第<span>`+index+`</span>张：</div>
            <div class='carselconborder'>
                <input type="file" name="file" accept="image/png, image/jpeg, image/gif, image/jpg"
                       class="carselcon"/>
                <p class="carselplus">+</p>
                <p>点击上传图片</p>
                <img src="" alt="" class="previewimg">
            </div>
            <div class="previewimgbtn">
                <div class="carselcheck carselpreview">预览</div>
                <div class="carselcheck carseldelete">删除</div>
            </div>
        </li>`;
            $('ul.carouselbox').append(imgHtml);
        })
        $('#carouselsubmit').on('click',function () { //提交数据
            var imgarr=$('.carouselbox').find('.previewimg');
            imgarr.each(function (i,v) {
//                console.log(i,$(v).attr('src'));
                if(!$(v).attr('src')){
                    layer.msg('您还有未上传图片框', {icon: 5});
                    return false;
                }
            })
        })

    })



    function getObjectURL(file) {  //获取上传的URL
        var url = null;
        if (window.createObjectURL != undefined) {
            url = window.createObjectURL(file)
        } else if (window.URL != undefined) {
            url = window.URL.createObjectURL(file)
        } else if (window.webkitURL != undefined) {
            url = window.webkitURL.createObjectURL(file)
        }
        return url;
    };


</script>

</body>

</html>
