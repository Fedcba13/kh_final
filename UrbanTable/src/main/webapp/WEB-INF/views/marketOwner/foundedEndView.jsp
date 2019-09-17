<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<section>
	<article class="subPage inner">
	    <h3 class="sub_tit">창업 신청 상세보기</h3>
	    <p class="txt_center">창업 신청이 다음과 같이 완료되었습니다.</p>
        <table class="tbl tbl_view">
            <tr>
                <th><span class="red">*</span>신청 아이디</th>
                <td><input type="text" name="marketMemberId" id="marketMemberId" value="로그인한 아이디" class="dp_block" required style="width:200px;" /></td>
            </tr>
            <tr>
                <th><span class="red">*</span>신청자명</th>
                <td><input type="text" name="marketMemberName" id="marketMemberName" value="로그인한 아이디의 이름" required class="dp_block" style="width:200px;" /></td>
            </tr>
            <tr>
                <th><span class="red">*</span>주민번호</th>
                <td><input type="text" name="marketResident" id="marketResident" class="dp_block" required style="width:200px;" /></td>
            </tr>
            <tr>
                <th><span class="red">*</span>연락처</th>
                <td><input type="text" name="marketTelephone" id="marketMemberPhone" value="로그인한 아이디의 전화번호" required class="dp_block" style="width:200px;" /></td>
            </tr>
            <tr>
                <th><span class="red">*</span>창업 희망 주소</th>
                <td>
                	<input type="text" id="sample6_postcode" placeholder="우편번호" class="mb10">
					<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" required class="btn postBtn fw400 mb10"><br>
					<input type="text" id="marketAddress" name="marketAddress" placeholder="주소" class="mb10" required><br>
					<input type="text" id="marketAddress2" name="marketAddress2" placeholder="상세주소" required>
					<input type="text" id="sample6_extraAddress" placeholder="참고항목">
                </td>
            </tr>
        </table>
    </article>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>