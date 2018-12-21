<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="itcast" uri="http://itcast.cn/common/"%>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
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
							class="fa fa-edit fa-fw"></i> 题库管理</a></li>
					<!-- 有paper:query权限才修改链接 ，没有该权限不显示-->
					<shiro:hasPermission name="paper:query">
					<li><a href="${pageContext.request.contextPath }/paper/list.action"  class="active"><i
							class="fa fa-dashboard fa-fw"></i> 试卷管理</a></li>
					</shiro:hasPermission>
				</ul>
			</div>
			<!-- /.sidebar-collapse -->
		</div>
		<!-- /.navbar-static-side --> </nav>

<div id="page-wrapper">
	<div class="row">
		<div class="funcArea">
			<form class="form-inline" role="form">
				<div class = "funcBtn pull-left">
					<!-- 有paper:add权限才修改链接 ，没有该权限不显示-->
					<shiro:hasPermission name="paper:add">
					<button onclick="window.location.href='${pageContext.request.contextPath }/paper/add.action'" class="btn btn-default" type="button">
						创建试卷
					</button>
					</shiro:hasPermission>
				</div>
				<div class = "search pull-right">
					<div class="input-group search">
						<input type="text" id="searchbox" class="form-control">
						<span class="input-group-btn">
							<button class="btn btn-default navbar-search-button" type="button">
								<i class="fa fa-search"></i>
							</button>
						</span>
					</div><!-- /input-group -->
					<p class="form-control-static" data-toggle="modal" data-target="#questionEditDialog" onclick="editCustomer(1)">
			        	高级搜索
			        	<b class="caret"></b>
			        </p>
				</div>
			</form>
		</div>
		<!-- /.col-lg-12 -->
	</div>
	<!-- /.row -->
			
	<div class="panel panel-default" style="display: none;">
		<div class="panel-body">
			<form class="form-inline" action="${pageContext.request.contextPath }/question/list.action" method="get" >
			<div class="form-group">
					<label for="questionFrom">题型</label> 
					<select  id="questionType" name="type" onchange="show_sub()"> 
						<option value="0">--请选择--</option>
						<option value="单选题">单选题</option>
						<option value="多选题">多选题</option>
						<option value="判断题">判断题</option>
						<option value="填空题">填空题</option>
						<option value="问答题">问答题</option>
						<option value="简述题">简述题</option>
						<option value="名词解释">名词解释</option>		    
 					</select> 
			</div>
			<button type="submit" class="btn btn-primary">查询</button>
		</form>			
		</div>
	</div>	
	
					
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-heading">试卷信息列表</div>
						<!-- /.panel-heading -->
						<table class="table table-bordered table-striped table-hover" id = "quesTable">
							<thead>
								<tr>
									<th><input type = "checkbox" class = "paperItemTotal" value = "" name = "papers"/></th>
									<th>试卷标题</th>
									<th>科目</th>
									<th>出题时间</th>
									<th>出题人</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${page.rows}" var="row">
									<tr>
										<td><input type = "checkbox" class = "paperItem" value = "" name = "paper"/></td>
										<td>${row.title}</td>
										<td>${row.courseName}</td>
										<td>${row.joinTime}</td>
										<td>${row.userId}</td>
										<td>
											<a onclick="preview('${row.questionSet}')"><i class="fa fa-eye fa-fw"></i></a> 
											<a onclick="deletePaper(${row.id})"><i class="fa fa-trash" aria-hidden="true"></i></a>
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
		function editCustomer(id) {
			$.ajax({
				type:"get",
				url:"./customer/edit.action",
				data:{"id":id},
				success:function(data) {
					$("#edit_cust_id").val(data.cust_id);
					$("#edit_customerName").val(data.cust_name);
					$("#edit_customerFrom").val(data.cust_source)
					$("#edit_custIndustry").val(data.cust_industry)
					$("#edit_custLevel").val(data.cust_level)
					$("#edit_linkMan").val(data.cust_linkman);
					$("#edit_phone").val(data.cust_phone);
					$("#edit_mobile").val(data.cust_mobile);
					$("#edit_zipcode").val(data.cust_zipcode);
					$("#edit_address").val(data.cust_address);
					
				}
			});
		}
		function updateCustomer() {
			$.post("./customer/update.action",$("#edit_customer_form").serialize(),function(data){
				alert("客户信息更新成功！");
				window.location.reload();
			});
		}
		
		function deleteCustomer(id) {
			if(confirm('确实要删除该客户吗?')) {
				$.post("./customer/delete.action",{"id":id},function(data){
					alert("客户删除更新成功！");
					window.location.reload();
				});
			}
		}
	</script>

