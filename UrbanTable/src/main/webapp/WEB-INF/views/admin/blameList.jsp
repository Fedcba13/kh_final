<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/marketOwner.css">

<script>
function blameChk(no){
	var blameId = $("#blameId"+no).val()
	
	console.log(blameId);
	location.href="${pageContext.request.contextPath}/check/blameCheck.do?blameId="+blameId;
	
}

function notBlame(no){
	var blameId = $("#blameId"+no).val()
	
	location.href="${pageContext.request.contextPath}/check/notBlame.do?blameId="+blameId;
}
</script>
<style>
.btn4{
    background: #9d8420;
    font-weight: 400;
    border: 1px solid #9d8420;
    display: inline-block;
    width: 150px;
    padding: 0;
    height: 40px;
    line-height: 40px;
    box-sizing: border-box;
    font-size: 14px;
    font-weight: 600;
    color: #fff;
    cursor: pointer;
    transition: all .25s linear;
    -webkit-transition: all .25s linear;
    }
</style>
<section>
	<article class="subPage inner asda">
	   
	    <div class="list_wrap">
	    		<table class="tbl txt_center"></table>
		        <div class="pageBar"></div>
	    	</div>
	    	<div id="orderList">
	    	
	    		<h3 class="sub_tit">신고 확인</h3>
	    		<table class="tbl txt_center">
	    			<tr class="sec_bg">
	    				<th>신고 분류</th>
	    				<th>신고한 회원</th>
	    				<th>신고 내용</th>
	    				<th>신고 게시글</th>
	    				<th>신고일자</th>
	    				<th style="width:70px;"></th>
	    			</tr>
	    		<c:forEach items="${list }" var="b" varStatus="vs">
	    			<tr>
	    			<c:if test="${b.targetType eq 4}">
	    			<td>댓글</td>
	    			</c:if>
	    			<c:if test="${b.targetType eq 3}">
	    			<td>레시피</td>
	    			</c:if>
	    			<td>${b.memberId }</td>
	    			<td>${b.blameContent }</td>
	    			<td>${b.blameTargetId }</td>
	    			<td>${b.blameDate}</td>
	    			<input type="hidden" id="blameId${vs.index }" value="${b.blameId }"/>
	    			<c:if test="${b.blameAction eq 0 && b.blameEnabled eq 1}">
	    				<td><input type="button" value="처리완료" class="btn btn2" disable/></td>
	    			</c:if>
	    			<c:if test="${b.blameAction eq 0 && b.blameEnabled eq 0}">
	    				<td><input type="button" value="허위신고" class="btn4" disable/></td>
	    			</c:if>
	    			<c:if test="${b.blameAction eq 1 }">
	    			<td>
	    			<input type="button" value="+" class="btn" style="width:50px;" onclick="notBlame(${vs.index})"/>
	    			<input type="button" value="ㅡ" class="btn" style="width:50px;" onclick="blameChk(${vs.index})"/>
	    			</td>
	    			</c:if>
	    			</tr>
	    		</c:forEach>


	    		</table>
	    		<div class="pageBar"></div>
	    		<div id="orderTotal"></div>
	    	</div>
	    </div>
	    <div class="popupWrap"></div>
    </article>

</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>