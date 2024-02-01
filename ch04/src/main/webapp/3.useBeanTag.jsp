<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>2.includeTag</title>
		<!-- 
			날짜 : 2024-01-31
			이름 : 이승윤
			내용 : JSP 액션태그 useBean 실습하기
		 -->
	</head>
	<body>
	 
		 <h3>3. useBean 액션태그</h3>
		
		<form action="./proc/userProc.jsp" method="get">
			<input type="text" name="uid"><br> 
			<input type="text" name="name"><br> 
			<input type="text" name="age"><br> 
			<input type="text" name="addr"><br> 
			<input type="submit" value="전송"> 
		</form>
		 
	</body>
</html>