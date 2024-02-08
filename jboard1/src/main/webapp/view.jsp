<%@page import="java.util.List"%>
<%@page import="kr.co.jboard1.dto.ArticleDTO"%>
<%@page import="kr.co.jboard1.dao.ArticleDAO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
String no = request.getParameter("no");

ArticleDAO dao = ArticleDAO.getInstance();

// 글 조회
ArticleDTO article = dao.selectArticle(no);

// 글 조회 카운트 업데이트
dao.updateHitCount(no);

// 댓글 조회
List<ArticleDTO> comments = dao.selectComments(no);
%>

<%@ include file="./_header.jsp"%>
<script>
	window.onload = function(){
		// 삭제, 수정 버튼은 작성자에게만 보임 -> 이외의 다른 이용자에게는 보이지않음
		// 보이지 않는 이용자는 스크립트에서 해당 태그를 찾을 수 없어 오류 -> 존재 할때만 스크립트가 실행되도록
		
		// 원글 삭제
		const btnDelete = document.querySelector('.btnDelete');
		if(btnDelete !== null){
			
			btnDelete.onclick = () => {
				/*
				if(confirm('정말 삭제하시겠습니까?')){
					return true;
				}else{
					return false;
				}
				*/
				return confirm('정말 삭제하시겠습니까?');
			}
		}

		
		// 댓글 작성 취소
		const btnCancel = document.getElementsByClassName('btnCancel')[0];
		
		btnCancel.onclick = function(e){
			
			e.preventDefault(); // a 태그 href 기능 제거(이벤트 사용)
			
			document.frmComment.reset();  // 폼 초기화
			
		}
		
		// 댓글 삭제
		
		const del = document.querySelectorAll('.del');
		if(del !== null){
			
			del.forEach((item)=>{
				item.onclick = function(){
					// true : 작업 진행, false : 작업 취소
					// 표준 이벤트 모델(addEventListener)은 작업취소 안됨
					
					return confirm('정말 삭제 하시겠습니까?');
				}
			});
		}
		
		
	}
	
</script>
<main>
	<section class="view">
		<h3>글보기</h3>
		<table>
			<tr>
				<td>제목</td>
				<td><input type="text" name="title" value="<%=article.getTitle()%>" readonly /></td>
			</tr>
			<%
			if (article.getFile() > 0) {
			%>
			<tr>
				<td>첨부파일</td>
				<td><a href="#">2020년 상반기 매출자료.xls</a> <span>7회 다운로드</span></td>
			</tr>
			<%
			}
			%>
			<tr>
				<td>내용</td>
				<td><textarea name="content" readonly><%=article.getContent()%></textarea></td>
			</tr>
		</table>
		
		<div>
			<% if (article.getWriter().equals(sessUser.getUid())) {	%>
			<a href="/jboard1/proc/deleteProc.jsp?no=<%= article.getNo() %>" class="btnDelete">삭제</a> 
			<a href="#" class="btnModify">수정</a>
			<%} %>

			<a href="/jboard1/list.jsp" class="btnList">목록</a>
		</div>

		<!-- 댓글리스트 -->
		<section class="commentList">
			<h3>댓글목록</h3>
			<%
			for (ArticleDTO comment : comments) {
			%>
			<article class="comment">
				<span>
					<span><%=comment.getNick()%></span>
					<span><%=comment.getRdate().substring(2, 10)%></span>
				</span>
			<textarea name="comment" readonly><%=comment.getContent()%></textarea>
			<%
				if (comment.getWriter().equals(sessUser.getUid())) {
			%>
			<div>
				<a href="/jboard1/proc/commentDelete.jsp?parent=<%=comment.getParent()%>&no=<%=comment.getNo()%>" class="del">삭제</a>
				<a href="#">수정</a>
			</div>
			<%
				}
			%>
			</article>
			<%
			}
			%>

			<%
			if (comments.isEmpty()) {
			%>
			<p class="empty">등록된 댓글이 없습니다.</p>
			<%
			}
			%>
		</section>

		<!-- 댓글입력폼 -->
		<section class="commentForm">
			<h3>댓글쓰기</h3>
			<form action="/jboard1/proc/commentInsert.jsp" name="frmComment"
				method="post">
				<input type="hidden" name="parent" value="<%=no%>">
				<input type="hidden" name="writer" value="<%=sessUser.getUid()%>">
				<textarea name="content"></textarea>
				<div>
					<a href="#" class="btnCancel">취소</a> <input type="submit" class="btnWrite" value="작성완료" />
				</div>
			</form>
		</section>
	</section>
</main>
<%@ include file="./_footer.jsp"%>