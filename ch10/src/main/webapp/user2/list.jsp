<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>user2List</title>
	</head>
	<body>
		<h3>user2 목록</h3>
		<a href="/ch10/index.jsp">처음으로</a>
		<a href="/ch10/user2/register.do">등록하기</a>
		<table border="1">
			<tr>
				<th>아이디</th>
				<th>이름</th>
				<th>생년월일</th>
				<th>주소</th>
				<th>관리</th>
			</tr>
			<c:forEach var="user" items="${users}">
			<tr>
			<!-- 표현언어에서는 직접 private 속성을 참조할 수 있음 -->
				<td>${user.getUid()}</td>
				<td>${user.getName()}</td>
				<td>${user.birth}</td>
				<td>${user.addr}</td>
				<td>
					<a href="/ch10/user2/modify.do?uid=${user.uid}">수정</a>
					<a href="/ch10/user2/delete.do?uid=${user.uid}">삭제</a>
				</td>
			</tr>
			</c:forEach>
		</table>
	</body>
</html>