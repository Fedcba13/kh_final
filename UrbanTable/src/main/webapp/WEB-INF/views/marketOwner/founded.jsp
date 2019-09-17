<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/marketOwner.css">
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("marketAddress1").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("marketAddress2").focus();
            }
        }).open();
    }
</script>

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
	                	<input type="text" id="sample6_postcode" placeholder="우편번호" class="mb10">
						<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="btn postBtn fw400 mb10"><br>
						<input type="text" id="marketAddress1" name="marketAddress1" placeholder="주소" class="mb10"><br>
						<input type="text" id="marketAddress2" name="marketAddress2" placeholder="상세주소">
						<input type="text" id="sample6_extraAddress" placeholder="참고항목">
	                </td>
	            </tr>
	        </table>
	        <div class="founded_btn txt_center"><input type="submit" value="신청" class="btn" /></div>
        </form>
    </article>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>