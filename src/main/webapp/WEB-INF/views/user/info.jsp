<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 - 뽕나무위키</title>
<link rel="shortcut icon" href="../resources/favicon.ico">
<style>
#infos{
	margin: 20px 0;
}
.item{
	margin-bottom: 15px;
}
</style>
</head>
<body>
<%@ include file="../layout/header.jsp"%>
	<main>
		<%@ include file="../layout/aside.jsp"%>
		<article>
			<h1>회원정보</h1>
			<div class="btn_group nav">
				<button class="green fill" onclick="location.href='info'">회원정보</button>
				<button onclick="location.href='update-password'">비밀번호 수정</button>
				<button onclick="location.href='withdrawal'">탈퇴</button>
			</div>
			<div id="infos">
				<div class="item">
				<div><b>아이디</b></div>
				<div>${user.id}</div>
				</div>
				<div class="item">
				<div><b>타입</b></div>
				<div>${user.type}</div>
				</div>
			</div>
		</article>
	</main>
<%@ include file="../layout/footer.jsp"%>
</body>
</html>