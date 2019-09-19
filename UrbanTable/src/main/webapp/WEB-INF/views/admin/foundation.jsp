<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<script>
function approval(memberId, no){

	var bool = confirm("승인하시겠습니까");
	var marketName = $(".marketName"+no).val();
	console.log(marketName);
	
	if(!bool){
		return false;
	}
	
 	location.href="${pageContext.request.contextPath}/admin/updateMarket.do?memberId="+memberId+"&marketName="+marketName; 
	return true;
}
</script>
<section class="sec_bg">
	<article class="subPage inner">
		<h3 class="sub_tit">창업 신청</h3>
		<table class="tbl txt_center">
			<tr>
				<th>신청 아이디</th>
				<th>점주명</th>
				<th>지점명</th>
				<th style="width:300x;">매장 주소</th>
				<th style="width:300x;">매장 상세주소</th>
				<th>매장 전화번호</th>
				<th> </th>
			</tr>
			<c:forEach items="${list }" var="m" varStatus="vs">
					
			<tr>
				<td>${m.memberId}</td>
				<td>${m.member.memberName}</td>
				<c:if test="${m.marketName != null }">
				<td>${m.marketName }</td>
				</c:if>
				<c:if test="${m.marketName == null }">
				<td><input type="text" id="marketName${vs.index }"/></td>
				</c:if>
				<td>${m.marketAddress}</td>
				<td>${m.marketAddress2}</td>
				<td>${m.marketTelephone}</td>
				<td>
				<c:if test="${m.flag == 0 }">				
				<input type="button" value="승인" class="btn txt_center" style="width:70px;" onclick="approval('${m.memberId}', '${vs.index}') " />
				</c:if>
				</td>
			</tr>
			</c:forEach>
		</table>

	
	
	</article>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>