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
               	<c:if test="${notice.noticeFile != null }">
               		<img src="${pageContext.request.contextPath }/resources/images/notice/${notice.noticeFile}" alt="" />
               	</c:if> ${notice.noticeContent }
               	</pre>
            	</td>
            </tr>
        </table>
		<div class="txt_right" style="margin: 20px 0;"><a href="${pageContext.request.contextPath }/notice/noticeList.do" class="dp_block btn txt_center">목록</a></div>
        <table class="tbl" style="border-bottom: 2px solid #374818;">
        	<tr>
        	<th class="txt_left" style="border-right: 1px solid #e9e9e9; width:90px;padding:10px;"><img src="${pageContext.request.contextPath }/resources/images/up-arrow.png" alt="다음글" style="padding-right:5px; width: 15px;"/>다음글</th>
        	<td style="padding:10px 30px ;">
        	<c:if test="${preNext.NEXT_NO != null }"><a href="${pageContext.request.contextPath }/notice/noticeView.do?noticeNo=${preNext.NEXT_NO}">${preNext.NEXT_TITLE }</a></c:if>
        	<c:if test="${preNext.NEXT_NO eq null }">${preNext.NEXT_TITLE }</c:if>
        	
        	</td>
        	</tr>
        	<tr>
        	<th class="txt_left" style="border-right: 1px solid #e9e9e9; width:90px; padding:10px;"><img src="${pageContext.request.contextPath }/resources/images/down-arrow.png" alt="이전글" style="padding-right:5px; width: 15px;"/>이전글</th>
        	<td class="txt_left" style="padding:10px 30px ;">
        	<c:if test="${preNext.PRE_NO != null }"> <a href="${pageContext.request.contextPath }/notice/noticeView.do?noticeNo=${preNext.PRE_NO}">${preNext.PRE_TITLE }</a> </c:if>
			<c:if test="${preNext.PRE_NO eq null }"> ${preNext.PRE_TITLE } </c:if>        	
        	</td>
			</tr>
        </table>
    </article>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>