<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.FileItemFactory"%>
<%@page import="ch07.FileDTO"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="java.util.UUID"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>

<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//파일 입출력에서는 사용할 수 없는 형식
	/*
	request.setCharacterEncoding("UTF-8");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	String file = request.getParameter("file");
	
	System.out.println("title : " + title);
	System.out.println("content : " + content);
	System.out.println("file : " + file);
	*/
	
	// 파일 업로드 디렉토리 경로 설정
	String uploadPath = application.getRealPath("/uploads");
	
	// 파일 업로드 처리 객체 생성
	FileItemFactory factory = new DiskFileItemFactory();
	ServletFileUpload upload = new ServletFileUpload(factory);
	
	// 인코딩 설정
	upload.setHeaderEncoding("UTF-8");
	
	// 최대 파일 크기 설정
	upload.setSizeMax(1024*1024*10); // 10MB
	
	// 파일 객체 생성
	FileDTO fileDTO = new FileDTO();
	
	try{
		// 예외1. 파일 크기가 10MB 이상일 때
		
		// 파일 업로드 스트림 작업
		List<FileItem> items = upload.parseRequest(request);
		Iterator<FileItem> iter = items.iterator();
		
		while(iter.hasNext()){
			FileItem item = iter.next();
			
			// 첨부파일 일 경우
			if(!item.isFormField()){
				// 파일 업로드 처리
				String fileName = item.getName();
				int idx = fileName.lastIndexOf(".");
				String ext = fileName.substring(idx);
				
				// 중복 방지 파일명 생성
				String savedFileName = UUID.randomUUID().toString() + ext;
				fileDTO.setoName(fileName);
				fileDTO.setsName(savedFileName);
				
				File uploadedFile = new File(uploadPath + File.separator + savedFileName);
				item.write(uploadedFile);
				System.out.println("File upload!");
				
			}else{
				// 일반 데이터 처리
				String fieldName = item.getFieldName();
				String value = item.getString("UTF-8"); // request.getParameter
				
				System.out.println(fieldName+ " : " + value);
				
				if(fieldName.equals("title")){
					fileDTO.setTitle(value);
				}
				
			}
			
		}
		
	}catch(Exception e){
		e.printStackTrace();
	}
	
	
	try{
		// 데이터베이스 저장
		// 1단계 JNDI(java naming directory interface) 서비스 객체 생성
		Context ctx = (Context) new InitialContext().lookup("java:comp/env");
		
		// 2단계 - 커넥션 풀에서 커넥션 가져오기
		DataSource ds = (DataSource) ctx.lookup("jdbc/studydb");
		Connection conn = ds.getConnection();
		
		PreparedStatement psmt = conn.prepareStatement("INSERT INTO `FileTest` (`title`, `oName`, `sName`, `rdate`) VALUES(?,?,?,NOW())");
		psmt.setString(1, fileDTO.getTitle());
		psmt.setString(2, fileDTO.getoName());
		psmt.setString(3, fileDTO.getsName());
		
		psmt.executeUpdate();
		
		psmt.close();
		conn.close();
		
		
	}catch(Exception e){
		e.printStackTrace();
	}
	
	
	response.sendRedirect("../2.fileDownloadTest.jsp");
	

%>