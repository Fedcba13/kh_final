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
	    <h3 class="sub_tit">내 지점 관리</h3>
        <table class="tbl tbl_view">
            <tr>
                <th>지점명</th>
                <td></td>
            </tr>
            <tr>
                <th>지점장명</th>
                <td>행 내용</td>
            </tr>
            <tr>
                <th>지점 주소</th>
                <td>${market.marketAddress }, ${market.marketAddress2 }</td>
            </tr>
            <tr>
                <th>지점 전화번호</th>
                <td>${market.marketTelephone }</td>
            </tr>
            <tr>
            	<th>지점 오픈여부</th>
            	<td>
            		<c:if test="${market.flag eq 1 }">
            			오픈 대기중
            		</c:if>
            		<c:if test="${market.flag eq 2 }">
            			오픈
            		</c:if>
            	</td>
            </tr>
        </table>
        <div class="founded_btn txt_center">
        	<a href="" class="btn">지점 정보 수정</a>
        	<c:if test="${market.flag eq 1 }">
       			<a href="" class="btn btn2">지점 오픈하기</a>
       		</c:if>
        </div>
    </article>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>