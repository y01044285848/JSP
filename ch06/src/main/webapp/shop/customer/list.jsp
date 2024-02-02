<%@page import="dto.CustomerDTO"%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>

<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	List<CustomerDTO> custs = new ArrayList<>();
	
	try{
		Context initCtx = new InitialContext();
		Context ctx = (Context) initCtx.lookup("java:comp/env");
		
		// 2단계 - 커넥션 풀에서 커넥션 가져오기
		DataSource ds = (DataSource) ctx.lookup("jdbc/shop");
		Connection conn = ds.getConnection();
		
		String sql = "SELECT * FROM `customer`";
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery(sql);
		
		while(rs.next()){
			CustomerDTO dto = new CustomerDTO();
			dto.setCustId(rs.getString(1));
			dto.setName(rs.getString(2));
			dto.setHp(rs.getString(3));
			dto.setAddr(rs.getString(4));
			dto.setRdate(rs.getString(5));
			
			custs.add(dto);
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
<title>user1::list</title>
</head>
<body>
	<h3>user1 목록</h3>
	<a href="../../2.DBCP.jsp">처음으로</a>
	<a href="./register.jsp">등록하기</a>
	<table border="1">
		<tr>
			<th>아이디</th>
			<th>이름</th>
			<th>휴대폰</th>
			<th>주소</th>
			<th>등록일</th>
			<th>관리</th>
		</tr>
		
		<% for(CustomerDTO cust : custs){ %>
		<tr>
			<td><%= cust.getCustId() %></td>
			<td><%= cust.getName() %></td>
			<td><%= cust.getHp() %></td>
			<td><%= cust.getAddr() %></td>
			<td><%= cust.getRdate() %></td>
			<td>
				<a href="./modify.jsp?uid=<%=cust.getCustId() %>">수정</a>
				<a href="./delete.jsp?uid=<%=cust.getCustId() %>">삭제</a>

			</td>
		</tr>
		<%} %>
	</table>
</body>
</html>