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
	                		<div class = "paper">
	                			<h3><input class="edit-paper-name form-control" type="text" name="edit_paper_name" value='${paperName}' placeholder="点击输入试卷名称"></h3>
                                <p class="emptyTip">当前试卷还是空空如也，点击下方添加新题型！</p>
                                <div class="group_main"></div>
                                <div class="questionTypeManage">
                                	<select	class="form-control" id="questionType" name="type">
										<option value="0" num = "0">--请选择--</option>
										<option value="单选题" num = "1">单选题</option>
										<option value="多选题" num = "2">多选题</option>
										<option value="判断题" num = "3">判断题</option>
										<option value="填空题" num = "4">填空题</option>
										<option value="问答题" num = "5">问答题</option>
										<option value="简述题" num = "6">简述题</option>
										<option value="名词解释" num = "7">名词解释</option>	
									</select>
                                </div>
	                		</div>
	                	</div>
	                	
	                	<div class="paperInfo col-sm-3">
	                		<div class="preview">
	                			<button type="button" class="btn btn-primary" id="previewBtn" onclick = "previewPaper()"><i class="fa fa-eye fa-fw"></i>预览</button>
	                		</div>
	                		<a href="#" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#showPaperList" onclick="showPaper()">试卷选题</a>
                
	                		<div class="total">
	                			<p>总题数：<span class="test_total">0</span>题</p>
	                		</div>
	                		<div class="right_group_main"></div>
	                		<div class="btnNextStep">
                            	<button  type="button" class="btn btn-primary" id="paperGenerateBtn" onclick = "paperGenerate()">下一步</button>
                        	</div>
	                	</div>
                	</div>
                </div>
            </div>
		</div>
		<!-- /#page-wrapper -->

	</div>
	
	
	
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
	

	<!-- 选择试题 -->
	<div class="modal fade" id="questionChooseDialog" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">选择试题</h4>
				</div>
				
				<div class="modal-body">
					<form class="form-horizontal" id="choose_question_form">
						<span class="intro difficulty">难度</span>
						<select	class="form-control" name="difficulty">
							<option value="0">--请选择--</option>
							<option value="简单">简单</option>
							<option value="中等">中等</option>
							<option value="困难">困难</option>
						</select>   
						<button onclick= ""  type="button" class="btn btn-primary">查询</button>
						<div class="row">
							<div class="col-lg-12">
								<div class="panel panel-default">
									<div class="panel-heading">题目信息列表</div>
									<!-- /.panel-heading -->
									<table class="table table-bordered table-striped table-hover" id = "quesTable">

									</table>
										
									
								</div>
								<br/>
								
							</div>
						</div>		
					</form>	
					<div class="pagination-nick"></div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" id = "shutQuestionChooseDialog" class="btn btn-primary">保存修改</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 显示所有试卷 -->
	<div class="modal fade" id="showPaperList" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">选择试卷</h4>
				</div>
				
				<div class="modal-body">
					<form class="form-horizontal" id="choose_question_form">
						<span class="intro difficulty">难度</span>
						<select	class="form-control" name="difficulty">
							<option value="0">--请选择--</option>
							<option value="简单">简单</option>
							<option value="中等">中等</option>
							<option value="困难">困难</option>
						</select>   
						<button onclick= ""  type="button" class="btn btn-primary">查询</button>
						<div class="row">
							<div class="col-lg-12">
								<div class="panel panel-default">
									<div class="panel-heading">试卷信息列表</div>
									<!-- /.panel-heading -->
									<table class="table table-bordered table-striped table-hover" id = "paperTable">

									</table>
										
									
								</div>
								<br/>
								
							</div>
						</div>		
					</form>	
					<div class="pagination-nick"></div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" id = "shutQuestionChooseDialog" class="btn btn-primary" onclick="choose()">保存修改</button>
				</div>
			</div>
		</div>
	</div>
	
<!-- 从已有的试卷中选题试题 -->
<div class="modal fade" id="selectQuestionFromPaper" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">选择试题</h4>
				</div>
				
				<div class="modal-body">
					<form class="form-horizontal" id="choose_question_form">
						<div id="paperQuestionList">
							<div class="group-main">
								<div class="group_simple" num="1">
									<div class="questions-title">
										<input type = "checkbox" class = "questionTotal" value = "" name = "questionTotal"/>
										<span>单选题(共<span class = "quesNum">0</span>题)</span>
									</div>
									<div class="questions-group">
										<div class="group_questionShow">
								        </div>  
									</div>  
				            	</div>
							</div>
						</div>
					</form>	
<!-- 					<div class="pagination-nick"></div> -->
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" id = "shutQuestionChooseDialog" class="btn btn-primary" onclick="choose()">保存修改</button>
				</div>
			</div>
		</div>
	</div>


<!-- 章节知识点展开/收缩 -->
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
	
	
	<!-- 章节知识点树当前选中结点 -->
	<script type="text/javascript">
			function checkNodes(){
				var nodeIds = $('#knowpointTree').treeview('getChecked');
				var res = {};
				var person={fname:"Bill",lname:"Gates",age:56}; 
				for(var i = 0; i < nodeIds.length; ++i){
					var parentNode = $('#knowpointTree').treeview('getParent', nodeIds[i]);
					if(typeof parentNode.text != "function"){
						parentText = parentNode.text;
						childText = nodeIds[i].text;
						if(typeof res[parentText] == "undefined"){
							res[parentText] = [];
							res[parentText].push(childText);
						}
						else{
							res[parentText].push(childText);
						}
					}
				}
				console.log(res);
				return res
			}
	</script>
		
