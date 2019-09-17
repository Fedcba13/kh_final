<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<section class="sec_bg">
	<article class="subPage inner">
		<h3 class="sub_tit">창업 신청</h3>
		<table class="tbl txt_center">
			<tr>
				<th>신청 아이디</th>
				<th>점주명</th>
				<th style="width:300x;">매장 주소</th>
				<th style="width:300x;">매장 상세주소</th>
				<th>매장 전화번호</th>
				<th><input type="button" value="승인" class="btn txt_center" style="width:70px;" /></th>
			</tr>
			<c:forEach items="${list }" var="m" >
			<tr>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
			</c:forEach>
		</table>
		${list[0].member.memberName}
		${list[0].memberId}
	</article>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>