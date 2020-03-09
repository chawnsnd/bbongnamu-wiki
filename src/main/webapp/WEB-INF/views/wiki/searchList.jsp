<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${keyword}검색결과- 뽕나무위키</title>
<link rel="shortcut icon" href="../resources/favicon.ico">
<script src="../resources/js/jquery-3.4.1.min.js"></script>
<script>
function movePage(page){
	if(page==null){
		page = 1;
	}
	location.href="search?keyword=${keyword}&page="+page;
}
function html2text(html) {
    var tag = document.createElement('div');
    tag.innerHTML = html;
    
    return tag.innerText;
}
$(document).ready(function(){	
	var contents = $(".wiki_content");
	$.each(contents, function(idx, content){
		var textContent = html2text(content.innerHTML);
		$(this).html(textContent);
	});
});
</script>
<style>
.wiki{
	cursor: pointer;	
	border-top: 1px solid #ccc;
	border-bottom: 1px solid #ccc;
}
.wiki_title{
	font-weight: bold;
	font-size: 20px;
	padding: 20px 0;
}
.wiki_content{
	text-overflow:ellipsis;
	white-space:nowrap;
	word-wrap:normal;
	overflow:hidden;
	max-height: 80px;
    word-break: break-all;	
}
#search_result{
	margin-bottom: 20px;
}
.cur_page {
	font-weight: bold;
}
</style>
</head>
<body>
	<%@ include file="../layout/header.jsp"%>
	<main>
		<%@ include file="../layout/aside.jsp"%>
		<article>
			<h1>"${keyword}" 검색결과</h1>
			> 찾는 문서가 없나요? 문서를 새로 작성할 수 있습니다. <a href="edit?title=${keyword}">[새로운
				문서 작성하기]</a>
			<hr>
			<div id="search_result">
			<c:if test="${wikisByTitle.size() == 0}">
			검색된 문서가 없습니다.
			</c:if>
			<c:if test="${wikisByTitle.size() > 0}">
				<c:forEach var="wiki" items="${wikisByTitle}">
				<div class="wiki" onclick="location.href='view?title=${wiki.title}'">
					<div class="wiki_title">[ ${wiki.title} ]</div>
					<div class="wiki_content">${wiki.content}</div>
				</div>
				</c:forEach>
			</c:if>
			</div>
			<div class="btn_group right">
				<c:forEach var="num" begin="${pageNavigator.startPageGroup }" end="${pageNavigator.endPageGroup}">
				<c:if test="${pageNavigator.currentPage == num}">
				<span class="btn blue fill" onclick="location.href='search?keyword=${keyword}&page=${num}'">${num}</span>
				</c:if>
				<c:if test="${pageNavigator.currentPage != num}">
				<span class="btn" onclick="movePage(${num})">${num}</span>
				</c:if>
				</c:forEach>
			</div> 
		</article>
	</main>
	<%@ include file="../layout/footer.jsp"%>
</body>
</html>