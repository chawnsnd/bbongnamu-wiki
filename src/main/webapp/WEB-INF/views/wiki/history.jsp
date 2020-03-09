<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${title}(역사)- 뽕나무위키</title>
<link rel="shortcut icon" href="../resources/favicon.ico">
</head>
<body>
	<%@ include file="../layout/header.jsp"%>
	<main>
		<%@ include file="../layout/aside.jsp"%>
		<article>
			<h1 class="pointer underline" onclick="location.href='view?title=${title}'">${title} (역사)</h1>
			<div class="btn_group">
				<c:if test="${pageNavigator.totalPageCount == 1}">
				<button class="disabled">이전</button>
				<button class="disabled">다음</button>
				</c:if>
				<c:if test="${pageNavigator.totalPageCount != 1}">
					<c:if test="${pageNavigator.currentPage<=1}">
					<button class="disabled">이전</button>
					<button class="active" onclick="location.href='history?title=${title}&page=${pageNavigator.currentPage+1}'">다음</button>
					</c:if>
					<c:if test="${pageNavigator.currentPage>1 && pageNavigator.currentPage<pageNavigator.totalPageCount}">
					<button class="active" onclick="location.href='history?title=${title}&page=${pageNavigator.currentPage-1}'">이전</button>
					<button class="active" onclick="location.href='history?title=${title}&page=${pageNavigator.currentPage+1}'">다음</button>
					</c:if>
					<c:if test="${pageNavigator.currentPage>=pageNavigator.totalPageCount}">
					<button class="active" onclick="location.href='history?title=${title}&page=${pageNavigator.currentPage-1}'">이전</button>
					<button class="disabled">다음</button>
					</c:if>
				</c:if>
			</div>
			<c:forEach var="history" items="${histories}">
				<ul>
					<li>${history.writedate}(
					<a href="view?title=${title}&historynum=${history.num}">보기</a> | 
					<a href="revert?title=${title}&historynum=${history.num}">이 리비전으로 되돌리기</a>) 
					<c:if test="${history.type == 'REVERT' }">
						(r${history.revertnum}으로 되돌림)
					</c:if>
					<c:if test="${history.type == 'DELETE' }">
						(삭제됨)
					</c:if> 
					<c:if test="${history.type == 'CREATE' }">
						(생성됨)
					</c:if>
					r${history.num} ${history.userId} 
					<c:if test="${history.explanation != null}">
						(${history.explanation})
					</c:if>
					</li>
				</ul>
			</c:forEach>
			<div class="btn_group">
				<c:if test="${pageNavigator.totalPageCount == 1}">
				<button class="disabled">이전</button>
				<button class="disabled">다음</button>
				</c:if>
				<c:if test="${pageNavigator.totalPageCount != 1}">
					<c:if test="${pageNavigator.currentPage<=1}">
					<button class="disabled">이전</button>
					<button class="active" onclick="location.href='history?title=${title}&page=${pageNavigator.currentPage+1}'">다음</button>
					</c:if>
					<c:if test="${pageNavigator.currentPage>1 && pageNavigator.currentPage<pageNavigator.totalPageCount}">
					<button class="active" onclick="location.href='history?title=${title}&page=${pageNavigator.currentPage-1}'">이전</button>
					<button class="active" onclick="location.href='history?title=${title}&page=${pageNavigator.currentPage+1}'">다음</button>
					</c:if>
					<c:if test="${pageNavigator.currentPage>=pageNavigator.totalPageCount}">
					<button class="active" onclick="location.href='history?title=${title}&page=${pageNavigator.currentPage-1}'">이전</button>
					<button class="disabled">다음</button>
					</c:if>
				</c:if>
			</div>
		</article>
	</main>
	<%@ include file="../layout/footer.jsp"%>
</body>
</html>