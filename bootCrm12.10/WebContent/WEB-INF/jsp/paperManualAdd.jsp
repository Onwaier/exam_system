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

<style>
    button{
        padding:5px;
        margin:5px;
    }
    .active-nick{
        color:red;
    }
    input{
        width:50px;
        text-align:center;
    }
</style>

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
	                			<h3><input class="edit-paper-name form-control" type="text" name="edit_paper_name" value="141413" placeholder="点击输入试卷名称"></h3>
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
					<button type="button" class="btn btn-default" onclick="" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" onclick="choose()">保存修改</button>
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
		
<!-- 	页面加载时从后台获取章节知识点列表数据 -->
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

<!-- 添加试题 -->
	<script type="text/javascript">
		function addQuestion1(obj){
			var html = '<div class="question-content" style = "display: block">'+
			'		<input id="questionId" type="hidden"  name = "qid" value="">'+
			'		<div class="descPanel descOfQuestion">'+
			'            <div class = "content"> '+
			'            	题干'+
			'            </div>       '+
			'        </div>'+
			'        <div class="keyRadio keyPanel radioOfQuestion" style="display: block;">'+
			'            <div>'+
			'                <div class="keyLeft">'+
			'                    <input type="radio" class="radioOrCheck" name="answerOption" value="A"/>'+
			'                    <span class="content">选项A</span>'+
			'                </div>'+
			'                <div class="keyLeft">'+
			'                	<input type="radio" class="radioOrCheck" name="answerOption" value="B" />'+
			'                    <span class="content">选项B</span>'+
			'                </div>'+
			'                <div class="keyLeft">'+
			'                	<input type="radio" class="radioOrCheck" name="answerOption" value="C" />'+
			'                	<span class="content">选项C</span>'+
			'                </div>'+
			'                <div class="keyLeft">'+
			'                	<input type="radio" class="radioOrCheck" name="answerOption" value="D" />'+
			'                	<span class="content">选项D</span>'+
			'                </div>'+
			'            </div>'+
			'		</div>'+
			'	'+
			'		<div class="keyFill keyPanel fillOfQuestion" style="display: block;">'+
			'            <div class="keyFillContent content" style="display: block;">'+
			'				填空题答案'+
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
			'                问答题答案'+
			'            </div>'+
			'        </div>'+
			'          '+
			'        <div class="analysisPanel analysisOfQuestion" style="display: block;">'+
			'            <div class = "content">'+
			'            	解析'+
			'            </div>'+
			'        </div>                '+
			'</div>';
			var typeDict = {"0":0, "单选题":1, "多选题":2, "判断题":3, "填空题":4, "问答题":5, "简述题":6, "名词解释":7};
			var typeArray = new Array("radioOfQuestion", "fillOfQuestion", "judgeOfQuestion", "clozeOfQuestion");
			var groupSimple = $(obj).parents(".group_simple");
			var typeNum = parseInt(groupSimple.attr("num"));
			var groupQuestionShow =$(groupSimple).find(".group_questionShow");
			groupQuestionShow.append(html);//添加题目
			
			var index;
			for(index in typeArray){
				$(groupQuestionShow).find("." + typeArray[index]).hide();
			}
			
			/* 根据题目类型显示 不同字段 */
			switch(typeNum){
			case 1:$(groupQuestionShow).find("." + typeArray[0]).show();
			/* var radioOrChecks = $(groupQuestionShow).find(".radioOrCheck");
			var i;
			for(i in radioOrChecks)
				$(radioOrChecks[i]).attr("type","radio"); */
			break;
			case 2:$(groupQuestionShow).find("." + typeArray[0]).show();
			/* var radioOrChecks = $(groupQuestionShow).find(".radioOrCheck");
			var i;
			for(i in radioOrChecks)
				$(radioOrChecks[i]).attr("type","checkbox"); */
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
		};
	</script>
	
<!-- 添加试题类型 -->		
	<script type = "text/javascript">
		$("#questionType").change(function(e){
			var typeDict = {"0":0, "单选题":1, "多选题":2, "判断题":3, "填空题":4, "问答题":5, "简述题":6, "名词解释":7};
			var resNum = typeDict[$(this).val()];
			var html = 
				'<div class="group_simple" num="' + resNum + '">'+
			'            <div class="questions-group group_title">'+
			'                <h4>'+
			'                    <input type="text" class="" name="test_tittle" value="' + $(this).val() + '">'+
			'                </h4>'+
			'            '+
			'	            <div class="extract-box-tit">'+
			'	                <span class="questionTypeText">' + $(this).val() + '</span>'+
			'	                <div class="extract-box-btnDiv">'+
			'                        <a class="btn btn-blue-border2 selQuestionLink" data-toggle="modal" data-target="#questionChooseDialog"  onclick = "addQuestion()">'+
			'                        	<span>选择试题</span>'+
			'                        </a>'+
			'	                </div>'+
			'	            </div>'+
			'        	</div>'+
			'            <div class="group_questionShow">'+
			'            </div>    '+
			'</div>';
			if($(".group_main").html() == ""){
				$(".emptyTip").hide();
				$(".group_main").append(html);
			}
			else{
				var groupSimples = $(".group_simple");
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
						$(".emptyTip").hide();
						$(groupSimples[i]).before(html);
					}
					else{
						$(".emptyTip").hide();
						$(groupSimples[i - 1]).after(html);
					}
				}
			}
		});
	</script>
	
<!-- 显示要待选择的试题 -->
	<script type="text/javascript">
		var Data
		function addQuestion() {
		
			$.ajax({
				type:"get",
				url:"<%=basePath%>paper/showQuestion.action",
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
// 			                alert(start)
// 			                alert(end)  
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
		
		function choose(){
			var selectedQuestion = ""
			
			//addQuestion()
			alert(Data[0].rows.length)
			var questionItems = $(".questionItem");
			var cnt = 0;
			var idArray = [];
			for(var i = 0; i < questionItems.length; ++i){
				if($(questionItems[i]).prop("checked") == true){
					idArray.push(Data[0].rows[parseInt($(questionItems[i]).val())]);
				}
			}
			console.log(idArray);
			
		}
		
		 $(function () { $('#questionChooseDialog').on('hide.bs.modal', function () {
		      choose();
		   })
		 });

	</script>
	



		
	


</body>

</html>