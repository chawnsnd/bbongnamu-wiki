<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 수정 - 뽕나무위키</title>
<link rel="shortcut icon" href="../resources/favicon.ico">
<script type="text/javascript" src="../resources/js/jquery-3.4.1.min.js"></script>
<script>
var passwordCheck = false;
$(document).ready(function(){
	$("#withdrawal_form").on("submit", function() {
		return false;
	});
	$("#form_submit").on("click", function() {
		withdrawal();
	});
})

function withdrawal() {
		$.ajax({
			url : "withdrawal",
			type : "post",
			data : {
				"password" : $("#form_password").val(),
			},
			dataType : "json",
			success : function(data) {
				if (data.result) {
					alert("계정이 삭제되었습니다.");
					location.href = "/bbongnamu/user/logout";
				} else {
					alert("계정삭제가 실패하였습니다.");
					console.log(data.msg);
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
#withdrawal_form{
	display: inline-block;
	margin-left: 230px;
}
#withdrawal_input{
	margin: 20px 0;
}
#withdrawal_input input {
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
			<h1>회원정보 (탈퇴)</h1>
			<div class="btn_group nav">
				<button onclick="location.href='info'">회원정보</button>
				<button onclick="location.href='update-password'">비밀번호 수정</button>
				<button class="green fill" onclick="location.href='withdrawal'">탈퇴</button>
			</div>
			<form id="withdrawal_form">
				<div id="withdrawal_input">
					<div class="item">
					<div><b>비밀번호</b></div>
					<div><input type="password" name="password" id="form_password"></div>
					</div>
				</div>
				<div id="btns"><input class="red fill" type="submit" value="탈퇴" id="form_submit"></div>
			</form>
		</article>
	</main>
<%@ include file="../layout/footer.jsp"%>
</body>
</html>