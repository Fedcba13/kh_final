<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<style>
/* FAQ작성 버튼 */
input#btn-add{float:right; margin: 0 0 15px;}
</style>
<script>
//FAQ 메인페이지
function fn_goFaqForm(){
	location.href = "${pageContext.request.contextPath}/faq/faqForm.do";
}

$(()=>{
	$("tr[noticeNo]").click(function(){
		var noticeNo = $(this).attr("noticeNo");
		location.href = "${pageContext.request.contextPath}/faq/faqView.do?noticeNo="+noticeNo;
	});
});
</script>

<section class="sec_bg"> <!--배경색이 있는 경우만 sec_bg 넣으면 됩니다.-->
	<article class="subPage inner">
	    <h3 class="sub_tit">자주하는 질문</h3>
	    <!-- FAQ: FAQ 조회 -->
		<input type="button" value="FAQ작성" id="btn-add"
			   class="btn btn-outline-success"
			   onclick="fn_goFaqForm();"/>
		<table id="tbl-faq"
			   class="table table-striped table-hover">
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>내용</th>
				<th>등록일</th>
				<th>카테고리</th>
				<th>삭제여부</th>
				<th>수정일</th>
			</tr>
			<c:forEach items="${list }" var="f"
					   varStatus="vs">
				<tr noticeNo="${f.noticeNo}">
					<td>${vs.count}</td>
					<td>${f.noticeTitle }</td>
					<td>${f.noticeWriter }</td>
					<td>${f.noticeContent }</td>
					<td>${f.noticeDate }</td>
					<td>${f.noticeCategory }</td>
					<td>${f.noticeEnabled }</td>
					<td>${f.noticeDateModified }</td>
				</tr>
			</c:forEach>
		</table>
	    <!-- FAQ 끝 -->
    </article>
</section>

<!-- <script>
/* 자주하는질문조회 */
$(()=>{
	$("tbl-faq").on("change", (e)=>{
		var faqList = $(e.target).val();
		
		$.ajax({
			url: "{pageContext.request.contextPath}/faq/faqList"+faqList,
			dataType: "json",
			type: "GET",
			success: (data)=>{
				console.log(data);
				var html = "<table class=table>";
				html+="<tr><th>고유번호</th><th>제목</th><th>작성자</th><th>내용</th><th>등록일</th><th>조회수</th><th>카테고리</th><th>삭제여부</th><th>수정일</th></tr>";
				for(var i in data){
					html += "<tr><td>"+data[i].noticeNo+"</td>";
					html += "<td>"+data[i].noticeTitle+"</td>";
					html += "<td>"+data[i].noticeWriter+"</td>";
					html += "<td>"+data[i].noticeContent+"</td>";
					html += "<td>"+data[i].noticeDate+"</td>";
					html += "<td>"+data[i].readCount+"</td>";
					html += "<td>"+data[i].noticeCategory+"</td>";
					html += "<td>"+data[i].noticeEnabled+"</td>";
					html += "<td>"+data[i].noticeDateModified+"</td></tr>";
				}
				html+="</table>";
				$("#tbl-faq")
			}
		});
	});
});
</script> -->

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>