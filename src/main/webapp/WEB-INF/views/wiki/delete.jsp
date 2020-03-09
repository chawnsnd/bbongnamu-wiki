<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${title}(삭제)- 뽕나무위키</title>
<link rel="shortcut icon" href="../resources/favicon.ico">
<script>
	function check() {
		if ($("#agree_check").is(":checked")) {
			return true;
		} else {
			alert("문서를 삭제하려면 동의에 체크해야 합니다.");
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
			<h1 class="pointer underline" onclick="location.href='view?title=${title}'">${title} (삭제)</h1>
			<form id="delete_form" action="delete" method="post" onsubmit="return check()">
				<p>
					설명<br>
					<input type="text" name="explanation" id="explanation_input">
				</p>
				<p>
					<label> <input type="checkbox" id="agree_check"> 
					문서 이동 목적이 아닌, 삭제하기 위함을 확인합니다.
					</label>
				</p>
				<input type="text" name="title" value="${title}" hidden="hidden">
				<input class="red right fill" type="submit" value="삭제">
			</form>
		</article>
	</main>
	<%@ include file="../layout/footer.jsp"%>
</body>
</html>