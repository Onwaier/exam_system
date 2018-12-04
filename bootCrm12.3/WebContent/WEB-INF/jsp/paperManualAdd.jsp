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
	
<!-- bootstrap-tree CSS -->
<link href="<%=basePath%>/css/bootstrap-treeview.css" rel="stylesheet" type="text/css">
<!-- Custom CSS -->
<link href="<%=basePath%>/css/sb-admin-2.css" rel="stylesheet">
<link href="<%=basePath%>/css/paperManualAdd.css" rel="stylesheet">

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
						<li><a href="${pageContext.request.contextPath }/customer/list.action"  class="active"><i
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
	                <li role="presentation" class="step1">
	                    <a href="./addPaper.html" class = "step1">
	                        第一步:创建试卷
	                    </a>
	                </li>
	                <li role="presentation" class="active step2">
	                    <a href="#createTest2" aria-controls="create2" role="tab" data-toggle="tab">
	                        第二步:添加试题
	                    </a>
	                </li>
	                <li role="presentation" class="step3">
	                    <a href="#createTest3" aria-controls="create3" role="tab" data-toggle="tab">
	                        第三步:保存生成试卷
	                    </a>
	                </li>
            	</ul>
			</div>
			<div class="line"></div>
			<div class="tab-content">
                <div role="tabpanel" class="tab-pane active" id="createTest1" style = "display: none;">
                	<form action="" name="form" method="post" id="subForm">
                        <div class="infoRow paperName">
                            <span class="intro title">试卷名称：</span>
                            <input type="text" name="paperName" placeholder="请输入试卷名称" value="" />
                            <span class="f-style4">*</span>
                        </div>

                        <div class="infoRow courseName">
                            <span class="intro title">科目：&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</span>
                            <input type="text" name="courseName" placeholder="请输入科目名称" value="" />
                            <span class="f-style4">*</span>
                        </div>

                        <div class="infoRow paperType">
                            <span class="intro title">组卷方式：</span>
                            <input type="radio" class="hidden"  name="paperType" id="paperByChapter" value="章节出题" checked="true">
                			<label for="paperByChapter" class="btn btn-border-gray" title="勾选想出的题生成一份试卷">章节出题</label>
                            <input type="radio" class="hidden"  name="paperType" id="paperByPapers" value="试卷出题">
                            <label for="paperByPapers" class="btn btn-border-gray" title="勾选想出的题生成一份试卷">试卷出题</label>
                            <input type="radio" class="hidden"  name="paperType" id="paperBySmart" value="智能出题">
                            <label for="paperBySmart" class="btn btn-border-gray"title="勾选想出的题生成一份试卷" >
                            智能出题</label>  
                        </div>
                                
                        <input type="text" class="hidden" name="add_style"> 
                        <div class="btnNextStep">
                            <button  type="button" class="btn btn-primary">下一步</button>
                        </div>
                    </form>
                </div>
                <div role="tabpanel" class="tab-pane active" id="createTest2" style = "display: block;">
                	<div class="row">
                		<div class="chapterList col-sm-3">
	                		<h3 class="intro title">章节</h3>
	                		<HR style="FILTER: alpha(opacity=100,finishopacity=0,style=3)" width="80%" color=#987cb9 SIZE=3>
	                		<div id="knowpointTree"></div>
                		</div>
	                	<div class="paperContent col-sm-6">
	                		<div class="knowPoint">
	                			aafadfadfadfafd
	                		</div>
	                		<div class = "paper">
	                			
	                		</div>
	                	</div>
	                	<div class="paperInfo col-sm-3">
	                		afafaf

	                		afafafafafaf
	                		afafaf
	                		afafaf
	                		afafaf
	                		afafaf
	                		afafaf

	                		afafaf
	                	</div>
                	</div>
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
	
<!-- 	bootstrap-treeview JS -->
	<script src="<%=basePath%>/js/bootstrap-treeview.js"></script>
	
	
<!-- 	页面加载时从后台获取数据 -->
	<script type="text/javascript">
	
	$(document).ready(function(){
		var defaultData;
		$.ajax({
		    type: "post",
		    url: "${pageContext.request.contextPath }/paper/knowpointlist.action",
		    data:{"courseId":1},
		    dataType: "json",
		  	success: function (result) { 
			console.log(result);
		    defaultData=result;
		    $('#knowpointTree').treeview({
			    data: defaultData,
			    highlightSelected : false,// 选中项不高亮，避免和上述制定的颜色变化规则冲突
			    multiSelect : false,// 不允许多选，因为我们要通过check框来控制
			    showCheckbox : true,// 展示checkbox
			    onNodeChecked : nodeChecked,
				onNodeUnchecked : nodeUnchecked, 
			    }).treeview('collapseAll', {// 节点展开
			    	    silent : false
			     });
		    },
		    failure: function (result) { 
				console.log("请求失败");
			}  
		});
		 
	});
	</script>
		
	<script type="text/javascript">
	var nodeCheckedSilent = false;
	function nodeChecked (event, node){
	    if(nodeCheckedSilent){
	        return;
	    }
	    nodeCheckedSilent = true;
	    checkAllParent(node);
	    checkAllSon(node);
	    nodeCheckedSilent = false;
	}
	 
	var nodeUncheckedSilent = false;
	function nodeUnchecked  (event, node){
	    if(nodeUncheckedSilent)
	        return;
	    nodeUncheckedSilent = true;
	    uncheckAllParent(node);
	    uncheckAllSon(node);
	    nodeUncheckedSilent = false;
	}
	 
	//选中全部父节点
	function checkAllParent(node){
	    $('#knowpointTree').treeview('checkNode',node.nodeId,{silent:true});
	    var parentNode = $('#knowpointTree').treeview('getParent',node.nodeId);
	    if(!("nodeId" in parentNode)){
	        return;
	    }else{
	        checkAllParent(parentNode);
	    }
	}
	//取消全部父节点
	function uncheckAllParent(node){
	    $('#knowpointTree').treeview('uncheckNode',node.nodeId,{silent:true});
	    var siblings = $('#knowpointTree').treeview('getSiblings', node.nodeId);
	    var parentNode = $('#knowpointTree').treeview('getParent',node.nodeId);
	    if(!("nodeId" in parentNode)) {
	        return;
	    }
	    var isAllUnchecked = true;  //是否全部没选中
	    for(var i in siblings){
	        if(siblings[i].state.checked){
	            isAllUnchecked=false;
	            break;
	        }
	    }
	    if(isAllUnchecked){
	        uncheckAllParent(parentNode);
	    }
	 
	}
	 
	//级联选中所有子节点
	function checkAllSon(node){
	    $('#knowpointTree').treeview('checkNode',node.nodeId,{silent:true});
	    if(node.nodes!=null&&node.nodes.length>0){
	        for(var i in node.nodes){
	            checkAllSon(node.nodes[i]);
	        }
	    }
	}
	//级联取消所有子节点
	function uncheckAllSon(node){
	    $('#knowpointTree').treeview('uncheckNode',node.nodeId,{silent:true});
	    if(node.nodes!=null&&node.nodes.length>0){
	        for(var i in node.nodes){
	            uncheckAllSon(node.nodes[i]);
	        }
	    }
	}

	</script>


	
	
	
		


	

	
	
</body>

</html>
