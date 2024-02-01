<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>페이지를 찾을 수 없습니다.</title>
</head>
<body>
	<h3>일시적으로 에러가 발생했습니다.</h3>
	<p>
		<%= exception.getMessage() %>
	</p>
	
	<a href="../6.exception.jsp">뒤로가기</a>
</body>
</html>