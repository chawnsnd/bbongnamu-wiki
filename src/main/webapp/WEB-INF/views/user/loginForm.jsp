<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 - 뽕나무위키</title>
<link rel="shortcut icon" href="../resources/favicon.ico">
<script type="text/javascript" src="../resources/js/jquery-3.4.1.min.js"></script>
<script>
$(document).ready(function(){
	$("#login_form").on("submit", function() {
		return false;
	});
	$("#form_submit").on("click", function() {
		login();
	});
})
function login() {
	$.ajax({
		url : "login",
		type : "post",
		data : {
			"id" : $("#form_id").val(),
			"password" : $("#form_password").val()
		},
		dataType : "json",
		success : function(data) {
			console.log(data);
			if (data.result) {
				location.href = "/bbongnamu";
			} else {
				$("#login_msg").text("가입되지 않은 아이디이거나, 잘못된 비밀번호입니다.");
			}
		},
		error : function(e) {
			alert("서버와 통신이 실패했습니다.");
			console.log(e);
		}
	})
}
</script>
<style>
#login_form{
	display: inline-block;
	margin-left: 230px;
}
#login_input{
	margin: 20px 0;
}
#login_input input {
	width: 500px;
	padding: 10px;
}
#btns{
	float: right;
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
			<h1>로그인</h1>
			<form id="login_form">
				<div id="login_input">
					<div class="item">
					<div><b>아이디</b></div>
					<div><input type="text" id="form_id" name="id"></div>
					</div>
					<div class="item">
					<div><b>비밀번호</b></div>
					<div><input type="password" id="form_password" name="password"></div>
					</div>
					<div class="item" id="login_msg"></div>
				</div>
				<div id="btns">
					<input class="blue fill" type="submit" id="form_submit" value="로그인">
					<button onclick="location.href='<c:url value="/user/join" />'">회원가입</button>
				</div>
			</form>
		</article>
	</main>
	<%@ include file="../layout/footer.jsp"%>
</body>
</html>