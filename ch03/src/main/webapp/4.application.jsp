<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>4.application</title>
		<!-- 
			날짜 : 2024-01-31
			이름 : 이승윤
			내용 : application 내장객체 실습하기
			
			application
			 - 현재 웹 애플리케이션을 실행하는 WAS(톰캣) 환격 객체
			 - 서버 환경값(web.xml)을 설정하고 참조하는 기능 제공
			 
			
		 -->
	</head>
	<body>
		<h3>4.application 내장객체</h3>
		<h4>서버정보</h4>
		<p>
			<%= application.getServerInfo() %>
		</p>
		
		
		<h4>파라미터 정보</h4>
		<p>
			PARAM1 : <%=application.getInitParameter("PARAM1") %><br>
			PARAM2 : <%=application.getInitParameter("PARAM2") %><br>
		</p>
		
		<h4>로그정보</h4>
		<%
			application.log("4.application...로그1");
		%>
		
		<h4>자원경로</h4>
		<p>
			파일경로 : <%= application.getRealPath("./4.application.jsp") %>
		</p>
		
		
	</body>
</html>