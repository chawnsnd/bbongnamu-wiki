<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>뽕나무위키</title>
<link rel="shortcut icon" href="../resources/favicon.ico">
</head>
<body>
	<%@ include file="../layout/header.jsp"%>
		<main>
	<%@ include file="../layout/aside.jsp"%>
	<article>
		<h1>${param.title}</h1>
		<h3>문서를 찾을 수 없습니다.</h3>
		문서를 새로 작성할 수 있습니다. <a href="edit?title=${param.title}">[새로운 문서 작성하기]</a>
	</article>
	</main>
	<%@ include file="../layout/footer.jsp"%>
</body>
</html>