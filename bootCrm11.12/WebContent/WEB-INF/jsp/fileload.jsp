<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>文件上传</title>
<script >
   function check(){
	   //通过标签的id属性获取属性值
// 	   var name=document.getElementById("name").value;
	   var file=document.getElementById("file").value;
// 	   if(name==""){
// 	        alert("上传人未填写");
// 	        return false;
// 	    }
	    if(file.length==0||file==""){
	        alert("请选择上传文件");
	        return false;
	    }
	    return true;
   }
</script>
</head>
<body>
   <form action="${pageContext.request.contextPath }/question/fileUpload.action" method="post"
    method="post" enctype="multipart/form-data" onsubmit="return check()">
<!-- 	上传人：<input id="name" type="text" name="name" /><br/><br/> -->
	请选择文件(文件名请勿出现中文字符)：<input id="file" type="file" name="uploadfile" 
             multiple="multiple" /><br/><br/>
		     <input type="submit" value="上传" />
	</form>
</body>
</html>