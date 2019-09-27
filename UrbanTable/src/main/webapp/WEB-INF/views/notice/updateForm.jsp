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
	    <h3 class="sub_tit">공지사항 수정</h3>
	    <form name="noticeFrm" action="${pageContext.request.contextPath}/notice/insertNoticeEnd.do" method="post" enctype="multipart/form-data">
			<table class="tbl tbl_view">
			<input type="hidden" name="noticeNo" value="${notice.noticeNo }"/>
				<tr>
					<th>구분 </th>
					<td>
					<select name="noticeCategory" style="height: 25px;">
                   		<option value="배송공지" ${notice.noticeCategory == '배송공지'?"selected":"" }>배송공지</option>
                		<option value="가격공지" ${notice.noticeCategory == '가격공지'?"selected":"" }>가격공지</option>
                		<option value="기타공지" ${notice.noticeCategory == '기타공지'?"selected":"" }>기타공지</option>
                	</select>
					</td>
					<td>
						<input type="file" name="noticeFile1" value="${notice.noticeFile }"/>
					</td>
				</tr>
				<tr>
					<th>제목</th>
					<td colspan="2">
					<input type="text" name="noticeTitle" id="noticeTitle" style="width:750px;" value="${notice.noticeTitle }" />
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td colspan="2">
					<textarea name="noticeContent" id="noticeContent" cols="30" rows="10" 
					style="resize: none; width: 750px; height: 358px;">${notice.noticeContent }</textarea>
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