<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="tag" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<tag:header/>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-gtEjrD/SeCtmISkJkNUaaKMoLD0//ElJ19smozuHV6z3Iehds+3Ulb9Bn9Plx0x4" crossorigin="anonymous"></script>
<body>
<tag:navbar/>
<div class="container py-4"> 
<a href = "boardRegist.wow" class="btn btn-primary">글 작성</a>
<table class="table">
  <thead>
    <tr>
      <th scope="col">글번호</th>
      <th scope="col">제목</th>
      <th scope="col">글분류</th>
      <th scope="col">추천수</th>
      <th scope="col">작성일</th>
      <th scope="col">아이디</th>
    </tr>
  </thead>
  <tbody>
  <c:forEach items="${boardList }" var="board">
		<tr>
			<td>${board.boNo }</td>
			<td><a href="boardView.wow?boNo=${board.boNo }">${board.boTitle }</a></td>
			<td>${board.boSubCate }</td>
			<td>${board.boHit }</td>
			<td>${board.boRegDate }</td>
			<td>${board.boMemId }</td>	
		</tr>
    	</c:forEach>
  </tbody>
</table>
</div>

</body>
</html>