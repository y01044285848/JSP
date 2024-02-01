<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>7.scope</title>
		<!-- 
			날짜 : 2024-01-31
			이름 : 이승윤
			내용 : application 내장객체 실습하기
			
			내장객체의 영역(Scope)
			 - JSP 내장객체가 저장되는 메모리의 유요범위
			 - 각 내장객체별 영역이 포함관계(pageContext < request < session < application)
			 - 하나의 요청이 모여 하나의 세션을 이루고 세션이 모여 애플리케이션을 구성 
		 -->
	</head>
	<body>
		7.내장 객체 영역
		<%
			pageContext.setAttribute("name","김유신");
			request.setAttribute("name","김춘추");
			session.setAttribute("name","장보고");
			application.setAttribute("name","강감찬");
		%>
		
		<p>
			pageContext 확인 : <%= pageContext.getAttribute("name") %><br>
			request 확인 : <%= request.getAttribute("name") %><br>
			session 확인 : <%= session.getAttribute("name") %><br>
			application 확인 : <%= application.getAttribute("name") %><br>
		</p>
		
		<%
			pageContext.forward("./proc/resultScope.jsp");
		%>
		
	</body>
</html>