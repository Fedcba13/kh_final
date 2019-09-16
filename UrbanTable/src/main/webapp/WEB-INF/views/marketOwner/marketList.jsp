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