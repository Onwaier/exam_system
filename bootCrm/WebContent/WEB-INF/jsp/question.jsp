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
		
			<form class="navbar-form navbar-left">
				<button class="btn btn-default" type="button">
						添加试题
				</button>
				<button class="btn btn-default" type="button">
						题库查重
				</button>
			</form>
			
			
			
	        <form class="navbar-form navbar-right navbar-search-form" role="form">
	        	<div class="input-group">
					<input type="text" class="form-control">
					<span class="input-group-btn">
						<button class="btn btn-default navbar-search-button" type="button">
							<i class="fa fa-search"></i>
						</button>
					</span>
				</div><!-- /input-group -->
	            
	        </form>
	        <p class="navbar-text navbar-right" data-toggle="modal" data-target="#questionEditDialog" onclick="editCustomer(1)">
	        	高级搜索
	        	<b class="caret"></b>
	        </p>
	        
    	</div>
		 
		<!-- /.navbar-top-links -->

		<div class="navbar-default sidebar" role="navigation" id = "question-sidebar">
			<div class="sidebar-nav navbar-collapse">
				<ul class="nav" id="side-menu">
					<!-- <li class="sidebar-search">
						<div class="input-group custom-search-form">
							<input type="text" class="form-control" placeholder="查询内容...">
							<span class="input-group-btn">
								<button class="btn btn-default" type="button">
									<i class="fa fa-search" style="padding: 3px 0 3px 0;"></i>
								</button>
							</span>
						</div> /input-group
					</li> -->
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
			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">题库管理</h1>
				</div>
				<!-- /.col-lg-12 -->
			</div>
			<!-- /.row -->
			
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-heading">题目信息列表</div>
						<!-- /.panel-heading -->
						<table class="table table-bordered table-striped table-hover" id = "quesTable">
							<thead>
								<tr>
								    <th>ID</th>
									<th>题目类型</th>
									<th>科目</th>
									<th>章节</th>
									<th>知识点</th>
									<th>题干</th>
									<th>难度</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${page.rows}" var="row">
									<tr>
										<td>${row.qid}</td>
										<td>${row.type}</td>
										<td>${row.courseName}</td>
										<td>${row.chapter}</td>
										<td>知识点</td>
										<td>${row.subject}</td>
										<td>${row.difficulty}</td>
										<td>
											
											<a href="#" data-toggle="modal" data-target="#questionEditDialog" onclick="editCustomer(${row.qid})"><i class="fa fa-edit fa-fw"></i></a>
											<a href="#" onclick="deleteQuestion(${row.qid})"><i class="fa fa-trash" aria-hidden="true"></i></a>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<div class="col-md-12 text-right">
							<itcast:page url="${pageContext.request.contextPath }/question/list.action" />
						</div>
						<!-- /.panel-body -->
					</div>
					<!-- /.panel -->
				</div>
				<!-- /.col-lg-12 -->
			</div>
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

	<script type = "text/javascript">
		var tTD; //用来存储当前更改宽度的Table Cell,避免快速移动鼠标的问题 
		var table = document.getElementById("quesTable"); 
		for (j = 0; j < table.rows[0].cells.length; j++) { 
			table.rows[0].cells[j].onmousedown = function () { 
				//记录单元格 
				tTD = this; 
				if (event.offsetX > tTD.offsetWidth - 10) { 
				tTD.mouseDown = true; 
				tTD.oldX = event.x; 
				tTD.oldWidth = tTD.offsetWidth; 
				} 
			}; 
			table.rows[0].cells[j].onmouseup = function () { 
				//结束宽度调整 
				if (tTD == undefined) tTD = this; 
				tTD.mouseDown = false; 
				tTD.style.cursor = 'default'; 
				}; 
			table.rows[0].cells[j].onmousemove = function () { 
				//更改鼠标样式 
				if (event.offsetX > this.offsetWidth - 10) 
				this.style.cursor = 'col-resize'; 
				else 
				this.style.cursor = 'default'; 
				//取出暂存的Table Cell 
				if (tTD == undefined) tTD = this; 
				//调整宽度 
				if (tTD.mouseDown != null && tTD.mouseDown == true) { 
					tTD.style.cursor = 'default'; 
					if (tTD.oldWidth + (event.x - tTD.oldX)>0) 
					tTD.width = tTD.oldWidth + (event.x - tTD.oldX); 
					//调整列宽 
					tTD.style.width = tTD.width; 
					tTD.style.cursor = 'col-resize'; 
					//调整该列中的每个Cell 
					table = tTD; while (table.tagName != 'TABLE') table = table.parentElement; 
					for (j = 0; j < table.rows.length; j++) { 
					table.rows[j].cells[tTD.cellIndex].width = tTD.width; 
					}
				} 
			}; 
		} 

	</script>
</body>

</html>
