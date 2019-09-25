<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/marketOwner.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script src="https://cdn.ckeditor.com/ckeditor5/12.4.0/classic/ckeditor.js"></script>
<script>
$(()=>{
	$(".eventDate").flatpickr({
	  enableTime: false,
	  dateFormat: "Y.m.d",
	});
	
	ClassicEditor.create(document.querySelector('#eventContent'));
	
	var $sel = $(".sel");
	var $li = $("#autoComplete li");
	
	$("#srchCompany").keyup(function(e){
		if(e.key=="ArrowDown"){
			if($sel.length==0){
				$li.eq(0).addClass("sel");
			} else if($sel.is($li.last())){
				
			} else {
				$sel.removeClass("sel").next().addClass("sel");
			}
		} else if(e.key=="ArrowUp"){
			if($sel.length==0){
				
			} else if($sel.is($li.first())){
				$sel.removeClass("sel");
			} else {
				$sel.removeClass("sel").prev().addClass("sel");
			}
		} else if(e.key == "Enter"){
			$(e.target).val($sel.text());
			$("#autoComplete").hide().children().remove();
		} else {
			var srchCompany = $(e.target).val();
			if(srchCompany.trim().length==0){ //사용자 입력값이 없는 경우
				return;
			}
			$.ajax({
				url: "${pageContext.request.contextPath}/market/eventCompanySearch.do",
				type: "get",
				dataType: "json",
				data: "srchCompany="+srchCompany,
				success: function(data){
					if(data.length==0){
						$("#autoComplete").hide();	
					} else {
						var html = "";
						for(var i in data){
							html += "<li><span>"+data[i]+"</span></li>";
						}
						$("#autoComplete").html(html).fadeIn(200);
					}
					
					$("#autoComplete li").click((e)=>{
						$("#srchCompany").val($(e.target).text());
						$("#autoComplete").hide().children().remove();
					});
				},
				error: function(jqxhr, textStatus, errorThrown){
					console.log("ajax 처리 실패!");
					console.log(jqxhr, textStatus, errorThrown);
				}
			});
		}
	});
	
	$("#eventCategory").keyup(function(e){
		if(e.key=="ArrowDown"){
			if($sel.length==0){
				$li.eq(0).addClass("sel");
			} else if($sel.is($li.last())){
				
			} else {
				$sel.removeClass("sel").next().addClass("sel");
			}
		} else if(e.key=="ArrowUp"){
			if($sel.length==0){
				
			} else if($sel.is($li.first())){
				$sel.removeClass("sel");
			} else {
				$sel.removeClass("sel").prev().addClass("sel");
			}
		} else if(e.key == "Enter"){
			$(e.target).val($sel.text());
			$("#autoComplete2").hide().children().remove();
		} else {
			var srchCompany = $("#srchCompany").val();
			var eventCategory = $(e.target).val();
			if(eventCategory.trim().length==0){ //사용자 입력값이 없는 경우
				return;
			}
			
			var param = {
				srchCompany: srchCompany,
				eventCategory: eventCategory
			}
			
			console.log(param);
			
			$.ajax({
				url: "${pageContext.request.contextPath}/market/eventSearchCategory.do",
				type: "get",
				dataType: "json",
				data: param,
				success: function(data){
					if(data.length==0){
						$("#autoComplete2").hide();	
					} else {
						var html = "";
						for(var i in data){
							html += "<li><span>"+data[i]+"</span></li>";
						}
						$("#autoComplete2").html(html).fadeIn(200);
					}
					
					$("#autoComplete2 li").click((e)=>{
						$("#eventCategory").val($(e.target).text());
						$("#autoComplete2").hide().children().remove();
					});
				},
				error: function(jqxhr, textStatus, errorThrown){
					console.log("ajax 처리 실패!");
					console.log(jqxhr, textStatus, errorThrown);
				}
			});
		}
	});
});
</script>
<section>
	<article class="subPage inner">
	    <h3 class="sub_tit">이벤트 등록</h3>
	    <p class="info txt_right"><span class="red">*</span>은 필수 항목입니다.</p>
	    <form action="${pageContext.request.contextPath }/market/marketEventEnrollEnd.do" method="post" name="eventEnrollEnd">
	    	<input type="hidden" name="marketNo" value="" />
	        <table class="tbl tbl_view">
	            <tr>
	                <th>이벤트 제목<span class="red">*</span></th>
	                <td><input type="text" name="eventTitle" id="eventTitle" required class="dp_block" style="width:415px;" /></td>
	            </tr>
	            <tr>
	                <th>이벤트 날짜<span class="red">*</span></th>
	                <td>
	                	<input type="text" name="eventDateStart" required id="eventDateStart" class="dp_ib eventDate" style="width:200px;" />
            			~
            			<input type="text" name="eventDateEnd" id="eventDateEnd" class="dp_ib eventDate" style="width:200px;" />
	                </td>
	            </tr>
	            <tr>
	                <th>이벤트 대상 업체</th>
	                <td style="position:relative;">
	                	<input type="text" name="srchCompany" id="srchCompany" />
	                	<ul id="autoComplete" class="autoComplete"></ul>
	                </td>
	            </tr>
	            <tr>
	                <th>이벤트 대상 분류</th>
	                <td style="position:relative;">
	                	<input type="text" name="eventCategory" id="eventCategory" class="dp_ib" style="width:200px;" />
	                	<ul id="autoComplete2" class="autoComplete"></ul>
	                </td>
	            </tr>
	            <tr>
	                <th>이벤트 내용<span class="red">*</span></th>
	                <td><textarea class="form-control" id="eventContent" name="eventContent" rows="80"></textarea></td>
	            </tr>
	        </table>
	        <div class="txt_center mt30"><input type="submit" value="등록" class="btn" /></div>
        </form>
    </article>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>