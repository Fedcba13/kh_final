<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<section>
	<article class="subPage inner">
	    <h3 class="sub_tit">지점 이벤트 관리</h3>
	    <a href="${pageContext.request.contextPath }/event/marketEventEnroll.do?memberId=${memberLoggedIn.memberId}" class="btn txt_center dp_block">
	    	이벤트 등록
	    </a>
    </article>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>