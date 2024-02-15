<%@page import="com.google.gson.JsonObject"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="dto.User1DTO"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.io.BufferedReader"%>
<%@ page contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	/*
	
	String uid = request.getParameter("uid");
	String name = request.getParameter("name");
	String birth = request.getParameter("birth");
	String age = request.getParameter("age");
	String hp = request.getParameter("hp");
	*/
	// request Body JSON 문자열 스트림 처리
	request.setCharacterEncoding("UTF-8");
	
	BufferedReader reader = request.getReader();
	StringBuilder requestBody = new StringBuilder();
	String line;
	while((line = reader.readLine()) != null){
		requestBody.append(line);
	}
	reader.close();
	
	// System.out.println(requestBody.toString());
	
	//JSON 파싱
	Gson gson = new Gson();
	User1DTO user1 = gson.fromJson(requestBody.toString(), User1DTO.class);
	// System.out.println(user1);
	
	// 1단계 JNDI 서비스 객체 생성
	Context ctx = (Context) new InitialContext().lookup("java:comp/env");
	
	// 2단계 커넥션풀 객체 생성
	DataSource ds = (DataSource) ctx.lookup("jdbc/studydb");
	
	Connection conn = ds.getConnection();
	PreparedStatement psmt = conn.prepareStatement("INSERT INTO `User1` VALUES (?,?,?,?,?)");
	
	psmt.setString(1, user1.getUid());
	psmt.setString(2, user1.getName());
	psmt.setString(3, user1.getBirth());
	psmt.setString(4, user1.getHp());
	psmt.setInt(5, user1.getAge());
	
	// row count 반환
	int result = psmt.executeUpdate();
	System.out.println("result : " + result);
	
	psmt.close();
	conn.close();
	
	// JSON 출력
	JsonObject json = new JsonObject();
	json.addProperty("result",result);
	out.print(json.toString());
	
	
%>