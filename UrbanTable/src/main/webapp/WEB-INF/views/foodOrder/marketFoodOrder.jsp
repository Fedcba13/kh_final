<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<section>
	<article class="subPage inner">
	    <h3 class="sub_tit">발주 내역</h3>
	    <div class="txt_right">
	    	<a href="${pageContext.request.contextPath }/foodOrder/foodOrderRequest.do?memberId=${memberLoggedIn.memberId}" class="dp_block btn txt_center">발주 요청</a>
	    </div>
	    <table class="tbl txt_center">
            <tr>
                <th>컬럼 제목</th>
                <th>컬럼 제목</th>
                <th>컬럼 제목</th>
                <th>컬럼 제목</th>
            </tr>
            <tr>
                <td>컬럼 내용</td>
                <td>컬럼 내용</td>
                <td>컬럼 내용</td>
                <td>컬럼 내용</td>
            </tr>
        </table>
    </article>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>