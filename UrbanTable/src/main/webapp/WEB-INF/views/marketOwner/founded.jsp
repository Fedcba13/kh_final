<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/marketOwner.css">

<section>
	<article class="subPage inner">
	    <h3 class="sub_tit">창업 신청</h3>
	    <form action="">
	        <table class="tbl tbl_view">
	            <tr>
	                <th>신청 아이디</th>
	                <td><input type="text" name="marketMemberId" id="marketMemberId" value="로그인한 아이디" class="dp_block" style="width:200px;" /></td>
	            </tr>
	            <tr>
	                <th>신청자명</th>
	                <td><input type="text" name="marketMemberName" id="marketMemberName" value="로그인한 아이디의 이름" class="dp_block" style="width:200px;" /></td>
	            </tr>
	            <tr>
	                <th>주민번호</th>
	                <td><input type="text" name="marketResident" id="marketResident" class="dp_block" style="width:200px;" /></td>
	            </tr>
	            <tr>
	                <th>연락처</th>
	                <td><input type="text" name="marketMemberPhone" id="marketMemberPhone" value="로그인한 아이디의 전화번호" class="dp_block" style="width:200px;" /></td>
	            </tr>
	            <tr>
	                <th>창업 희망 주소</th>
	                <td>
	                	<input type="text" name="marketAddress1" id="marketAddress1" placeholder="기본 주소" class="dp_block w100" style="margin-bottom:10px;" />
	                	<input type="text" name="marketAddress2" id="marketAddress2" placeholder="상세 주소" class="dp_block w100" />
	                </td>
	            </tr>
	        </table>
	        <div class="founded_btn txt_center"><input type="submit" value="신청" class="btn" /></div>
        </form>
    </article>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>