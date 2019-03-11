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

<body onload = "ready();">

	<div class="panel panel-default">
				<div class="panel-body">
					<form class="form-inline" action="${pageContext.request.contextPath }/login.action" method="post">
						<input type="password" style="display:none;" />
						<TABLE class="tab" border="0" cellSpacing="6" cellPadding="8">
							<TBODY>
								<TR>
									<TD>用户名：</TD>
									<TD colSpan="2"><input type="text" id="usercode"
										name="username" style="WIDTH: 130px" /></TD>
								</TR>
								<TR>
									<TD>密 码：</TD>
									<TD><input type="password" id="pwd" name="password" style="WIDTH: 130px" />
									</TD>
								</TR>
								<TR>
									<TD>验证码：</TD>
									<TD><input id="randomcode" name="randomcode" size="8" /> <img
										id="randomcode_img" src="${pageContext.request.contextPath }/validatecode.jsp" alt=""
										width="56" height="20" align='absMiddle' /> <a
										href=javascript:randomcode_refresh()>刷新</a></TD>
								</TR>
		
								<TR>
									<TD colSpan="2" align="center">
<!-- 										<input type="button"class="btnalink" onclick="loginsubmit()" value="登&nbsp;&nbsp;录" /> -->
										<button type="submit" class="btn btn-primary">登录</button>
										<input type="reset" class="btnalink" value="重&nbsp;&nbsp;置" />
									</TD>
								</TR>
								
							</TBODY>
						</TABLE>
						
<!-- 						<button type="submit" class="btn btn-primary">查询</button> -->
						
					</form>
				</div>
			</div>
	

	
	
</body>

</html>

<script type = "text/javascript">
	function ready(){
		var errorMeg = '${errorMeg}';
		if(errorMeg != ""){
			alert(errorMeg);
		}
}
</script>
