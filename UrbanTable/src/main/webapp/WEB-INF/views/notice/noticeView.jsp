<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<section class="sec_bg"> <!--배경색이 있는 경우만 sec_bg 넣으면 됩니다.-->
	<article class="subPage inner">
	    <h3 class="sub_tit">공지사항</h3>
	    <div class="txt_right"><input type="button" class="btn" value="수정"></div>
	    <br/>
	    
	    <table class="tbl txt_center"> 
            <tr>
                <th>구분</th>
                <th>제목</th>
                <th>등록일</th>
            </tr>
            <tr>
            	<td>${notice.noticeCategory }</td>
            	<td class="txt_left">${notice.noticeTitle }</td>
            	<td>${notice.noticeDate }</td>
            </tr>
            <tr>
            	<td colspan="3">
            	<img src='${pageContext.request.contextPath}/resources/images/${notice.noticeContent }'/>
            	</td>
            </tr>
        </table>

        ${notice }
    </article>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>