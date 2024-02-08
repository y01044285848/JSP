<%@page import="kr.co.jboard1.dao.ArticleDAO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String no = request.getParameter("no");
	String parent = request.getParameter("parent");
	
	ArticleDAO dao = ArticleDAO.getInstance();
	
	dao.deleteComment(no, parent);
	
	response.sendRedirect("/jboard1/view.jsp?no=" + parent);
%>