<!-- 实现题目显示的每一列拉伸 -->
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
	
	
	<!-- jquery快速实现全局搜索表格内容 -->
	<script type = "text/javascript">
		$(function () {
		$("#searchbox").keyup(function () { 
			$("table tbody tr").hide() .filter(":contains('"+($(this).val())+"')").show();//filter和contains共同来实现了这个功能。 
			}).keyup(); 
		}); 
	</script>
		

<!--   批量删除与编辑题目 -->
	<script type = "text/javascript">
		function deleteQuestion(id){
			if(confirm('确实要删除该题目吗?')) {
				$.post("./question/delete.action",{"id":id},function(data){
					alert("题目删除成功！");
					window.location.reload();
				});
			}
		}
		$("#batchDelete").click(function(e){
			var questionItems = $(".questionItem");
			var cnt = 0;
			var idArray = [];
			for(var i = 0; i < questionItems.length; ++i){
				if($(questionItems[i]).prop("checked") == true){
					var id = parseInt($(questionItems[i]).val());
					idArray.push(id);
					++cnt;
				}
			}
			if(cnt == 0){
				alert("请选择题目！");
			}
			else if(confirm('确实要删除已选中的' + cnt + '道题目吗?')) {
				for(var i = 0; i < idArray.length; ++i){
					$.post("./question/delete.action",{"id":idArray[i]},function(data){
					});
				}
				alert("删除成功");
				window.location.reload();
			}
		});
		$("#batchEdit").click(function(e){
			var questionItems = $(".questionItem");
			var cnt = 0;
			var idArray = [];
			for(var i = 0; i < questionItems.length; ++i){
				if($(questionItems[i]).prop("checked") == true){
					var id = parseInt($(questionItems[i]).val());
					idArray.push(id);
					++cnt;
				}
			}
			if(cnt == 0){
				alert("请选择题目！");
			}
			else
			{
				var str = "./question/batchEdit.action?qids[]=" + idArray[0];
				for(var i = 1; i < idArray.length; ++i){
					var tmp = "&qids[]=" + idArray[i];
					str += tmp;
				}
				alert(str);
				window.location.href = str;
				window.open(str);//新窗口打开预览界面
			}
		})
	</script>
	
	<!-- 预览试卷 -->
	<script type="text/javascript">
	function preview(questionSet){
		console.log(questionSet);
		strQids = questionSet.split("#");
		qids = [];
		for(var i = 0; i < strQids.length; ++i){
			qids.push(parseInt(strQids[i]));
		}
		var str = "<%=basePath%>paper/preview.action?qids[]=" + qids[0];
		for(var i = 1; i < qids.length; ++i){
			var tmp = "&qids[]=" + qids[i];
			str += tmp;
		}
		console.log(str);
		//window.location.href = str;//原页面
		window.open(str);//新窗口打开预览界面
	}
	
	</script>
	
	<!-- 删除试卷 -->
	<script type="text/javascript">
	function deletePaper(id){
		if(confirm('确实要删除该试卷吗?')) {
			$.post("<%=basePath%>/paper/delete.action",{"id":id},function(data){
				alert("试卷删除成功！");
				window.location.reload();
			});
		}
	}
	</script>
</body>

</html>