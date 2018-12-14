<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>文件上传</title>

</head>
<body>
<c:choose>
    <c:when test="${not empty fileList }">
        <!--索引-->
        <c:set var="index" value='1'></c:set>
        <c:forEach items="${fileList }" var="file">
            <!-- filename:文件的名字，不带UUID -->
            <c:set var="filename" value='${fn:substring(file.name,fn:indexOf(file.name,"_")+1,fn:length(file.name)) }'/>
            <!-- filefullname:文件的名字，带UUID -->
            <c:set var="filefullname" value='${fn:split(file.path,"\\\\")[fn:length(fn:split(file.path,"\\\\"))-1] }'></c:set>
            <!-- rootdir:文件的目录 -->
            <c:set var="rootdir" value='${pageContext.request.contextPath}/paper/'></c:set>
            <div>
            <img alt='${fileanme }' src='${rootdir.concat(filefullname) }'><!-- 文件的全路径 -->
                <a href="${pageContext.request.contextPath}/paper/downloadWord.action?filename=${filefullname}">${filefullname}下载</a>
<%--            <a href="${pageContext.request.contextPath}/download?filename=${newfilename}">下载</a> --%>
            </div>
            <!-- 每行显示5张图片 -->
            <c:if test="${index%5==0 }">
                <br>
            </c:if>
            <!--索引+1-->
            <c:set var="index" value='${index+1 }'></c:set>
        </c:forEach>
    </c:when>
    <c:otherwise>
        暂无数据
    </c:otherwise>
</c:choose>
</body>
</html>