<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${wiki.title} - 뽕나무위키</title>
<link rel="shortcut icon" href="../resources/favicon.ico">
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script src="../resources/js/jquery-3.4.1.min.js"></script>
<script type='text/javascript'>
$(document).ready(function(){
	var title = $("#title").html();
	var content = htmlToText($("#content").html());
	kakaoShare(title, content);
	facebookShare(document, 'script', 'facebook-jssdk');
	$("#facebook-share").on("click", function(){
		FB.ui({
			method: 'share_open_graph',
			action_type: 'og.shares',
			action_properties: JSON.stringify({
				object: {
					'og:url': 'http://3.34.15.30',
					'og:title': title,
					'og:description': content
				}
			})
		});
	})
});
function kakaoShare(title, content){
	Kakao.init('827d5257449d52e0889af42ee0ca6982');
	Kakao.Link.createCustomButton({
		container: '#kakao-link-btn',
		templateId: 21153,
		templateArgs: {
			'title': title,
			'description': content
		}
	});
}
function facebookShare(d, s, id) {
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) return;
    js = d.createElement(s); js.id = id;
    js.src = "https://connect.facebook.net/en_US/sdk.js#xfbml=1&version=v3.0&appId=785037008571139";
    fjs.parentNode.insertBefore(js, fjs);
  }
function htmlToText(html) {
    var tag = document.createElement('div');
    tag.innerHTML = html;
    return tag.innerText;
}

</script>
<style>
.share img{
	width: 24px;
	height: 24px;
	cursor: pointer;
}
.share{
	display: inline-block;
	float: right;
}
</style>
</head>
<body>
	<%@ include file="../layout/header.jsp"%>
	<main>
	<%@ include file="../layout/aside.jsp"%>
	<article>
		<h1 class="pointer underline" onclick="location.href='view?title=${wiki.title}'">
			<span id="title">${wiki.title}</span>
			<c:if test="${wiki.historynum != 0}"> (r${wiki.historynum})</c:if>
		</h1>
		<div class="btn_group">
			<button class="green" onclick="location.href='edit?title=${wiki.title}'">편집</button>
			<button class="green" onclick="location.href='history?title=${wiki.title}'">역사</button>
		</div>
		<div class="share">
			<a id="kakao-link-btn">
				<img src="//developers.kakao.com/assets/img/about/logos/kakaolink/kakaolink_btn_medium.png"/>
			</a>
			<a id="facebook-share">
				<img src="../resources/img/facebook_icon.png"/>
			</a>
		</div>
		<hr>
		<c:if test="${wiki.historytype == 'DELETE' }">
		<p>이미 삭제된 문서입니다.</p>
		</c:if>
		<div id="content">${wiki.content}</div>
	</article>
	</main>
	<%@ include file="../layout/footer.jsp"%>
</body>
</html>

