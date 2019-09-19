<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/marketOwner.css">
<script>
	function cancelFounded(){
		if(!confirm("정말 취소하시겠습니까?")){
			return;
		}
		
		$("form[name=cancelFoundedFrm]").submit();
	}
</script>
<section>
	<form action="${pageContext.request.contextPath }/market/cancelFounded.do" name="cancelFoundedFrm" method="post">
		<input type="hidden" name="marketNo" value="${founded.marketNo}" />
	</form>
	<article class="subPage inner">
	    <h3 class="sub_tit">창업 신청 내역</h3>
        <table class="tbl tbl_view">
            <tr>
                <th>신청 아이디</th>
                <td>${founded.memberId}</td>
            </tr>
            <tr>
                <th>신청자명</th>
                <td>${founded.member.memberName}</td>
            </tr>
            <tr>
                <th>연락처</th>
                <td>${founded.marketTelephone}</td>
            </tr>
            <tr>
                <th>창업 희망 주소</th>
                <td>${founded.marketAddress}, ${founded.marketAddress2}</td>
            </tr>
            <tr>
            	<th>진행 상황</th>
            	<td>
            		<c:if test="${0 eq founded.flag }">
            			본사 검토 중
            		</c:if>
            		<c:if test="${1 eq founded.flag }">
            			본사 승인·오픈 대기중
            		</c:if>
            	</td>
            </tr>
        </table>
        <c:if test="${0 eq founded.flag }">
        	<div class="founded_btn txt_center">
        		<a href="${pageContext.request.contextPath}/market/updateFounded.do?memberId=${founded.memberId}" class="dp_block btn">창업 신청 정보 수정</a>
        		<button class="dp_ib btn btn2" onclick="cancelFounded();">신청 취소</button>
        	</div>
        </c:if>
    </article>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>