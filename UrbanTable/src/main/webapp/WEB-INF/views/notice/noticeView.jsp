<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<script>
function updateFrm(){
	var noticeNo = $("#noticeNo").val();
	console.log(noticeNo);
	location.href="${pageContext.request.contextPath}/notice/noticeUpdateFrm.do?noticeNo="+noticeNo;
}
function deleteFrm(){
	var bool = confirm("정말로 삭제하시겠습니까?");
	var noticeNo = $("#noticeNo").val();
	if(!bool){
		return;
	}
	
	location.href="${pageContext.request.contextPath}/notice/deleteNotice.do?noticeNo="+noticeNo;
	}

</script>
<style>
li input.btn{
		float : right;
	    margin: 5px;
}
</style>
<section> <!--배경색이 있는 경우만 sec_bg 넣으면 됩니다.-->
	<article class="subPage inner">
	    <h3 class="sub_tit">공지사항</h3>
	   	<c:if test="${memberLoggedIn.memberCheck == 9 }">
	    <div class="txt_right">
	    <li>
	    <input type="button" class="btn" value="수정"  onclick="updateFrm();">
	   	<input type="hidden" id="noticeNo" value="${notice.noticeNo }"/>
	    </li>
	    <li>
	    <input type="button" value="삭제" class="btn" onclick="deleteFrm();"/>
	    </li>
	    
	    </div>
	    <br/>
		</c:if>
	    <table class="tbl txt_center"> 
            <tr>
                <th style="width:50px;">구분</th>
                <th style="width:150px;">제목</th>
                <th style="width:50px;">등록일</th>
                <th style="width:30px;">조회수</th>
            </tr>
            <tr>
            	<td>${notice.noticeCategory }</td>
            	<td class="txt_left">${notice.noticeTitle }</td>
            	<td>${notice.noticeDate }</td>
            	<td>${notice.noticeReadcount }</td>
            </tr>
            <tr>
            	<td class="txt_left sec_bg" colspan="4" style="padding:10px 30px; box-sizing:border-box;">
               	<pre style="font-family: 'NanumBarunGothic', sans-serif;">
               	${notice.noticeContent }
               	</pre>
            	</td>
            </tr>
        </table>
		<div class="txt_right" style="margin-top:20px;"><a href="${pageContext.request.contextPath }/notice/noticeList.do" class="dp_block btn txt_center">목록</a></div>
    </article>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>