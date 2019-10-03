<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script>

$(()=>{
	

	
	document.getElementById("bannerStart").valueAsDate = new Date();
	
	$("#bannerEnd").change(()=>{
		
		var start = $("#bannerStart").val();
		var end = $("#bannerEnd").val();
		
		if(start > end){
			alert("종료일자가 시작일자보다 빠릅니다.");
		} 
		
	});
	
	$("#bannerStart").change(()=>{
		
		var start = $("#bannerStart").val();
		console.log(today);
		if(start < today){
			console.log(today);
			alert("지난 날짜는 고를 수 없습니다.");
		}
		
	});
	
	
	$(".bannerDate").flatpickr({
		  enableTime: false,
		  dateFormat: "Y-m-d",
		});
	
});

</script>
<style>
input#bannerStart, input#bannerEnd{
	height: 25px;
}
input#banerFile, input#bannerTitle, input#bannerURL, #bannerContent{
	width: 750px;
}
input[type="date"],
input[type="date"]::-webkit-inner-spin-button {

-webkit-appearance: none;
}
</style>
<section class="sec_bg">
	<!--배경색이 있는 경우만 sec_bg 넣으면 됩니다.-->
	<article class="subPage inner">
		<h3 class="sub_tit">배너 작성</h3>
		<form action="${pageContext.request.contextPath}/banner/insertBannerEnd.do" method="post" enctype="multipart/form-data" />
			<table class="tbl tbl_view">
				<tr>
					<th>공고기간 </th>
					<td>
						<input type="date" class="bannerDate" name="bannerStartDate" id="bannerStart" />
						~
						<input type="date" class="bannerDate" name="bannerEndDate" id="bannerEnd" />
					</td>
				</tr>
				<tr>
					<th>제목</th>
					<td>
					<input type="text" name="bannerTitle" id="bannerTitle" />
					</td>
				</tr>
				<tr>
					<th>파일</th>
					<td>
					<input type="file" name="bannerFile1" id="bannerFile" />
					</td>
				</tr>
				<tr>
					<th>url</th>
					<td>
					<input type="text" name="bannerURL" id="bannerURL" />
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
					<textarea name="bannerContent" id="bannerContent" cols="30" rows="10" 
					style="resize: none; height: 358px;"></textarea>
					</td>
				</tr>
			</table>
			<div class="founded_btn txt_center">
				<input type="submit" value="작성" class="btn" />
			</div>
		</form>
	</article>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>