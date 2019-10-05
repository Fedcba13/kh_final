<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />


<style>

</style>

<script>

</script>

<section>
	<article class="subPage inner myPage">
		<div class="payListPage">
		    <jsp:include page="/WEB-INF/views/member/memberNav.jsp" />
		    <div class="payList">
		    	<h3 class="sub_tit" style="background-color: white;">구매 내역</h3>
		    	
	        </div>
        </div>
    </article>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>