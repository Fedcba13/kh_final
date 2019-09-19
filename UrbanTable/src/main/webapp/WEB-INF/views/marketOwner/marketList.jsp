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
	    <h3 class="sub_tit">매장 리스트</h3>
	    <div>
	    	<form action="" name="marketSearchFrm" method="get" class="searchFrm">
    			<select name="orderSearchType" id="orderSearchType" class="dp_ib">
	    			<option value="orderNo">지점명</option>
	    			<option value="orderID">주문자 ID</option>
	    			<option value="orderPhone">주문자 연락처</option>
	    		</select>
	    		<input type="text" class="dp_ib" style="width:218px; padding-right:40px;" />
	    		<input type="submit" value="검색" class="dp_ib txt_center" />
	    	</form>
	    </div>
	    <p class="info txt_right"><span class="red">*</span>우리집과의 거리는 회원 정보에 기재된 주소로 계산됩니다.</p>
	    <table class="tbl txt_center">
            <tr>
                <th width="80">번호</th>
                <th width="185">지점명</th>
                <th>지점 주소</th>
                <th width="185">전화번호</th>
                <th width="180">우리집과의 거리</th>
            </tr>
            <tr>
                <td>컬럼 내용</td>
                <td>컬럼 내용</td>
                <td class="mapAddress">컬럼 내용&nbsp;&nbsp;<img src="${pageContext.request.contextPath}/resources/images/location.png" alt="" /></td>
                <td>컬럼 내용</td>
                <td>컬럼 내용</td>
            </tr>
        </table>
    </article>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>