<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/marketOwner.css">
<script src="${pageContext.request.contextPath }/resources/js/founded.js"></script>

<section>
	<article class="subPage inner">
		<h3 class="sub_tit">창업 신청</h3>
    	<p class="info txt_right"><span class="red">*</span>은 필수 항목입니다.</p>
	    <form name="foundedFrm" action="${pageContext.request.contextPath}/market/updateFoundedEnd.do" method="post">
	        <table class="tbl tbl_view">
	            <tr>
	                <th><span class="red">*</span>신청 아이디</th>
	                <td><input type="text" name="memberId" id="memberId" value="${founded.memberId}" readonly required class="dp_block" required style="width:200px;" /></td>
	            </tr>
	            <tr>
	                <th><span class="red">*</span>신청자명</th>
	                <td><input type="text" name="marketMemberName" id="marketMemberName" value="${founded.member.memberName}" readonly required class="dp_block" style="width:200px;" /></td>
	            </tr>
	            <tr>
	                <th><span class="red">*</span>연락처</th>
	                <td><input type="text" name="marketTelephone" id="marketMemberPhone" value="${founded.member.memberPhone}" required class="dp_block" style="width:200px;" /></td>
	            </tr>
	            <tr>
	                <th><span class="red">*</span>창업 희망 주소</th>
	                <td>
						<input type="text" id="marketAddress" name="marketAddress" value="${founded.marketAddress}" placeholder="주소" class="mb10" required>
						<input type="button" onclick="sample6_execDaumPostcode()" value="주소 검색" required class="btn postBtn fw400 mb10"><br>
						<input type="text" id="marketAddress2" name="marketAddress2" placeholder="상세주소" value="${founded.marketAddress2}" required>
	                </td>
	            </tr>
	        </table>
	        <div class="founded_btn txt_center"><input type="submit" value="수정" class="btn" /></div>
        </form>
    </article>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>