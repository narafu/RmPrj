<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<section class="notice-review">
	<h1 class="hidden">게시판 관리</h1>
	<div class="container">
		<div class="title">게시판 관리</div>

		<div class="container-table">
			<form action="list" method="get">
				<div class="top-btn">
					<div class="date-btn">
						<input type="date" name="sd" value="${param.sd}"> <input type="date" name="ed"
							value="${param.ed}"> <input type="submit" value="검색">
					</div>
					<div class="search-btn flex">
						<select name="f" id="">
							<option ${param.f == "title" ? "selected" : "" }value="title">제목</option>
							<option ${param.f == "content" ? "selected" : "" } value="content">내용</option>
							<option ${param.f == "nickname" ? "selected" : "" } value="nickname">작성자</option>
						</select> <input type="text" name="s" placeholder="" value="${param.s}">
						<input type="submit" value="검색">
					</div>
				</div>
			</form>
		</div>

		<form action="list" method="post">
			<table class="notice-table">
				<thead>
					<tr>
						<td>No.</td>
						<td>제목</td>
						<td>작성자</td>
						<td>작성일</td>
						<td>조회수</td>
						<td>삭제</td>
					</tr>
				</thead>
				<tbody>

					<c:forEach var="l" items="${list}">
						<tr>
							<td>${l.id}</td>
							<td><a href="${l.id}">${l.title}</a></td>
							<td>${l.nickname}</td>
							<td>${l.regdate}</td>
							<td>${l.hit}</td>
							<td><input type="checkbox" name="delId" value="${l.id}"></td>
						</tr>
					</c:forEach>

				</tbody>
			</table>

			<c:set var="page" value="${(empty param.p)?1:param.p}" />
			<c:set var="startNum" value="${page-(page-1)%5}" />
			<c:set var="lastNum" value="${fn:substringBefore(Math.ceil(count/10),'.')}" />

			<div class="bottom-btn">
				<div class="list">
					<div class="current">${page}</div>
					<div>/</div>
					<div>${lastNum}</div>
					<div>pages</div>
				</div>
				<div class="three-btn">
					<input type="submit" value="삭제" name="btn">
				</div>
			</div>
		</form>

		<div class="pager">
			<c:choose>
				<c:when test="${startNum>1}">
					<a href="list?m=${param.m}&p=${startNum-5}&s=${param.s}"> <i
							class="fas fa-arrow-circle-left fa-2x"></i>
					</a>
				</c:when>
				<c:otherwise>
					<i class="fas fa-arrow-circle-left fa-2x" onclick="alert('이전 페이지가 없습니다.');"></i>
				</c:otherwise>
			</c:choose>

			<ul class="flex">
				<c:forEach begin="0" end="4" var="i">
					<c:if test="${startNum+i<=lastNum}">
						<li><a class="${(page==startNum+i)?'current':''}"
								href="list?m=${param.m}&p=${startNum+i}&s=${param.s}">${startNum+i}</a>
						</li>
					</c:if>
				</c:forEach>
			</ul>

			<c:choose>
				<c:when test="${startNum+4<lastNum}">
					<a href="list?m=${param.m}&p=${startNum+5}&s=${param.s}"> <i
							class="fas a-arrow-circle-right fa-2x"></i>
					</a>
				</c:when>
				<c:otherwise>
					<i class="fas fa-arrow-circle-right fa-2x" onclick="alert('다음 페이지가 없습니다.');"></i>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</section>

<script>
	window.addEventListener("load", function () {

		var delBtn = document.querySelector("input[value='삭제']");

		delBtn.onclick = function (e) {

			if (confirm("삭제하시겠습니까?") == false) {
				e.preventDefault();
			} else {
				alert("삭제하였습니다.");
			}
		}

	})
</script>