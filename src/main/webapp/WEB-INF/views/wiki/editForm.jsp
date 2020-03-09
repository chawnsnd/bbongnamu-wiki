<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${wiki.title}(편집)- 뽕나무위키</title>
<link rel="shortcut icon" href="../resources/favicon.ico">
<script src="../resources/ckeditor/ckeditor.js"></script>
<script src="../resources/js/jquery-3.4.1.min.js"></script>
<script>
$(document).ready(function(){
	CKEDITOR.config.width = "100%";
	CKEDITOR.config.height = 500;
	CKEDITOR.config.resize_enabled = false;
	CKEDITOR.replace('textarea_content');	
})
	function check() {
		if ($("#agree_check").is(":checked")) {
			return true;
		} else {
			alert("문서를 저장하려면 동의에 체크해야 합니다.");
			return false;
		}
	}
</script>
<style>
#explanation_input {
	width: 100%;
}
</style>
</head>
<body>
	<%@ include file="../layout/header.jsp"%>
	<main>
		<%@ include file="../layout/aside.jsp"%>
		<article>
			<h1 class="pointer underline" onclick="location.href='view?title=${wiki.title}'">${wiki.title} (편집)
			</h1>
			<div class="btn_group">
				<button class="red" onclick="location.href='delete?title=${wiki.title}'">삭제</button>
			</div>
			<form id="edit_form" action="edit" method="post"
				onsubmit="return check()">
				<p>
					<textarea name="content" id="textarea_content" rows="15" cols="80">${wiki.content}</textarea>
				</p>
				<p>
					설명<br> <input type="text" name="explanation"
						id="explanation_input">
				</p>
				<input type="text" name="title" value="${wiki.title}"
					hidden="hidden">
				<p>
					<label> <input type="checkbox" id="agree_check"> 문서
						편집을 저장하면 당신은 기여한 내용을 기여한 문서에 대한 하이퍼링크나 URL을 이용하여 저작자 표시를 하는 것으로
						충분하다는 데 동의하는 것입니다. 이 동의는 철회할 수 없습니다.
					</label>
				</p>
				<input class="blue fill right" type="submit" value="저장">
			</form>
		</article>
	</main>
	<%@ include file="../layout/footer.jsp"%>
</body>
</html>