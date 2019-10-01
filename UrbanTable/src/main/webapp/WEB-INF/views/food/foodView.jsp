<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<section class="sec_bg"> <!--배경색이 있는 경우만 sec_bg 넣으면 됩니다.-->
	<article class="subPage inner">
	    <h3 class="sub_tit">서브페이지 제목</h3>
	    <img src="${food.foodImg }" alt="상품사진"  />
	    <div>
	    <div>${food.foodName }</div>
	    <table class="tbl txt_center"> <!--가운데 정렬 아니면 txt_center 빼셔도 됩니다.
	                                    width 값은 th에 width="150" 이런식으로 써주시면 됩니다.-->
            <tr>
                <th>판매가</th>
<%--                 <td><fmt:formatNumber value="${food.afterEventPrice}" pattern="\#,###.##"/>원</td> --%>
                <td>${food.afterEventPrice}원</td>
            </tr>
            <tr>
                <th>업체명</th>
                <td>${food.marketName }</td>
            </tr>
            <tr>
                <th>전화번호</th>
                <td>${food.marktetTelephone }</td>
            </tr>
        </table>
        </div>
        <table class="tbl tbl_view">
            <tr>
                <th>행 제목</th>
                <td>행 내용</td>
            </tr>
            <tr>
                <th>행 제목</th>
                <td>행 내용</td>
            </tr>
        </table>
    </article>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>