<!-- 	页面加载时从后台获取章节知识点列表数据 -->
	<script type="text/javascript">
	
	$(document).ready(function(){
		var defaultData;
		$.ajax({
		    type: "post",
		    url: "${pageContext.request.contextPath }/paper/knowpointlist.action",
		    data:{"courseId": ${courseId} },
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

<!-- 添加试题类型 -->		
	<script type = "text/javascript">
		$("#questionType").change(function(e){
			var typeDict = {"0":0, "单选题":1, "多选题":2, "判断题":3, "填空题":4, "问答题":5, "简述题":6, "名词解释":7};
			var resNum = typeDict[$(this).val()];
			var mainHtml = 
				'<div class="group_simple" num="' + resNum + '">'+
			'            <div class="questions-group group_title">'+
			'                <h4>'+
			'                    <input type="text" class="" name="test_tittle" value="' + $(this).val() + '">'+
			'                </h4>'+
			'            '+
			'	            <div class="extract-box-tit">'+
			'	                <span class="questionTypeText">' + $(this).val() + '</span>'+
			'	                <div class="extract-box-btnDiv">'+
			'                        <a class="btn btn-blue-border2 selQuestionLink" data-toggle="modal" data-target="#questionChooseDialog"  onclick = "addQuestion(this)">'+
			'                        	<span>选择试题</span>'+
			'                        </a>'+
			'	                </div>'+
			'	            </div>'+
			'        	</div>'+
			'            <div class="group_questionShow">'+
			'            </div>    '+
			'</div>';
			var rightHtml = '<div onclick="" class="item right_group_simple">'+
			'	                			<p></p>'+
			'								<h3 class="test_tittle">' + $(this).val() + '</h3>'+
			'								<p></p>'+
			'								<p class="right_p">'+
			'									共<span class="test_num">0</span>题</p>'+
			'								<p></p>'+
			'								<p class="test_icon_a">'+
			'									<a class="m-content-trash glyphicon glyphicon-trash" aria-hidden="true" title="移除" onclick="removeSome(this)"></a>'+
			'									<a class="m-content-up glyphicon glyphicon-menu-up" aria-hidden="true" title="上移" onclick="moveUpSome(this)"></a>'+
			'									<a class="m-content-down glyphicon glyphicon-menu-down" aria-hidden="true" title="下移" onclick="moveDownSome(this)"></a>'+
			'								</p>'+
			'							</div>';
			if($(".paper").find(".group_main").html() == ""){
				$(".paper").find(".emptyTip").hide();
				$(".paper").find(".group_main").append(mainHtml);
				$(".right_group_main").append(rightHtml);
			}
			else{
				var groupSimples = $(".paper").find(".group_simple");
				var rightGroupSimples = $(".right_group_simple");
				var i = 0, tmpNum = 0;
				console.log(resNum);
				var isExist = false;
				for(; i < groupSimples.length; ++i){
					tmpNum = parseInt($(groupSimples[i]).attr("num"));
					console.log(tmpNum);
					if(tmpNum == resNum){
						isExist = true;
						break;
					}
					else if(tmpNum > resNum){
						break;
					}
				}
				if(isExist){
					alert("该题型已经存在,请在对应的位置添加题目");
				}
				else{
					if(i < groupSimples.length){
						$(".paper").find(".emptyTip").hide();
						$(groupSimples[i]).before(mainHtml);
						$(rightGroupSimples[i]).before(rightHtml);
					}
					else{
						$(".paper").find(".emptyTip").hide();
						$(groupSimples[i - 1]).after(mainHtml);
						$(rightGroupSimples[i - 1]).after(rightHtml);
					}
				}
			}
		});
	</script>
	
<!-- 显示所有试卷-->
	<script type="text/javascript">
		var Data;
		var quesData;
		function showPaper(){
			alert('aaa');
			$.ajax({
				type:"post",
				url:"<%=basePath%>paper/showPaper.action",
				data: {"courseId":${courseId}},
				dataType: "json",
				async: false, //同步传输，并添加返回值，返回值应为已定义的全局变量 
				success:function(data) {
					alert(data)
					Data = data
					
//			        定义一个分页方法，可多次调用
			        function paginationNick(opt){
//			            参数设置
			            var pager={
			                paginationBox:'',//分页容器-- 必填
			                mainBox:'',//内容盒子--必填
			                numBtnBox:'',//数字按钮盒子-- 必填
			                btnBox:'',//按钮盒子 --必填
			                ipt:'',//input class-- 必填
			                goBtn:'',//go btn class --必填
			                currentBtn:'',//当前按钮class name --必填
			                pageCount:10,//每页显示几条数据
			                numBtnCount:3,//当前页左右两边各多少个数字按钮
			                currentPage:0,//当前页码data-page，首屏默认值
			                maxCount:0,//ajax请求数据分成的最大页码
			                data:[]//ajax请求的数据
			            };
			            pager = $.extend(pager,opt);
			            //请求数据页面跳转方法
			            function goPage(btn){
			                //obj为ajax请求数据
			                
			                var obj = data

			                //将展示的数据赋值给pager.data  (array)
			                 // pager.data=obj.value;
			                pager.data=obj[0].rows;
			                //设置ajax请求数据分成的最大页码
// 			                alert(pager.data.length)

			                pager.maxCount=pager.data.length % pager.pageCount ? parseInt(pager.data.length / pager.pageCount) +1 :
			                    pager.data.length / pager.pageCount;

//			                设置当前页码
			                if(!isNaN(btn)){//数字按钮
			                    pager.currentPage=parseInt(btn);
			                }else{
			                    switch(btn){
			                        case 'first':
			                            pager.currentPage=0;
			                            break;
			                        case 'prev':
			                            if(pager.currentPage>0){
			                                --pager.currentPage;
			                            }
			                            break;
			                        case 'next':
			                            if(pager.currentPage+1<pager.maxCount){
			                                ++pager.currentPage;
			                            }
			                            break;
			                        case 'last':
			                            pager.currentPage=pager.maxCount-1;
			                            break;
			                    }
			                }
			                //创建数字按钮
			                createNumBtn(pager.currentPage);
			                //赋值给页码跳转输入框的value，表示当前页码
			                $('.'+pager.btnBox+' .'+pager.ipt).val(pager.currentPage+1);
//			              内容区填充数据
			                var arr=[],str='';
			                arr=pager.data.slice(pager.pageCount*pager.currentPage,
			                        pager.data.length - pager.pageCount*(pager.currentPage+1) > -1 ?
			                        pager.pageCount*(pager.currentPage+1) : pager.data.length);

							var start = pager.pageCount*pager.currentPage
			                var end = pager.data.length - pager.pageCount*(pager.currentPage+1) > -1 ?
			                        pager.pageCount*(pager.currentPage+1) : pager.data.length
// 			                alert(start)
// 			                alert(end)  
			                var s = '' 
			                var Html = '										<thead>'+
			                '											<tr>'+
			                '												<th><input type = "checkbox" class = "paperItemTotal" value = "" name = "paperTotal"/></th>'+
			                '												<th>试卷标题</th>'+
			                '												<th>科目</th>'+
			                '												<th>出题时间</th>'+
			                '												<th>出题人</th>'+
			              	'												<th>操作</th>'+
			                '											</tr>'+
			                '										</thead>';
			                $("#paperTable").html(Html)
			                for(var i = start; i < end; i++) {
			                	var set = String(pager.data[i].questionSet);
			                    s += "<tr><td>" + '<input type = "checkbox" class = "paperItem" value = "' + i +'" name = "paper"/>' + "</td><td>" + pager.data[i].title + "</td><td>" + pager.data[i].courseName + "</td><td>" +
			                    pager.data[i].joinTime + "</td><td>" +  pager.data[i].userId + "</td>" +
			                    '<td>'+
			                    '	<a data-toggle="modal" data-target="#selectQuestionFromPaper" onclick="paperPreview(\'' + set + '\')"><i class="fa fa-eye fa-fw"></i></a> '+
			                    '</td></tr>';
			                    console.log(i);
			                    // $("#quesTable").append(s);
			                }
			                $("#paperTable").append(s);
			                
// 			                arr.forEach(function(v){
// 			                    str+='<div>'+v+'</div>';
// 			                });
// 			                $('.'+pager.mainBox).html(s);
			            }
			            //创建非数字按钮和数据内容区
			            function createOtherBtn(){
			            	$('.'+pager.paginationBox).html('<div class="'+pager.btnBox+'"><button data-page="first" class="first-btn">首页</button><button data-page="prev" class="prev-btn">上一页</button><span class="'+pager.numBtnBox+'"></span><button data-page="next" class="next-btn">下一页</button><input type="text" placeholder="请输入页码" class="'+pager.ipt+'"><button class="'+pager.goBtn+'">确定go</button><button data-page="last" class="last-btn">尾页</button></div><div class="'+pager.mainBox+'"></div>');
			                //ipt value变化并赋值给go btn data-page
			                $('.'+pager.btnBox+' .'+pager.ipt).change(function(){
			                    if(!isNaN($(this).val())){//是数字
			                        if($(this).val() > pager.maxCount){//限制value最大值，跳转尾页
			                            $(this).val(pager.maxCount);
			                        }
			                        if($(this).val()<1){//限制value最小值，跳转首页
			                            $(this).val(1);
			                        }
			                    }else{//非数字清空value
			                        $(this).val('');
			                    }
			                    $('.'+pager.btnBox+' .'+pager.goBtn).attr('data-page',$(this).val() ? $(this).val()-1 : '');
			                });
			                //每个btn绑定请求数据页面跳转方法
			                $('.'+pager.btnBox+' button').each(function(i,v){
			                    $(this).click(function(){
			                        //有值且不是上一次的页码时才调用
			                        if(v.getAttribute('data-page') && v.getAttribute('data-page') != pager.currentPage){
			                            goPage(v.getAttribute('data-page'));
			                        }
			                    });
			                });
			            }
			            //创建数字按钮
			            function createNumBtn(page){
			                //page是页面index从0开始，这里的page加减一要注意
			                var str='';
			                if(pager.maxCount>pager.numBtnCount*2){//若最大页码数大于等于固定数字按钮总数（pager.numBtnCount*2+1）时
			                    //此页左边右边各pager.numBtnCount个数字按钮
			                    if(page-pager.numBtnCount>-1){//此页左边有pager.numBtnCount页 page页码从0开始
			                        for(var m=pager.numBtnCount;m>0;m--){
			                            str+='<button data-page="'+(page-m)+'">'+(page-m+1)+'</button>';
			                        }
			                    }else{
			                        for(var k=0;k<page;k++){
			                            str+='<button data-page="'+k+'">'+(k+1)+'</button>';
			                        }
			                    }
			                    str+='<button data-page="'+page+'" class="'+pager.currentBtn+'" disabled="disabled">'+(page+1)+'</button>';//此页
			                    if(pager.maxCount-page>3){//此页右边有pager.numBtnCount页 page页码从0开始
			                        for(var j=1;j<pager.numBtnCount+1;j++){
			                            str+='<button data-page="'+(page+j)+'">'+(page+j+1)+'</button>';
			                        }
			                    }else{
			                        for(var i=page+1;i<pager.maxCount;i++){
			                            str+='<button data-page="'+i+'">'+(i+1)+'</button>';
			                        }
			                    }
			                    /*数字按钮总数小于固定的数字按钮总数pager.numBtnCount*2+1时，
			                     这个分支，可以省略*/
			                    if(str.match(/<\/button>/ig).length<pager.numBtnCount*2+1){
			                        str='';
			                        if(page<pager.numBtnCount){//此页左边页码少于固定按钮数时
			                            for(var n=0;n<page;n++){//此页左边
			                                str+='<button data-page="'+n+'">'+(n+1)+'</button>';
			                            }
			                            str+='<button data-page="'+page+'" class="'+pager.currentBtn+'" disabled="disabled">'+(page+1)+'</button>';//此页
			                            for(var x=1;x<pager.numBtnCount*2+1-page;x++){//此页右边
			                                str+='<button data-page="'+(page+x)+'">'+(page+x+1)+'</button>';
			                            }
			                        }
			                        if(pager.maxCount-page-1<pager.numBtnCount){
			                            for(var y=pager.numBtnCount*2-(pager.maxCount-page-1);y>0;y--){//此页左边
			                                str+='<button data-page="'+(page-y)+'">'+(page-y+1)+'</button>';
			                            }
			                            str+='<button data-page="'+page+'" class="'+pager.currentBtn+'" disabled="disabled">'+(page+1)+'</button>';//此页
			                            for(var z=page+1;z<pager.maxCount;z++){//此页右边
			                                str+='<button data-page="'+z+'">'+(z+1)+'</button>';
			                            }
			                        }
			                    }
			                }else{
			                    str='';
			                    for(var n=0;n<page;n++){//此页左边
			                        str+='<button data-page="'+n+'">'+(n+1)+'</button>';
			                    }
			                    str+='<button data-page="'+page+'" class="'+pager.currentBtn+'" disabled="disabled">'+(page+1)+'</button>';//此页
			                    for(var x=1;x<pager.maxCount-page;x++){//此页右边
			                        str+='<button data-page="'+(page+x)+'">'+(page+x+1)+'</button>';
			                    }
			                }

			                $('.'+pager.numBtnBox).html(str);

			                //每个btn绑定请求数据页面跳转方法
			                $('.'+pager.numBtnBox+' button').each(function(i,v){
			                    $(this).click(function(){
			                        goPage(v.getAttribute('data-page'));
			                    });
			                });

			                //按钮禁用
			                $('.'+pager.btnBox+' button').not('.'+pager.currentBtn).attr('disabled',false);
			                if(!page){//首页时
			                    $('.'+pager.btnBox+' .first-btn').attr('disabled',true);
			                    $('.'+pager.btnBox+' .prev-btn').attr('disabled','disabled');
			                }
			                if(page==pager.maxCount-1){//尾页时
			                    $('.'+pager.btnBox+' .last-btn').attr('disabled',true);
			                    $('.'+pager.btnBox+' .next-btn').attr('disabled',true);
			                }
			            }

			            //首屏加载
			            createOtherBtn();//首屏加载一次非数字按钮即可
			            goPage();//请求数据页面跳转满足条件按钮点击都执行，首屏默认跳转到currentPage
			        }
			        //调用
			        paginationNick({
			            paginationBox:'pagination-nick',//分页容器--必填
			            mainBox:'main-box-nick',//内容盒子--必填
			            numBtnBox:'num-box-nick',//数字按钮盒子-- 必填
			            btnBox:'btn-box-nick',//按钮盒子 --必填
			            ipt:'page-ipt-nick',//input class-- 必填
			            goBtn:'go-btn-nick',//go btn class --必填
			            currentBtn:'active-nick'//当前按钮class name --必填
			        });
					
			        Data = data
// 			        alert(temp)
				}
	
			});
		}
		
// 	显示被选中的试卷中的题目，供选题出卷
	function paperPreview(questionSet){
		console.log(questionSet);
		strQids = String(questionSet).split("#");
		var qids = [];
		
		for(var i = 0; i < strQids.length; ++i){
			qids.push(parseInt(strQids[i]));
		}
		var str = "<%=basePath%>paper/selQuestionFromPaper.action?qids[]=" + qids[0];
		for(var i = 1; i < qids.length; ++i){
			var tmp = "&qids[]=" + qids[i];
			str += tmp;
		}
		$.ajax({
			type:"get",
			url:str,
			dataType: "json",
			async: false, //同步传输，并添加返回值，返回值应为已定义的全局变量 
			success:function(data) {
				alert(data);
				quesData = data;
				console.log(data);
				$("#paperQuestionList").find(".group_main").html("");
				for(var i = 0; i < data.length; ++i){
					for(var j = 0; j < data[i].rows.length; ++j){
						console.log(data[i].rows[j]);
						var question = data[i].rows[j];
						addQuestionInPageFromPaper(question, i, j);
					}
				}
			}
		});
	}
	
	//从表格中选择试题
	function chooseFromPaper(){
		var selectedQuestion = ""
		var questionItems = $("#paperQuestionList").find(".questionItem");
		var cnt = 0;
		var questionArray = [];
		for(var i = 0; i < questionItems.length; ++i){
			if($(questionItems[i]).prop("checked") == true){
				var arr = $(questionItems[i]).val().split("#");
				var intArr = [];
				for(var j = 0; j < arr.length; ++j){
					intArr.push(parseInt(arr[j]));
				}
				questionArray.push(quesData[intArr[0]].rows[intArr[1]]);
			}
		}
		console.log("questionArray:" + questionArray);
		return questionArray;
	}
	
	 $(function () { $('#selectQuestionFromPaper').on('hide.bs.modal', function () {
	      questions = chooseFromPaper();
	      for(var i = 0; i < questions.length; ++i){
	    	  addQuestionInPage(questions[i]);
	      }
	      $(this).removeData("modal");
	   })
	 });
	
	</script>
	
<!-- 显示要待选择的试题 -->
	<script type="text/javascript">
		var Data;
		function addQuestion(obj) {
			var type = $(obj).parents(".group_simple").find(".questionTypeText").html();
			var checkNodeTemp = checkNodes();
			var checkNode= JSON.stringify(checkNodeTemp);
			$.ajax({
				type:"post",
				url:"<%=basePath%>paper/showQuestion.action",
				data: {"courseId":${courseId}, "type": type, "checkNodes":checkNode},
				dataType: "json",
				async: false, //同步传输，并添加返回值，返回值应为已定义的全局变量 
				success:function(data) {
					Data = data

//			        定义一个分页方法，可多次调用
			        function paginationNick(opt){
//			            参数设置
			            var pager={
			                paginationBox:'',//分页容器-- 必填
			                mainBox:'',//内容盒子--必填
			                numBtnBox:'',//数字按钮盒子-- 必填
			                btnBox:'',//按钮盒子 --必填
			                ipt:'',//input class-- 必填
			                goBtn:'',//go btn class --必填
			                currentBtn:'',//当前按钮class name --必填
			                pageCount:10,//每页显示几条数据
			                numBtnCount:3,//当前页左右两边各多少个数字按钮
			                currentPage:0,//当前页码data-page，首屏默认值
			                maxCount:0,//ajax请求数据分成的最大页码
			                data:[]//ajax请求的数据
			            };
			            pager = $.extend(pager,opt);
			            //请求数据页面跳转方法
			            function goPage(btn){
			                //obj为ajax请求数据
			                
			                var obj = data

			                //将展示的数据赋值给pager.data  (array)
			                 // pager.data=obj.value;
			                pager.data=obj[0].rows;
			                //设置ajax请求数据分成的最大页码
// 			                alert(pager.data.length)

			                pager.maxCount=pager.data.length % pager.pageCount ? parseInt(pager.data.length / pager.pageCount) +1 :
			                    pager.data.length / pager.pageCount;

//			                设置当前页码
			                if(!isNaN(btn)){//数字按钮
			                    pager.currentPage=parseInt(btn);
			                }else{
			                    switch(btn){
			                        case 'first':
			                            pager.currentPage=0;
			                            break;
			                        case 'prev':
			                            if(pager.currentPage>0){
			                                --pager.currentPage;
			                            }
			                            break;
			                        case 'next':
			                            if(pager.currentPage+1<pager.maxCount){
			                                ++pager.currentPage;
			                            }
			                            break;
			                        case 'last':
			                            pager.currentPage=pager.maxCount-1;
			                            break;
			                    }
			                }
			                //创建数字按钮
			                createNumBtn(pager.currentPage);
			                //赋值给页码跳转输入框的value，表示当前页码
			                $('.'+pager.btnBox+' .'+pager.ipt).val(pager.currentPage+1);
//			              内容区填充数据
			                var arr=[],str='';
			                arr=pager.data.slice(pager.pageCount*pager.currentPage,
			                        pager.data.length - pager.pageCount*(pager.currentPage+1) > -1 ?
			                        pager.pageCount*(pager.currentPage+1) : pager.data.length);

							var start = pager.pageCount*pager.currentPage
			                var end = pager.data.length - pager.pageCount*(pager.currentPage+1) > -1 ?
			                        pager.pageCount*(pager.currentPage+1) : pager.data.length  
			                var s = '' 
			                var Html = '										<thead>'+
			                '											<tr>'+
			                '												<th><input type = "checkbox" class = "questionItemTotal" value = "" name = "questionTotal"/></th>'+
			                '												<th>题型</th>'+
			                '												<th>科目</th>'+
			                '												<th>题干</th>'+
			                '												<th>难度</th>'+
			                '											</tr>'+
			                '										</thead>';
			                $("#quesTable").html(Html)
			                for(var i = start; i < end; i++) {
			                    s += "<tr><td>" + '<input type = "checkbox" class = "questionItem" value = "' + i +'" name = "question"/>' + "</td><td>" + pager.data[i].type + "</td><td>" + pager.data[i].courseName + "</td><td>" +
			                    pager.data[i].subject + "</td><td>" +  pager.data[i].difficulty + "</td></tr>";
			                    console.log(i);
			                    // $("#quesTable").append(s);
			                }
			                $("#quesTable").append(s);
			                
// 			                arr.forEach(function(v){
// 			                    str+='<div>'+v+'</div>';
// 			                });
// 			                $('.'+pager.mainBox).html(s);
			            }
			            //创建非数字按钮和数据内容区
			            function createOtherBtn(){
			            	$('.'+pager.paginationBox).html('<div class="'+pager.btnBox+'"><button data-page="first" class="first-btn">首页</button><button data-page="prev" class="prev-btn">上一页</button><span class="'+pager.numBtnBox+'"></span><button data-page="next" class="next-btn">下一页</button><input type="text" placeholder="请输入页码" class="'+pager.ipt+'"><button class="'+pager.goBtn+'">确定go</button><button data-page="last" class="last-btn">尾页</button></div><div class="'+pager.mainBox+'"></div>');
			                //ipt value变化并赋值给go btn data-page
			                $('.'+pager.btnBox+' .'+pager.ipt).change(function(){
			                    if(!isNaN($(this).val())){//是数字
			                        if($(this).val() > pager.maxCount){//限制value最大值，跳转尾页
			                            $(this).val(pager.maxCount);
			                        }
			                        if($(this).val()<1){//限制value最小值，跳转首页
			                            $(this).val(1);
			                        }
			                    }else{//非数字清空value
			                        $(this).val('');
			                    }
			                    $('.'+pager.btnBox+' .'+pager.goBtn).attr('data-page',$(this).val() ? $(this).val()-1 : '');
			                });
			                //每个btn绑定请求数据页面跳转方法
			                $('.'+pager.btnBox+' button').each(function(i,v){
			                    $(this).click(function(){
			                        //有值且不是上一次的页码时才调用
			                        if(v.getAttribute('data-page') && v.getAttribute('data-page') != pager.currentPage){
			                            goPage(v.getAttribute('data-page'));
			                        }
			                    });
			                });
			            }
			            //创建数字按钮
			            function createNumBtn(page){
			                //page是页面index从0开始，这里的page加减一要注意
			                var str='';
			                if(pager.maxCount>pager.numBtnCount*2){//若最大页码数大于等于固定数字按钮总数（pager.numBtnCount*2+1）时
			                    //此页左边右边各pager.numBtnCount个数字按钮
			                    if(page-pager.numBtnCount>-1){//此页左边有pager.numBtnCount页 page页码从0开始
			                        for(var m=pager.numBtnCount;m>0;m--){
			                            str+='<button data-page="'+(page-m)+'">'+(page-m+1)+'</button>';
			                        }
			                    }else{
			                        for(var k=0;k<page;k++){
			                            str+='<button data-page="'+k+'">'+(k+1)+'</button>';
			                        }
			                    }
			                    str+='<button data-page="'+page+'" class="'+pager.currentBtn+'" disabled="disabled">'+(page+1)+'</button>';//此页
			                    if(pager.maxCount-page>3){//此页右边有pager.numBtnCount页 page页码从0开始
			                        for(var j=1;j<pager.numBtnCount+1;j++){
			                            str+='<button data-page="'+(page+j)+'">'+(page+j+1)+'</button>';
			                        }
			                    }else{
			                        for(var i=page+1;i<pager.maxCount;i++){
			                            str+='<button data-page="'+i+'">'+(i+1)+'</button>';
			                        }
			                    }
			                    /*数字按钮总数小于固定的数字按钮总数pager.numBtnCount*2+1时，
			                     这个分支，可以省略*/
			                    if(str.match(/<\/button>/ig).length<pager.numBtnCount*2+1){
			                        str='';
			                        if(page<pager.numBtnCount){//此页左边页码少于固定按钮数时
			                            for(var n=0;n<page;n++){//此页左边
			                                str+='<button data-page="'+n+'">'+(n+1)+'</button>';
			                            }
			                            str+='<button data-page="'+page+'" class="'+pager.currentBtn+'" disabled="disabled">'+(page+1)+'</button>';//此页
			                            for(var x=1;x<pager.numBtnCount*2+1-page;x++){//此页右边
			                                str+='<button data-page="'+(page+x)+'">'+(page+x+1)+'</button>';
			                            }
			                        }
			                        if(pager.maxCount-page-1<pager.numBtnCount){
			                            for(var y=pager.numBtnCount*2-(pager.maxCount-page-1);y>0;y--){//此页左边
			                                str+='<button data-page="'+(page-y)+'">'+(page-y+1)+'</button>';
			                            }
			                            str+='<button data-page="'+page+'" class="'+pager.currentBtn+'" disabled="disabled">'+(page+1)+'</button>';//此页
			                            for(var z=page+1;z<pager.maxCount;z++){//此页右边
			                                str+='<button data-page="'+z+'">'+(z+1)+'</button>';
			                            }
			                        }
			                    }
			                }else{
			                    str='';
			                    for(var n=0;n<page;n++){//此页左边
			                        str+='<button data-page="'+n+'">'+(n+1)+'</button>';
			                    }
			                    str+='<button data-page="'+page+'" class="'+pager.currentBtn+'" disabled="disabled">'+(page+1)+'</button>';//此页
			                    for(var x=1;x<pager.maxCount-page;x++){//此页右边
			                        str+='<button data-page="'+(page+x)+'">'+(page+x+1)+'</button>';
			                    }
			                }

			                $('.'+pager.numBtnBox).html(str);

			                //每个btn绑定请求数据页面跳转方法
			                $('.'+pager.numBtnBox+' button').each(function(i,v){
			                    $(this).click(function(){
			                        goPage(v.getAttribute('data-page'));
			                    });
			                });

			                //按钮禁用
			                $('.'+pager.btnBox+' button').not('.'+pager.currentBtn).attr('disabled',false);
			                if(!page){//首页时
			                    $('.'+pager.btnBox+' .first-btn').attr('disabled',true);
			                    $('.'+pager.btnBox+' .prev-btn').attr('disabled','disabled');
			                }
			                if(page==pager.maxCount-1){//尾页时
			                    $('.'+pager.btnBox+' .last-btn').attr('disabled',true);
			                    $('.'+pager.btnBox+' .next-btn').attr('disabled',true);
			                }
			            }

			            //首屏加载
			            createOtherBtn();//首屏加载一次非数字按钮即可
			            goPage();//请求数据页面跳转满足条件按钮点击都执行，首屏默认跳转到currentPage
			        }
			        //调用
			        paginationNick({
			            paginationBox:'pagination-nick',//分页容器--必填
			            mainBox:'main-box-nick',//内容盒子--必填
			            numBtnBox:'num-box-nick',//数字按钮盒子-- 必填
			            btnBox:'btn-box-nick',//按钮盒子 --必填
			            ipt:'page-ipt-nick',//input class-- 必填
			            goBtn:'go-btn-nick',//go btn class --必填
			            currentBtn:'active-nick'//当前按钮class name --必填
			        });
					
			        Data = data
// 			        alert(temp)
				}
			});
			

// 			return Data
			
		}
		
		
		//从表格中选择试题
		function choose(){
			var selectedQuestion = ""
			var questionItems = $(".questionItem");
			var cnt = 0;
			var questionArray = [];
			for(var i = 0; i < questionItems.length; ++i){
				if($(questionItems[i]).prop("checked") == true){
					questionArray.push(Data[0].rows[parseInt($(questionItems[i]).val())]);
				}
			}
			console.log(questionArray);
			return questionArray;
		}
		
		 $(function () { $('#questionChooseDialog').on('hide.bs.modal', function () {
			 
		      questions = choose();
		      for(var i = 0; i < questions.length; ++i){
		    	  addQuestionInPage(questions[i]);
		      }
		      $(this).removeData("modal");
		   })
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
			'            <div class="questions-group group_title">'+
			'                <h4>'+
			'                    <input type="text" class="" name="test_tittle" value="' + type + '">'+
			'                </h4>'+
			'            '+
			'	            <div class="extract-box-tit">'+
			'	                <span class="questionTypeText">' + type + '</span>'+
			'	                <div class="extract-box-btnDiv">'+
			'                        <a class="btn btn-blue-border2 selQuestionLink" href="javascript:void(0)" onclick = "addQuestion(this)">'+
			'                        	<span>选择试题</span>'+
			'                        </a>'+
			'	                </div>'+
			'	            </div>'+
			'        	</div>'+
			'            <div class="group_questionShow">'+
			'            </div>    '+
			'</div>';
			var rightHtml = '<div onclick="" class="item right_group_simple">'+
			'	                			<p></p>'+
			'								<h3 class="test_tittle">' + type + '</h3>'+
			'								<p></p>'+
			'								<p class="right_p">'+
			'									共<span class="test_num">0</span>题</p>'+
			'								<p></p>'+
			'								<p class="test_icon_a">'+
			'									<a class="m-content-trash glyphicon glyphicon-trash" aria-hidden="true" title="移除" onclick="removeSome(this)"></a>'+
			'									<a class="m-content-up glyphicon glyphicon-menu-up" aria-hidden="true" title="上移" onclick="moveUpSome(this)"></a>'+
			'									<a class="m-content-down glyphicon glyphicon-menu-down" aria-hidden="true" title="下移" onclick="moveDownSome(this)"></a>'+
			'								</p>'+
			'							</div>';
			if($(".paper").find(".group_main").html() == ""){
				$(".paper").find(".emptyTip").hide();
				$(".paper").find(".group_main").append(mainHtml);
				$(".right_group_main").append(rightHtml);
				idx = 0;
			}
			else{
				var groupSimples = $(".paper").find(".group_simple");
				var rightGroupSimples = $(".right_group_simple");
				var i = 0, tmpNum = 0;
				var isExist = false;
				for(; i < groupSimples.length; ++i){
					tmpNum = parseInt($(groupSimples[i]).attr("num"));
					if(tmpNum == resNum){
						isExist = true;
						break;
					}
					else if(tmpNum > resNum){
						break;
					}
				}
				if(isExist){
					idx = i;
				}
				else{
					if(i < groupSimples.length){
						$(".emptyTip").hide();
						$(groupSimples[i]).before(mainHtml);
						$(rightGroupSimples[i]).before(rightHtml);
						idx = i;
					}
					else{
						$(".emptyTip").hide();
						$(groupSimples[i - 1]).after(mainHtml);
						$(rightGroupSimples[i - 1]).after(rightHtml);
						idx = i;
					}
				}
			}
			var questionHtml = '<div class="question-content" style = "display: block">'+
			'		<input class="questionId" type="hidden"  name = "qid" value="'+ question.qid + '">'+
			'		<div class="descPanel descOfQuestion">'+
			'            <div class = "content"> '+
			'            	'+ question.subject+
			'            </div>       '+
			'        </div>'+
			'        <div class="keyRadio keyPanel radioOfQuestion" style="display: block;">'+
			'            <div class = "optionContent content">'+
			'                <div class="keyLeft">'+
			'                    <span class="optionDes">A.&nbsp&nbsp</span>'+
			'                    <span class="content">' + question.optionA + '</span>'+
			'                </div>'+
			'                <div class="keyLeft">'+
			'                	<span class="optionDes">B.&nbsp&nbsp</span>'+
			'                    <span class="content">' + question.optionB + '</span>'+
			'                </div>'+
			'                <div class="keyLeft">'+
			'                	<span class="optionDes">C.&nbsp&nbsp</span>'+
			'                	<span class="content">' + question.optionC + '</span>'+
			'                </div>'+
			'                <div class="keyLeft">'+
			'                	<span class="optionDes">D.&nbsp&nbsp</span>'+
			'                	<span class="content">' + question.optionD + '</span>'+
			'                </div>'+
			'            </div>'+
			'            <div class = "content">'+
			'			 	<span class = "answerDes">答案:&nbsp&nbsp</span>'+
			'                <span>'+ question.answer + '</span>'+
			'            </div>'+
			'		</div>'+
			'	'+
			'		<div class="keyFill keyPanel fillOfQuestion" style="display: block;">'+
			'            <div class="keyFillContent content" style="display: block;">'+
			'			 	<span class = "answerDes">答案:&nbsp&nbsp</span>'+
			'				<span class = "content">'+ question.answer + '</span>'+
			'           	</div>'+
			'        </div>'+
			'          '+
			'        <div class="keyJudge keyPanel judgeOfQuestion" style="display: block;">'+
			'            <input type="radio" class="hidden judgeYes"  name="answerJudge" value="正确" checked>'+
			'            <label for="judgeYes" class="btn btn-border-gray content">正确</label>'+
			'            <input type="radio" class="hidden judgeNo"  name="answerJudge" value="错误">'+
			'            <label for="judgeNo" class="btn btn-border-gray content">错误</label> '+
			'        </div>'+
			'            '+
			'        <div class="keyCloze keyPanel clozeOfQuestion" style="display: block;">'+
			'            <div class = "content">'+
			'			 	<span class = "answerDes">答案:&nbsp&nbsp</span>'+
			'                <span>'+ question.answer + '</span>'+
			'            </div>'+
			'        </div>'+
			'          '+
			'        <div class="analysisPanel analysisOfQuestion" style="display: block;">'+
			'            <div class = "content">'+
			'			 	<span class = "analysisDes">解析:&nbsp&nbsp</span>'+
			'            	<span>'+ question.analysis + '</span>'+
			'            </div>'+
			'        </div>                '+
			'        <div class="chapterPanel chapterOfQuestion" style="display: block;">'+
			'            <div class = "content">'+
			'			 	<span class = "chapterDes">章节:&nbsp&nbsp</span>'+
			'            	<span>'+ question.chapter + '</span>'+
			'            </div>'+
			'        </div>                '+
			'        <div class="knowpointPanel knowpointOfQuestion" style="display: block;">'+
			'            <div class = "content">'+
			'			 	<span class = "knowpointDes">知识点:&nbsp&nbsp</span>'+
			'            	<span>'+ question.knowPoint + '</span>'+
			'            </div>'+
			'        </div>                '+
			'		 <a class="m-example-remove" onclick = "removeOne(this)"><i class="glyphicon glyphicon-trash"></i>删除</a>'+
			'		 <a class="m-example-up" aria-hidden="true" title="上移" questionid="" onclick="moveUpOne(this)"><i class="glyphicon glyphicon-menu-up"></i>上移</a>'+
			'		 <a class="m-example-down" aria-hidden="true" title="下移" questionid="" onclick="moveDownOne(this)"><i class="glyphicon glyphicon-menu-down"></i>下移</a>'+
			'</div>';
			console.log("idx:" + idx);
			var groupQuestionShow = $(".paper").find(".group_simple:eq(" + idx + ") .group_questionShow"); 
			var rightGroupSimples = $(".right_group_simple:eq(" + idx +")");
			var total = $(".test_total");
			var typeArray = new Array("radioOfQuestion", "fillOfQuestion", "judgeOfQuestion", "clozeOfQuestion");
			var alphaDict = {"A":0, "B":1, "C":2, "D":3, "E":4, "F":5, "G":6};
			var quesNum = parseInt(rightGroupSimples.find(".test_num").html());
			var totalQuesNum = parseInt($(total).html());
			console.log("quesNum:" + quesNum);
			$(groupQuestionShow).append(questionHtml);
			rightGroupSimples.find(".test_num").html(quesNum + 1);//相应题型题数+1
			total.html(totalQuesNum + 1);//总题数+1
			console.log("resNum:" + resNum);
			/* 根据题目类型显示 不同字段 */
			var index;
			for(index in typeArray){
				$(groupQuestionShow).find("." + typeArray[index]).hide();
			}
			switch(resNum){
			case 1:$(groupQuestionShow).find("." + typeArray[0]).show();
				var options = $(groupQuestionShow).find("." + typeArray[0] + ":last").find(".keyLeft");
				$(options[alphaDict[question.answer]]).addClass("correctAnswer");
			break;
			case 2:$(groupQuestionShow).find("." + typeArray[0]).show();
			break;
			case 3:$(groupQuestionShow).find("." + typeArray[2]).show();
			break;
			case 4:$(groupQuestionShow).find("." + typeArray[1]).show();
			break;
			case 5:$(groupQuestionShow).find("." + typeArray[3]).show();
			break;
			case 6:$(groupQuestionShow).find("." + typeArray[3]).show();
			break;
			case 7:$(groupQuestionShow).find("." + typeArray[3]).show();
			break;
			default:
			alert("其它");
			break;
		}
		}
	</script>
	
<!-- 在页面中添加试题(从试卷中) -->
	<script type = "text/javascript">
		function addQuestionInPageFromPaper(question, pageIdx, quesIdx){
			var type = question.type;
			console.log(type);
			var typeDict = {"0":0, "单选题":1, "多选题":2, "判断题":3, "填空题":4, "问答题":5, "简述题":6, "名词解释":7};
			var resNum = typeDict[type], idx;
			var mainHtml = 
				'<div class="group_simple" num="' + resNum + '">'+
				'					<div class="questions-title">' + 
				'						<input type = "checkbox" class = "questionTotal" value = "" name = "questionTotal"/>'+
				'						<span>' + type + '(共<span class = "quesNum">0</span>题)<span></div>'+
				'					<div class="questions-group">'+
				'						<div class="group_questionShow">'+
				'				        </div>  '+
				'					</div>  '+
				'            	</div>';
			if($("#paperQuestionList").find(".group_main").html() == ""){
				$("#paperQuestionList").find(".group_main").append(mainHtml);
				idx = 0;
			}
			else{
				var groupSimples = $("#paperQuestionList").find(".group_simple");
				var i = 0, tmpNum = 0;
				var isExist = false;
				for(; i < groupSimples.length; ++i){
					tmpNum = parseInt($(groupSimples[i]).attr("num"));
					if(tmpNum == resNum){
						isExist = true;
						break;
					}
					else if(tmpNum > resNum){
						break;
					}
				}
				if(isExist){
					idx = i;
				}
				else{
					if(i < groupSimples.length){
						$(groupSimples[i]).before(mainHtml);
						idx = i;
					}
					else{
						$(".emptyTip").hide();
						$(groupSimples[i - 1]).after(mainHtml);
						idx = i;
					}
				}
			}
			var questionHtml = '<div class="question-content" style="display: block">'+
			'		<input name="qid" class="questionId" type="hidden" value="' + question.qid +'">		'+
			'		<div class="descPanel descOfQuestion">            '+
			'			<div class="content">' + 
			'				<input type = "checkbox" class = "questionItem" value = "' + pageIdx  +'#' + quesIdx + '" name = "questionItem"/>' + question.subject+
			'			</div>               '+
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
			'			<div class="content">			 	'+
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
			'			<input name="answerJudge" class="hidden judgeYes" type="radio" checked="" value="正确">            '+
			'			<label class="btn btn-border-gray content" for="judgeYes">正确</label>            '+
			'			<input name="answerJudge" class="hidden judgeNo" type="radio" value="错误">            '+
			'			<label class="btn btn-border-gray content" for="judgeNo">错误</label>         '+
			'		</div>                    '+
			'		<div class="keyCloze keyPanel clozeOfQuestion" style="display: none;">            '+
			'			<div class="content">			 	'+
			'				<span class="answerDes">答案:&nbsp;&nbsp;</span>                '+
			'				<span>' + question.answer+'</span>            '+
			'			</div>        '+
			'		</div>                  '+
			'		<div class="analysisPanel analysisOfQuestion" style="display: block;">            '+
			'			<div class="content">			 	'+
			'				<span class="analysisDes">解析:&nbsp;&nbsp;</span>            	'+
			'				<span>' +question.analysis +'</span>            '+
			'			</div>        '+
			'		</div>                        '+
			'		<div class="chapterPanel chapterOfQuestion" style="display: block;">            '+
			'			<div class="content">			 	'+
			'				<span class="chapterDes">章节:&nbsp;&nbsp;</span>            	'+
			'				<span>' + question.chapter +'</span>            '+
			'			</div>        '+
			'		</div>                        '+
			'		<div class="knowpointPanel knowpointOfQuestion" style="display: block;">            '+
			'			<div class="content">			 	'+
			'				<span class="knowpointDes">知识点:&nbsp;&nbsp;</span>            	'+
			'				<span>' + question.knowPoint +'</span>            '+
			'			</div>        '+
			'		</div>                		 '+
			'	</div>';
			console.log("idx:" + idx);
			var groupQuestionShow = $("#paperQuestionList").find(".group_simple:eq(" + idx + ") .group_questionShow"); 
			var typeArray = new Array("radioOfQuestion", "fillOfQuestion", "judgeOfQuestion", "clozeOfQuestion");
			var alphaDict = {"A":0, "B":1, "C":2, "D":3, "E":4, "F":5, "G":6};
			var quesNum = parseInt($("#paperQuestionList").find(".group_simple:eq(" + idx + ") .quesNum").html());
			console.log("quesNum:" + quesNum);
			$(groupQuestionShow).append(questionHtml);
			$("#paperQuestionList").find(".group_simple:eq(" + idx + ") .quesNum").html(quesNum + 1);
			console.log("resNum:" + resNum);
			/* 根据题目类型显示 不同字段 */
			var index;
			for(index in typeArray){
				$(groupQuestionShow).find("." + typeArray[index]).hide();
			}
			switch(resNum){
			case 1:$(groupQuestionShow).find("." + typeArray[0]).show();
				var options = $(groupQuestionShow).find("." + typeArray[0] + ":last").find(".keyLeft");
				$(options[alphaDict[question.answer]]).addClass("correctAnswer");
			break;
			case 2:$(groupQuestionShow).find("." + typeArray[0]).show();
			break;
			case 3:$(groupQuestionShow).find("." + typeArray[2]).show();
			break;
			case 4:$(groupQuestionShow).find("." + typeArray[1]).show();
			break;
			case 5:$(groupQuestionShow).find("." + typeArray[3]).show();
			break;
			case 6:$(groupQuestionShow).find("." + typeArray[3]).show();
			break;
			case 7:$(groupQuestionShow).find("." + typeArray[3]).show();
			break;
			default:
			alert("其它");
			break;
		}
		}
	</script>

<!-- 删除、上移、下移单道题目 -->
	<script type = "text/javascript">
		function removeOne(obj){
			var typeText = $(obj).parents(".group_simple").find(".questionTypeText").html();
			var rightGroupSimples = $(".right_group_simple");
			for(var i = 0; i < rightGroupSimples.length; ++i){
				if($(rightGroupSimples[i]).find(".test_tittle").html() == typeText){
					var quesNum = parseInt($(rightGroupSimples[i]).find(".test_num").html());
					var totalQuesNum = parseInt($(".test_total").html());
					$(rightGroupSimples[i]).find(".test_num").html(quesNum - 1);
					if(quesNum == 1){
						$(rightGroupSimples[i]).remove();
					}
					$(".test_total").html(totalQuesNum - 1);
					break;
				}
			}
			$(obj).parents(".question-content").remove();
		}
		function moveUpOne(obj){
			var nowElement = $(obj).parents(".question-content");
			nowElement.prev().before(nowElement);
			//nowElement.remove();
		}
		function moveDownOne(obj){
			var nowElement = $(obj).parents(".question-content");
			nowElement.next().after(nowElement);
			//nowElement.remove();
		}
	</script>

<!-- 删除、上移、下移多道题目 -->
	<script type = "text/javascript">
		function removeSome(obj){
			var typeText = $(obj).parents(".right_group_simple").find(".test_tittle").html();
			var groupSimples = $(".group_simple");
			for(var i = 0; i < groupSimples.length; ++i){
				if($(groupSimples[i]).find(".questionTypeText").html() == typeText){
					var nowElement = $(groupSimples[i]);
					nowElement.remove();
					break;
				}
			}
			$(obj).parents(".right_group_simple").remove();
		}
		function moveUpSome(obj){
			
			var typeText = $(obj).parents(".right_group_simple").find(".test_tittle").html();
			var groupSimples = $(".group_simple");
			for(var i = 0; i < groupSimples.length; ++i){
				if($(groupSimples[i]).find(".questionTypeText").html() == typeText){
					var nowElement = $(groupSimples[i]);
					nowElement.prev().before(nowElement);
					break;
				}
			}
			var nowElement = $(obj).parents(".right_group_simple");
			nowElement.prev().before(nowElement);
			//nowElement.remove();
		}
		function moveDownSome(obj){
			var typeText = $(obj).parents(".right_group_simple").find(".test_tittle").html();
			var groupSimples = $(".group_simple");
			for(var i = 0; i < groupSimples.length; ++i){
				if($(groupSimples[i]).find(".questionTypeText").html() == typeText){
					var nowElement = $(groupSimples[i]);
					nowElement.next().after(nowElement);
					break;
				}
			}
			var nowElement = $(obj).parents(".right_group_simple");
			nowElement.next().after(nowElement);
			//nowElement.remove();
		}
	</script>
	
	<script type="text/javascript">
		function previewPaper(){
			var qids = getQidsAndQnums();
			var str = "<%=basePath%>paper/preview.action?qids[]=" + qids[0];
			for(var i = 1; i < qids.length; ++i){
				var tmp = "&qids[]=" + qids[i];
				str += tmp;
			}
			console.log(str);
// 			window.location.href = str;
			window.open(str)
		}
	</script>
	
<!-- 	生成并保存试卷 -->
	<script type="text/javascript">
		function paperGenerate(){
			var qids = getQidsAndQnums();
			alert("aaaa")
<%-- 			url:"<%=basePath%>paper/showQuestion.action?courseId=" + ${courseId} + "&type=" + type + "&checkNodes=" + checkNode, --%>
			var str = "<%=basePath%>paper/Generate.action?qids[]=" + qids[0] + "&courseId=" + ${courseId} + "&paperName=" + '${paperName}';
<%-- 			var str = "<%=basePath%>paper/Generate.action?qids[]=" + qids[0]; --%>
			for(var i = 1; i < qids.length; ++i){
				var tmp = "&qids[]=" + qids[i];
				str += tmp;
			}
			console.log(str);
// 			window.location.href = str;
			window.open(str)
		}
	</script>
	
	<script type="text/javascript">
		function getQidsAndQnums(){
			var questions = $(".question-content");
			var qids = [], qid = 0, typeNums = {}, typeNum = 0, type = "";
			var rGroupSimples = $(".right_group_simple");
			for(var i = 0; i < questions.length; ++i){
				qid = parseInt($(questions[i]).find(".questionId").val());
				qids.push(qid);
			}
			for(var i = 0; i < rGroupSimples.length; ++i){
				typeNum = parseInt($(rGroupSimples[i]).find(".test_num").html());
				type = $(rGroupSimples[i]).find(".test_tittle").html();
				console.log(typeNum);
				typeNums.type = typeNum;
			}
			console.log("qids:" + qids);
			return qids;
			console.log("typeNums:" + typeNums);
		}
	</script>

</body>

</html>