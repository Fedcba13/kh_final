<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<style>
input[type="date"], input[type="date"]::-webkit-inner-spin-button {
	border: 0;
	background: transparent;
	-webkit-appearance: none;
}

input.view {
	border: 0;
	background: transparent;
}

table.eventTBL {
	
}
</style>

<section>
	<article class="subPage inner">
		<h3 class="sub_tit">지점 이벤트 관리</h3>
		${list }
		<div class="txt_right">
			<a
				href="${pageContext.request.contextPath }/event/marketEventEnroll.do?memberId=${memberLoggedIn.memberId}"
				class="btn txt_center dp_block"> 이벤트 등록 </a>
		</div>

		<table class="tbl txt_center eventTBL">
			<tr>
				<th>이벤트 제목</th>
				<th>시작 일자</th>
				<th>종료 일자</th>
				<th>이벤트 품목</th>
				<th>적용 매장</th>
				<th></th>
			</tr>
			<tr>
				<th colspan="5">이벤트 내용</th>
				<th></th>
			</tr>
			<c:forEach items="${list }" var="e" varStatus="vs">
					
					<tr>
						<td>${e.eventTitle}</td>
						<td>${e.eventDateStart}</td>
						<td>${e.eventDateEnd }</td>
						<c:if test="${e.foodSection.foodSectionName eq null  }"><td style="color:#e9e9e9;">모든 품목</td></c:if>
						<c:if test="${e.foodSection.foodSectionName != null  }"><td>${e.foodSection.foodSectionName }</td></c:if>
						<c:if test="${e.market.marketName eq null }"><td style="color:#e9e9e9;">전체 매장</td></c:if>
						<td>${e.market.marketName }</td>
					</tr>
					<tr>
						<td colspan="5">${e.eventContent }</td>
						<td>
						<a href="${pageContext.request.contextPath }/event/deleteEvent.do?eventId=${e.eventId }" class="btn txt_center"> 삭제</a>
						</td>
					</tr>
			</c:forEach>
		</table>

	</article>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>