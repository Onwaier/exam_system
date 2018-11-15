<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>文件下载页面</title>
</head>
<body>
   <h1>文件下载页面</h1>
   <form >
       <table border="1">
          <tr>
             <th>图片展示</th>
             <th>操作</th>
          </tr>
	       <c:forEach items="${filenames}" var="newfilename">
		       <c:set var="rootdir" value='${pageContext.request.contextPath}/images/'></c:set>
		       <td><img alt='${fileanme }' src='${rootdir.concat(newfilename) }' name = "position"></td>       
	<!-- 	              路径为以下形式，浏览器可以打开图片 -->
	<%-- 	             <td><img alt="" src="/FileDownload/images/${newfilename}%> " width="140" height="170"/> </td>   --%>
	<!--               下载图片 --> 
		       <td><a href="${pageContext.request.contextPath}/question/downloadPicture.action?filename=${newfilename}">下载</a></td>
	       </c:forEach>
       </table>
   </form>



</body>
</html>