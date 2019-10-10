<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<script>

</script>
<section class="sec_bg"> <!--배경색이 있는 경우만 sec_bg 넣으면 됩니다.-->
	<article class="subPage inner">
	    <h3 class="sub_tit">FAQ 수정</h3>
	    <form name="faqUpdte" action="${pageContext.request.contextPath}/faq/faqUpdateEnd.do" method="post" >
			<table class="tbl tbl_view">
			<input type="hidden" name="noticeNo" value="${faq.noticeNo }"/>
				<tr>
					<th>구분</th>
					<td>
					<select name="noticeCategory" style="height: 25px;">
                		<option value="" disabled selected>선택</option>
                   		<option value="회원문의">회원문의</option>
                		<option value="주문/결제">주문/결제</option>
                		<option value="취소/교환/반품">취소/교환/반품</option>
                		<option value="배송문의">배송문의</option>
                		<option value="쿠폰/적립금">쿠폰/적립금</option>
                		<option value="서비스 이용 및 기타">서비스 이용 및 기타</option>
                	</select>
					</td>
				</tr>
				<tr>
					<th>제목</th>
					<td>
					<input type="text" name="noticeTitle" id="noticeTitle" style="width:750px;" value="${faq.noticeTitle }" />
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
					<textarea name="noticeContent" id="noticeContent" cols="30" rows="10" 
					style="resize: none; width: 750px; height: 358px;">${faq.noticeContent }</textarea>
					</td>
				</tr>
			</table>
			<div class="founded_btn txt_center">
				<input type="submit" value="수정" class="btn" />
			</div>
		</form>
    </article>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>