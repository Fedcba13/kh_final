<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<script>
function writeNotice(){
	
	location.href = "${pageContext.request.contextPath}/notice/insertNotice.do";
}
</script>
<section class="sub_bg"> <!--배경색이 있는 경우만 sec_bg 넣으면 됩니다.-->

	<article class="subPage inner">
	    <h3 class="sub_tit">공지사항</h3>
	    <c:if test="${memberLoggedIn.memberCheck == 9 }">
	    <div class="txt_right"><input type="button" class="btn" value="글쓰기" onclick="writeNotice();"></div>
	    <br/>    
	    </c:if>
	    
	    <table class="tbl txt_center"> <!--가운데 정렬 아니면 txt_center 빼셔도 됩니다.
	                                    width 값은 th에 width="150" 이런식으로 써주시면 됩니다.-->
            <tr>
                <th width="30">구분</th>
                <th width="160">제목</th>
                <th width="50">작성자</th>
                <th width="100">등록일자</th>
                <th width="30">조회수</th>
            </tr>
            <c:forEach items="${list }" var="n">
            <tr>
                <td>${n.noticeCategory }</td>
                <td class="txt_left"><a href='${pageContext.request.contextPath }/notice/noticeView.do?noticeNo=${n.noticeNo}'>${n.noticeTitle }</a></td>
                <td>${n.noticeWriter }</td>
                <c:if test="${n.noticeDateModified > n.noticeDate }">
                	<td>${n.noticeDateModified }</td>
                </c:if>
                <c:if test="${n.noticeDateModified <= n.noticeDate }">
                <td>${n.noticeDate }</td>
                </c:if>
                <td>${n.noticeReadcount }</td>
            </tr>
            </c:forEach>
        </table>        
    </article>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>