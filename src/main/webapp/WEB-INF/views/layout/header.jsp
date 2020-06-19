<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<header>
<script type="text/javascript" src="../resources/js/jquery-3.4.1.min.js"></script>
<link href="<c:url value='/resources/css/layout.css'/>" type="text/css" rel="stylesheet">
<link href="<c:url value='/resources/css/element.css'/>" type="text/css" rel="stylesheet">
<script src="https://kit.fontawesome.com/74fba7f134.js"crossorigin="anonymous"></script>
<script>
function checkHeaderSearch(){
	if($("#search_wiki").val()==""){
		return false;
	}
	return true;
}
</script>
<style>
header {
	overflow: hidden;
}
#header_container{
	max-width: 1325px;
	margin: auto;
}
#left{
	float: left;
	font-size: 25px;
	font-weight: bold;
}
#right {
	float: right;
}
#right *{
	font-size: 15px;
}
#header_search_form{
	display: inline-flex;
}

</style>
<div id="header_container">
	<div id="left" class="pointer" onclick="location.href='<c:url value="/" />'">
		<img src="../resources/favicon.ico" id="logo">
		<span style="color: darkred;">뽕</span><span>나무위키</span>
	</div>
	<div id="right">
		<form id="header_search_form" action="<c:url value="/wiki/search" />" method="get" onsubmit="return checkHeaderSearch()">
			<input type="text" id="header_search_wiki" name="keyword"
				placeholder="위키 검색" style="flex: 3"> <button type="submit"
				id="header_search_wiki_submit" style="flex: 1"><i class="fas fa-search"></i></button>
		</form>
		<c:if test="${sessionScope.usernum == null}">
		<div class="btn_group">
			<button onclick="location.href='<c:url value="/user/login" />'"><i class="fas fa-sign-in-alt"></i></button>
		</div>
		</c:if>
		<c:if test="${sessionScope.usernum != null}">
		<div class="btn_group">
			<button onclick="location.href='<c:url value="/user/info" />'">${sessionScope.id}</button>
			<button onclick="location.href='<c:url value="/user/logout" />'"><i class="fas fa-sign-out-alt"></i></button>
		</div>
		</c:if>
	</div>
</div>
</header>