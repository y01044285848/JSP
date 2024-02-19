<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="java.io.File"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%

	request.setCharacterEncoding("UTF-8");
	String fno = request.getParameter("fno");
	
	String fileName = "";
	
	// 데이터베이스 삭제
	try{
		// 1단계 JNDI(java naming directory interface) 서비스 객체 생성
		Context ctx = (Context) new InitialContext().lookup("java:comp/env");
		
		// 2단계 - 커넥션 풀에서 커넥션 가져오기
		DataSource ds = (DataSource) ctx.lookup("jdbc/studydb");
		Connection conn = ds.getConnection();
		
		String selectSQL = "SELECT `sName` FROM `FileTest` WHERE `fno` = " + fno;
		String deleteSQL = "DELETE FROM `FileTest` WHERE `fno`="+fno;
		
		Statement selectStmt = conn.createStatement();
		Statement deleteStmt = conn.createStatement();
		
		conn.setAutoCommit(false);
		
		ResultSet rs = selectStmt.executeQuery(selectSQL);
		deleteStmt.executeUpdate(deleteSQL);
		
		
		if(rs.next()){
			fileName = rs.getString(1);
			System.out.println(fileName);
			// 파일 삭제
			String filePath = application.getRealPath("/uploads");
			filePath += fileName;
			File f = new File(filePath); // 파일 객체생성
			if(f.exists()) f.delete(); // 파일이 존재하면 파일을 삭제한다.
		}
		
		conn.commit();
		
		rs.close();
		selectStmt.close();
		deleteStmt.close();
		conn.close();
		
		
	}catch(Exception e){
		e.printStackTrace();
	}
	
	response.sendRedirect("../2.fileDownloadTest.jsp");
%>