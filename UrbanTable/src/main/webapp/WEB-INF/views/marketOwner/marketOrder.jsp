<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/marketOwner.css">
<section id="marketOrder">
	<article class="subPage inner">
	    <h3 class="sub_tit">주문 내역</h3>
	    <div class="orderSearch_wrap">
	    	<form action="" name="orderSearchFrm1" method="get">
    			<select name="orderSearchType" id="orderSearchType" class="dp_ib">
	    			<option value="orderNo">주문 번호</option>
	    			<option value="orderID">주문자 ID</option>
	    			<option value="orderPhone">주문자 연락처</option>
	    		</select>
	    		<input type="text" class="dp_ib" style="width:218px; padding-right:40px;" />
	    		<input type="submit" value="검색" class="dp_ib txt_center" />
	    	</form>
	    	<form action="" name="orderSearchFrm2" method="get" class="sec_bg">
	    		<div class="clearfix">
	    			<p class="fw600">주문 상태</p>
	    			<div>
	    				<input type="radio" name="orderState" value="전체" id="orderState1" />
	    				<label for="orderState1">전체</label>
	    				&nbsp;&nbsp;
	    				<input type="radio" name="orderState" value="주문" id="orderState2" />
	    				<label for="orderState2">주문</label>
	    				&nbsp;&nbsp;
	    				<input type="radio" name="orderState" value="입금 완료" id="orderState3" />
	    				<label for="orderState3">입금 완료</label>
	    				&nbsp;&nbsp;
	    				<input type="radio" name="orderState" value="배송 완료" id="orderState4" />
	    				<label for="orderState4">배송 완료</label>
	    				&nbsp;&nbsp;
	    				<input type="radio" name="orderState" value="주문 취소" id="orderState5" />
	    				<label for="orderState5">주문 취소</label>
	    			</div>
	    		</div>
	    		<div class="clearfix">
	    			<p class="fw600">주문 일자</p>
	    			<div>
	    				<input type="text" name="orderDate1" class="dp_ib" />
	    				~
	    				<input type="text" name="orderDate2" class="dp_ib" />
	    				<input type="submit" value="검색" class="dp_ib txt_center btn" />
	    			</div>
	    		</div>
	    	</form>
	    </div>
	    <table class="tbl txt_center"> 
            <tr>
                <th colspan="2">주문 번호</th>
                <th rowspan="2">주문자 ID</th>
                <th rowspan="2">연락처</th>
                <th rowspan="2">받는 분</th>
                <th rowspan="2">주문 합계<br />(배송비 포함)</th>
                <th rowspan="2">입금 합계</th>
               	<th rowspan="2">할인 및 쿠폰</th>
               	<th rowspan="2">배송 종류</th>
               	<th rowspan="2">주문 취소</th>
               	<th rowspan="2">상세 내역</th>
            </tr>
            <tr>
            	<th>주문 상태</th>
                <th>결제 수단</th>
            </tr>
            <tr>
                <td colspan="2">컬럼 내용</td>
                <td rowspan="2">컬럼 내용</td>
                <td rowspan="2">컬럼 내용</td>
                <td rowspan="2">컬럼 내용</td>
                <td rowspan="2">컬럼 내용</td>
                <td rowspan="2">컬럼 내용</td>
                <td rowspan="2">컬럼 내용</td>
                <td rowspan="2">샛별/정기 배송</td>
                <td rowspan="2">컬럼 내용</td>
                <td rowspan="2"><a href="" class="dp_block txt_center btn">보기</a></td>
            </tr>
            <tr>
            	<td>컬럼 내용</td>
            	<td>컬럼 내용</td>
            </tr>
        </table>
        <div class="pageBar txt_center" style="margin:20px 0 0;">페이징할 것</div>
    </article>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>