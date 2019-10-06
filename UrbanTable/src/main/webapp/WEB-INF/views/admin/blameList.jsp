<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/marketOwner.css">

<script>

</script>
<section>
	<article class="subPage inner asda">
	   
	    <div class="list_wrap">
	    		<table class="tbl txt_center"></table>
		        <div class="pageBar"></div>
	    	</div>
	    	<div id="orderList">
	    	
	    		<h3 class="sub_tit">신고 확인</h3>
	    		<table class="tbl txt_center">
	    			<tr class="sec_bg">
	    				<th>신고 분류</th>
	    				<th>신고한 회원</th>
	    				<th>신고 내용</th>
	    				<th>신고ID</th>
	    				<th>신고일자</th>
	    				<th style="width:70px;"></th>
	    			</tr>


	    		</table>
	    		<div class="pageBar"></div>
	    		<div id="orderTotal"></div>
	    	</div>
	    </div>
	    ${list }
	    <div class="popupWrap"></div>
    </article>

</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>