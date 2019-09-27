<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<section>
	<article class="subPage inner">
	    <h3 class="sub_tit">발주 요청</h3>
	    <form action="" method="post" name="foodOrderRequestEnd" id="foodOrderRequestEnd">
	    	<input type="hidden" name="marketNo" value="${marketNo }" />
	        <table class="tbl tbl_view">
	            <tr>
	                <th>식품명</th>
	                <td>행 내용</td>
	                <th>수량</th>
	                <td><input type="number" name="marketOrderDetailAmount" id="marketOrderDetailAmount" /></td>
	                <th>가격</th>
	                <td></td>
	            </tr>
	            <tr>
	                <th>발주 총 가격</th>
	                <td colspan="6"><input type="number" name="marketOrderPrice" id="marketOrderPrice" /></td>
	            </tr>
	        </table>
        </form>
    </article>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>