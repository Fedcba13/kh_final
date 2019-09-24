<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<style>
input[type="date"],
input[type="date"]::-webkit-inner-spin-button {
border:0;
background:transparent;
-webkit-appearance: none;
}
input.view{
    border: 0;
    background: transparent;
}
img.img{
	width:100px; 
	height:100px;
}
</style>
<script>
function test(idx){
		
		console.log(idx);
		var start = $(".start"+idx);
		var end = $(".end"+idx);
		
		if(end.val() < start.val()){
			alert("종료일자가 시작보다 빠릅니다. ");
			end.val(start.val());
		}
	}
		
function deleteBanner(idx){
	
	var bool = confirm("승인하시겠습니까");
	var bannerId = $('#bannerId'+idx).val();

	if (!bool) {
		return false;
	}

	
	location.href="${pageContext.request.contextPath}/banner/deleteBanner.do?bannerId=" + bannerId;
}

function insertBanner(){
	
	location.href="${pageContext.request.contextPath}/banner/insertBanner.do";
}
</script>
<style>
	.insertBTN:hover{
	border: 1px solid #374818;
	font-size: 14px;
    font-weight: 600;
    color: #fff;
    background: #374818;
    cursor: pointer;
    transition: all .25s linear;
	}
</style>
<section class="sec_bg">
	<article class="subPage inner">

		<h3 class="sub_tit">배너 리스트</h3>
	
		<div class="bannerList">
		<div class="insertButton txt_right"><input type="button" value="등록" class="btn2 insertBTN" style="width:60px;" onclick="insertBanner();"/></div>
		<br />
		<table class="tbl txt_center">
			<tr>
				<th>배너 제목</th>
				<th>시작 일자</th>
				<th>종료 일자</th>
				<th>이미지</th>
				<th>등록 URL</th>
				<th></th>
				
			</tr>
			<c:forEach items="${list }" var="b" varStatus="vs">
			<form action="${pageContext.request.contextPath }/banner/updateBanner.do" method="post" enctype="multipart/form-data">
				<input type="hidden" id="bannerId${vs.index }" name="bannerId" value="${b.bannerId }"/>
				<tr>
					<td><input type="text" class="view txt_center" name="bannerTitle" value="${b.bannerTitle}"/></td>
					<td><input type="date" class="start${vs.index }" name="bannerStartDate" value="${b.bannerStartDate}"  /></td>
					<td><input type="date" class="end${vs.index }" name="bannerEndDate" onchange="test(${vs.index });" value="${b.bannerEndDate }"  /></td>
					<td rowspan="2">
					<img src="${pageContext.request.contextPath}/resources/images/banner/${b.bannerFileRenamed}" alt="" class='img'/>
					<input type="file" name="bannerFile1" value="${b.bannerFileRenamed }"/>
					</td>
					<td><input type="text" class="view txt_center" name="bannerURL" value="${b.bannerURL }"/></td>
				</tr>
				<tr>
					<td colspan="3" ><input type="text" class="view" name="bannerContent" value="${b.bannerContent }"/></td>
					<td>
					<input type="submit" class="btn" value="수정" style="width:60px;"/>
					<input type="button" class="btn2" value="삭제" style="width:60px;"  onclick="deleteBanner(${vs.index})"/></td>
				</tr>
			</form>
			</c:forEach>
		</table>
		</div>



	</article>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>