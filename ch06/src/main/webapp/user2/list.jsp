<%@page import="java.util.ArrayList"%>
<%@page import="dto.User2DTO"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String host = "jdbc:mysql://127.0.0.1:3306/studydb";
	String user = "sysh58";
	String pass = "abc1234";
	String driver = "com.mysql.cj.jdbc.Driver";
	
	List<User2DTO> users = new ArrayList<>();
	
	try{
		Class.forName(driver);
		Connection conn = DriverManager.getConnection(host, user, pass);
		Statement stmt = conn.createStatement();
		
		String sql = "SELECT * FROM `user2`";
		ResultSet rs = stmt.executeQuery(sql);
		
		while(rs.next()){
			User2DTO dto = new User2DTO();
		}
		
	}catch(Exception e){
		e.printStackTrace();
	}
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>
	<body>
		<h3>User2 목록</h3>
		<a href="../1.Jdbc.jsp">처음으로</a>
		<a href="./register.jsp">등록하기</a>
		<table>
			<tr>
				<th>아이디</th>
				<th>이름</th>
				<th>생년월일</th>
				<th>주소</th>
				<th>관리</th>
			</tr>
			<tr>
				<td>a101</td>
				<td>홍길동</td>
				<td>2000-01-02</td>
				<td>부산</td>
				<td>
					<a href="./modify.jsp?uid=<%--<%= dto.getUid() %>--%>">수정</a>
					<a href="./delete.jsp?uid=<%--<%= dto.getUid() %>--%>">삭제</a>
				</td>
			</tr>
		</table>
	</body>
</html>