<%@page import="java.io.BufferedOutputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.BufferedInputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="ch07.FileDTO"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	
	request.setCharacterEncoding("UTF-8");
	String fno = request.getParameter("fno");
	
	FileDTO fileDTO = null;
	
	try{
		// 데이터베이스 저장
		// 1단계 JNDI(java naming directory interface) 서비스 객체 생성
		Context ctx = (Context) new InitialContext().lookup("java:comp/env");
		
		// 2단계 - 커넥션 풀에서 커넥션 가져오기
		DataSource ds = (DataSource) ctx.lookup("jdbc/studydb");
		Connection conn = ds.getConnection();
		
		String sql = "SELECT * FROM `FileTest` WHERE `fno`="+fno;
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery(sql);
		
		while(rs.next()){
			fileDTO = new FileDTO();
			fileDTO.setFno(rs.getInt(1));
			fileDTO.setTitle(rs.getString(2));
			fileDTO.setoName(rs.getString(3));
			fileDTO.setsName(rs.getString(4));
			fileDTO.setRdate(rs.getString(5));
		}
		
		rs.close();
		stmt.close();
		conn.close();
		
		
	}catch(Exception e){
		e.printStackTrace();
	}
	
	// 다운로드 헤더 설정
	response.setContentType("application/octet-stream");  //8비트 스트림 선언
	response.setHeader("Content-Disposition", "attachment; filename="+URLEncoder.encode(fileDTO.getoName(), "utf-8"));
	response.setHeader("Content-Transfer-Encoding", "binary");
	response.setHeader("Pragma", "no-cache");
	response.setHeader("Cache-Control", "private");
	
	// response 파일 스트림 작업
	String uploadsPath = application.getRealPath("/uploads");
	File file = new File(uploadsPath + File.separator + fileDTO.getsName());
	
	out.clear();
	out = pageContext.pushBody();
	
	BufferedInputStream bis = new BufferedInputStream(new FileInputStream(file));
	BufferedOutputStream bos = new BufferedOutputStream(response.getOutputStream());
	
	while(true){
		int data = bis.read();
		if(data == -1){
			break;
		}
		bos.write(data);
	}
	bos.close();
	bis.close();
	
	
%>