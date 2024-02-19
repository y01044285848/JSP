<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="ch07.FileDTO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%

	List<FileDTO> files = new ArrayList<>();
	try{
		// 데이터베이스 저장
		// 1단계 JNDI(java naming directory interface) 서비스 객체 생성
		Context ctx = (Context) new InitialContext().lookup("java:comp/env");
		
		// 2단계 - 커넥션 풀에서 커넥션 가져오기
		DataSource ds = (DataSource) ctx.lookup("jdbc/studydb");
		Connection conn = ds.getConnection();
		
		String sql = "SELECT * FROM `FileTest`";
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery(sql);
		
		while(rs.next()){
			FileDTO dto = new FileDTO();
			dto.setFno(rs.getInt(1));
			dto.setTitle(rs.getString(2));
			dto.setoName(rs.getString(3));
			dto.setsName(rs.getString(4));
			dto.setRdate(rs.getString(5));
			
			files.add(dto);
		}
		
		rs.close();
		stmt.close();
		conn.close();
		
		
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
<h3>2.파일 다운로드</h3>
<table border="1">
	<tr>
		<th>번호</th>
		<th>제목</th>
		<th>원본파일명</th>
		<th>저장파일명</th>
		<th>날짜</th>
		<th>관리</th>
	</tr>
	<%for(FileDTO file : files){ %>
	<tr>
		<td><%= file.getFno() %></td>
		<td><%= file.getTitle() %></td>
		<td><%= file.getoName() %></td>
		<td><%= file.getsName() %></td>
		<td><%= file.getRdate() %></td>
		<td>
			<a href="./proc/fileDownloadProc.jsp?fno=<%= file.getFno() %>">다운로드</a>
			<a href="./proc/fileDeleteProc.jsp?fno=<%= file.getFno() %>">삭제</a>
		</td>
	</tr>
	<%} %>
</table>
</body>
</html>