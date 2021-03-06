<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<section class="sec_bg"> <!--배경색이 있는 경우만 sec_bg 넣으면 됩니다.-->
	<article class="subPage inner">
	    <h2>주문이 완료되었습니다.</h2><br />
	   	<p style="font-size:18px; line-height:33px;">주문번호: <a href="${pageContext.request.contextPath}/member/payDetail?payNo=${payNo}">${payNo}</a><br>
	    <a href="${pageContext.request.contextPath }/member/myPage" style="text-decoration:underline;">마이페이지</a>
	    	에서 주문 내역 및 배달 상태를 확인하실 수 있습니다.</p>
    </article>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>