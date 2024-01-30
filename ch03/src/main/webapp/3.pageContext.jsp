<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>3.pageContext</title>
		<!-- 
			날짜 : 2024-01-30
			이름 : 이승윤
			내용 : 내장객체 pageContext 실습
			
			pageContext 내장객체
			 - 요청에 대응하는 대상 JSP 파일 객체
			 - JSP 파일 하나당 하나의 pageContext 객체 생성
			 - 주요기능은 페이지 흐름 제어(include, forward) 기능 제공
			 
			forward
			 - 서버 자원 내에서 파이지를 요청하는 기능
			 - 최초 요청 주소로 고정, cf) redirect는 최종 요청주소 고정
			
		-->
	</head>
	<body>
		<h3>3.pageContext 내장객체</h3>
		
		<h4>forward</h4>
		<a href="./proc/forward1.jsp">포워드 요청</a>
		<a href="./proc/forward2.jsp">포워드 요청</a>
		
		<h4>include</h4>
		<%
			pageContext.include("./inc/_header.jsp");
			pageContext.include("./inc/_footer.jsp");
		%>
		
	</body>
</html>