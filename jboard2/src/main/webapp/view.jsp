<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="./_header.jsp" %>
<script>
	window.onload =()=>{
		const btnRemove = document.getElementsByClassName('btnRemove')[0];
		btnRemove.onclick = () =>{
			if(confirm('삭제 하시겠습니까?')){
				return true;
			}else{
				return false;
			}
		}
	}
</script>
        <main id="board">
            <section class="view">
                
                <table border="0">
                    <caption>글보기</caption>
                    <tr>
                        <th>제목</th>
                        <td><input type="text" name="title" value="${article.getTitle()}" readonly/></td>
                    </tr>
                    <c:if test="${article.file > 0 }">
                    <tr>
                        <th>파일</th>
                        <td>
                        <c:forEach var="file" items="${article.fileDTOs}">
                        <a href="/jboard2/fileDownload.do?fno=${file.fno}">${file.oName}</a>&nbsp;<span>${file.download}</span>회 다운로드
                        </c:forEach>
                        </td>
                    </tr>
                    </c:if>
                    <tr>
                        <th>내용</th>
                        <td>
                            <textarea name="content" readonly>${article.getContent()}</textarea>
                        </td>
                    </tr>                    
                </table>
                
                <div>
                    <a href="/jboard2/delete.do?no=${article.getNo()}&&file=${article.file}" class="btn btnRemove">삭제</a>
                    <a href="/jboard2/modify.do?no=${article.getNo()}" class="btn btnModify">수정</a>
                    <a href="/jboard2/list.do" class="btn btnList">목록</a>
                </div>

                <!-- 댓글목록 -->
                <section class="commentList">
                    <h3>댓글목록</h3>                   
					
                    
                    <c:if test="${empty comments}">
                    	<p class="empty">등록된 댓글이 없습니다.</p>
                    </c:if>
                    
					<c:forEach var="comment" items="${comments}">
					<article>                    
						<span class="nick">${comment.nick}</span>
                        <span class="date">${comment.rdate}</span>
                        <p class="content">${comment.content}</p>                        
                        <div>
                            <a href="#" class="remove">삭제</a>
                            <a href="#" class="modify">수정</a>
                        </div>
                    </article>
					</c:forEach>

                </section>

                <!-- 댓글쓰기 -->
                <section class="commentForm">
                    <h3>댓글쓰기</h3>
                    <form action="#">
                        <textarea name="content">댓글내용 입력</textarea>
                        <div>
                            <a href="#" class="btn btnCancel">취소</a>
                            <input type="submit" value="작성완료" class="btn btnComplete"/>
                        </div>
                    </form>
                </section>

            </section>
        </main>
<%@ include file="./_footer.jsp" %>