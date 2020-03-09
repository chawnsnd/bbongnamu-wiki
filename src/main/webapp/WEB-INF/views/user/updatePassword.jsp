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
var passwordCheck2 = false;
$(document).ready(function(){
	$("#password_form").on("submit", function() {
		return false;
	});
	$("#form_password").on("keyup", function() {
		var reg = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,}$/;
		if (reg.test($(this).val())) { //정규식으로 바꿀 예정
			$("#password_check").text("사용할 수 있는 비밀번호입니다.");
			passwordCheck = true;
		} else {
			$("#password_check").text("영문, 숫자, 특수문자의 조합으로 8자 이상 설정해주세요.");
			passwordCheck = false;
		}
	});
	$("#form_password2").on("keyup", function() {
		if ($(this).val()==$("#form_password").val()) { //정규식으로 바꿀 예정
			$("#password_check2").text("");
			passwordCheck2 = true;
		} else {
			$("#password_check2").text("비밀번호가 일치하지 않습니다.");
			passwordCheck2 = false;
		}
	});
	$("#form_submit").on("click", function() {
		if (passwordCheck && passwordCheck2) {
			updatePassword();
		} else {
			alert("모든 값을 확인해주세요.");
		}
	});
})

function updatePassword() {
		$.ajax({
			url : "update-password",
			type : "post",
			data : {
				"oldPassword" : $("#form_oldpassword").val(),
				"newPassword" : $("#form_password").val()
			},
			dataType : "json",
			success : function(data) {
				if (data.result) {
					alert("비밀번호 변경이 성공했습니다.");
					location.href = "/bbongnamu/user/info";
				} else {
					alert("비밀번호 변경이 실패했습니다.");
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
#password_form{
	display: inline-block;
	margin-left: 230px;
}
#password_input{
	margin: 20px 0;
}
#password_input input {
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
			<h1>회원정보 (비밀번호 수정)</h1>
			<div class="btn_group nav">
				<button onclick="location.href='info'">회원정보</button>
				<button class="green fill" onclick="location.href='update-password'">비밀번호 수정</button>
				<button onclick="location.href='withdrawal'">탈퇴</button>
			</div>
			<form id="password_form">
				<div id="password_input">
					<div class="item">
					<div><b>현재 비밀번호</b></div>
					<div>
						<input type="password" name="oldPassword" id="form_oldpassword">
					</div>
					</div>
					<div class="item">
					<div><b>변경할 비밀번호</b></div>
					<div>
						<input type="password" name="newPassword" id="form_password">
						<div id="password_check"></div>
					</div>
					</div>
					<div class="item">
					<div><b>비밀번호 재입력</b></div>
					<div>
						<input type="password" id="form_password2">
						<div id="password_check2"></div>
					</div>
					</div>
				</div>
				<div id="btns">
					<input class="blue fill" type="submit" value="변경" id="form_submit">
				</div>
			</form>
		</article>
	</main>
<%@ include file="../layout/footer.jsp"%>
</body>
</html>