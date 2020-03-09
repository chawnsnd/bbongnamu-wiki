<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 - 뽕나무위키</title>
<link rel="shortcut icon" href="../resources/favicon.ico">
<script type="text/javascript" src="../resources/js/jquery-3.4.1.min.js"></script>
<script>
	var idCheck = false;
	var passwordCheck = false;
	var passwordCheck2 = false;
	$(document).ready(function() {
		$("#join_form").on("submit", function() {
			return false;
		});
		$("#form_id").on("keyup", function() {
			checkId($(this).val());
		});
		$("#form_password").on("keyup", function() {
			var reg = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,}$/;
			if (reg.test($(this).val())) { //정규식으로 바꿀 예정
				$("#password_check").text(
						"사용할 수 있는 비밀번호입니다.");
				passwordCheck = true;
			} else {
				$("#password_check")
						.text(
								"영문, 숫자, 특수문자의 조합으로 8자 이상 설정해주세요.");
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
			if (idCheck && passwordCheck && passwordCheck2) {
				join();
			} else {
				alert("가입에 실패했습니다.");
			}
		});
	});

	function checkId(id) {
		$.ajax({
			url : "idcheck",
			type : "get",
			data : {
				"id" : id
			},
			dataType : "json",
			success : function(data) {
				if (data.result) {
					$("#id_check").text("사용할 수 있는 아이디입니다.");
					idCheck = true;
				} else {
					$("#id_check").text("이미 등록된 아이디입니다.");
					idCheck = false;
				}
			},
			error : function(e) {
				alert("서버와 통신이 실패했습니다.");
				idCheck = false;
			}
		})
	}

	function join() {
		$.ajax({
			url : "join",
			type : "post",
			data : {
				"id" : $("#form_id").val(),
				"password" : $("#form_password").val()
			},
			dataType : "json",
			success : function(data) {
				if (data.result) {
					alert("가입이 성공했습니다.");
					location.href = "/bbongnamu";
				} else {
					alert("가입이 실패했습니다.");
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
#join_form{
	display: inline-block;
	margin-left: 230px;
}
#join_input{
	margin: 20px 0;
}
#join_input input {
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
			<h1>회원가입</h1>
			<form id="join_form">
				<div id="join_input">
					<div class="item">
					<div><b>아이디</b></div>
					<div>
						<input type="text" id="form_id" name="id">
						<div id="id_check"></div>
					</div>
					</div>
					<div class="item">
					<div><b>비밀번호</b></div>
					<div>
						<input type="password" id="form_password" name="password">
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
					<div><input class="blue fill" type="submit" id="form_submit" value="회원가입"></div>
				</div>
			</form>
		</article>
	</main>
	<%@ include file="../layout/footer.jsp"%>
</body>
</html>