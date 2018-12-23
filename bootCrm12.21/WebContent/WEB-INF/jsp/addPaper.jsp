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
<link href="<%=basePath%>/css/bootstrap.min.css" rel="stylesheet">

<!-- MetisMenu CSS -->
<link href="<%=basePath%>/css/metisMenu.min.css" rel="stylesheet">

<!-- DataTables CSS -->
<link href="<%=basePath%>/css/dataTables.bootstrap.css" rel="stylesheet">


<!-- Custom Fonts -->
<link href="<%=basePath%>/css/font-awesome.min.css" rel="stylesheet"
	type="text/css">
<link href="<%=basePath%>/css/boot-crm.css" rel="stylesheet"
	type="text/css">
<!-- Custom CSS -->
<link href="<%=basePath%>/css/sb-admin-2.css" rel="stylesheet">
<link href="<%=basePath%>/css/addPaper.css" rel="stylesheet">

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
						<li><a href="${pageContext.request.contextPath }/question/list.action"><i
								class="fa fa-edit fa-fw"></i> 题目管理</a></li>
						<li><a href="${pageContext.request.contextPath }/paper/list.action"  class="active"><i
								class="fa fa-dashboard fa-fw"></i> 试卷管理</a></li>
					</ul>
				</div>
				<!-- /.sidebar-collapse -->
			</div>
		<!-- /.navbar-static-side --> 
		</nav>

		<div id="page-wrapper">
			<div role="tabpanel" class="tab-area tab-col4">
				<ul class="nav nav-tabs" role="tablist">
	                <li role="presentation" class="active step1">
	                    <a href="#createTest1" aria-controls="create1" role="tab" data-toggle="tab">
	                        第一步:创建试卷
	                    </a>
	                </li>
	                <li role="presentation" class="step2">
	                    <a href="#createTest2" aria-controls="create2" role="tab" data-toggle="">
	                        第二步:添加试题并生成试卷
	                    </a>
	                </li>
            	</ul>
			</div>
			<div class="line"></div>
			<div class="tab-content">
                <div role="tabpanel" class="tab-pane active" id="createTest1">
                	<form action="${pageContext.request.contextPath }/paper/manualadd.action"   name="form"  method="post" id="subForm">
                		<div class="infoRow username">
                            <span class="intro title">创建人：&nbsp;&nbsp;&nbsp;&nbsp;</span>
                            <input class = "userName" type="text" name="userName" value="" readonly="readonly"/>
                            <span class="f-style4">*</span>
                        </div>
                        <div class="infoRow userId" style="display:none">
                            <span class="intro title">创建人Id：&nbsp;&nbsp;&nbsp;&nbsp;</span>
                            <input class = "userId" type="text" name="userId" value="" readonly="readonly"/>
                            <span class="f-style4">*</span>
                        </div>
                        <div class="infoRow paperName">
                            <span class="intro title">试卷名称：</span>
                            <input type="text" name="paperName" placeholder="请输入试卷名称" value="" />
                            <span class="f-style4">*</span>
                        </div>
						<div class="infoRow courseName">
							<span class = "intro courseName">科目名称：</span> 
							<select	class="form-control" id="courseName"  name="courseName">
								<option value="">--请选择--</option>
								<c:forEach items="${course}" var="item">
									<option value="${item.courseName}">${item.courseName}</option>					
								</c:forEach>
							</select>
							<span class="f-style4">*</span>
						</div>

                        <div class="infoRow paperType">
                            <span class="intro title">组卷方式：</span>
                            <input type="radio" class="hidden"  name="paperType" id="paperByChapter" value="章节出题和试卷出题" checked="true">
                			<label for="paperByChapter" class="btn btn-border-gray" title="根据章节选题生成一份试卷或者从试卷中选题生成一份试卷">章节出题和试卷出题</label>
                        </div>
                                
                        <input type="text" class="hidden" name="add_style"> 
                        <div class="btnNextStep">
                        	<button type="submit" class="btn btn-primary">下一步</button>
                        </div>
                    </form>
                </div>
            </div>
		</div>
		<!-- /#page-wrapper -->

	</div>
	
	<!-- 客户编辑对话框 -->
	
	<!-- /#wrapper -->

	<!-- jQuery -->
	<script src="<%=basePath%>/js/jquery.min.js"></script>

	<!-- Bootstrap Core JavaScript -->
	<script src="<%=basePath%>/js/bootstrap.min.js"></script>

	<!-- Metis Menu Plugin JavaScript -->
	<script src="<%=basePath%>/js/metisMenu.min.js"></script>

	<!-- DataTables JavaScript -->
	<script src="<%=basePath%>/js/jquery.dataTables.min.js"></script>
	<script src="<%=basePath%>/js/dataTables.bootstrap.min.js"></script>

	<!-- Custom Theme JavaScript -->
	<script src="<%=basePath%>/js/sb-admin-2.js"></script>
	



	
	<script type="text/javascript">
	$(document).ready(function(){
		$.ajax({
		    type: "get",
		    url: "${pageContext.request.contextPath }/login/getUserName.action",
		    dataType: "json",
		  	success: function (result) { 
		  		var activeUser = JSON.stringify(result);//解析json
		  		var user = eval(activeUser);//转成对象
				console.log("user:" + user);
		  		console.log("userId:" + user[0].userid);
				$(".userName").val(user[0].username);
				$(".userId").val(user[0].userid);
		    },
		    failure: function (result) { 
				console.log("请求失败");
			}  
		});
		 
	});
	</script>
	

	
	
</body>

</html>

