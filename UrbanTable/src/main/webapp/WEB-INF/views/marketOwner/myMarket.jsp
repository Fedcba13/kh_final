<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<section>
	<article class="subPage inner">
	    <h3 class="sub_tit">내 지점 관리</h3>
        <table class="tbl tbl_view">
            <tr>
                <th>지점명</th>
                <td>행 내용</td>
            </tr>
            <tr>
                <th>지점장명</th>
                <td>행 내용</td>
            </tr>
            <tr>
                <th>지점 주소</th>
                <td>행 내용</td>
            </tr>
            <tr>
                <th>지점 전화번호</th>
                <td>행 내용</td>
            </tr>
        </table>
        <div class="txt_right"><a href="" class="btn txt_center" />수정</a></div>
    </article>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>