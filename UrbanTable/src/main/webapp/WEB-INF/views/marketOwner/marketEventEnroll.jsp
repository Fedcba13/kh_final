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
<script>
$(()=>{
	
	document.getElementById("eventDateStart").valueAsDate = new Date();
	
	$("#eventDateEnd").change(()=>{
		
		var start = $("#eventDateStart").val();
		var end = $("#eventDateEnd");
		
		if(start > end.val()){
			alert("종료일자가 시작일자보다 빠릅니다.");
			end.val(start);
		}
		
	});
	
	$(".eventDate").flatpickr({
	  enableTime: false,
	  dateFormat: "Y-m-d",
	});
	
	$(".submitBtn").click(function(){
		var f = document.getElementById("eventEnrollEnd");
		f.action = "${pageContext.request.contextPath }/event/marketEventEnrollEnd.do";
		f.method = "post";
		f.enctype="multipart/form-data"
		f.submit();
	});
	
	$("#eventCompany").keyup(function(e){
		var $sel = $(".sel");
		var $li = $("#autoComplete li");
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
			event.preventDefault();
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
						$("#eventCompany").val($(e.target).text());
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
	
	$("#eventCategory1").keyup(function(e){
		var $sel = $(".sel");
		var $li = $("#autoComplete2 li");
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
			event.preventDefault();
			$(e.target).val($sel.text());
			$("#autoComplete2").hide().children().remove();
		} else {
			var srchCompany = $("#eventCompany").val();
			var eventCategory = $(e.target).val();
			if(eventCategory.trim().length==0){ //사용자 입력값이 없는 경우
				return;
			}
			
			var param = {
				srchCompany: srchCompany,
				eventCategory: eventCategory
			}
			
			$.ajax({
				url: "${pageContext.request.contextPath}/market/eventSearchCategory.do",
				type: "get",
				dataType: "json",
				data: param,
				success: function(data){
					console.log(data);
					if(data.length==0){
						$("#autoComplete2").hide();	
					} else {
						var html = "";
						for(var i in data){
							html += "<li rel='"+data[i].NO+"'>"+data[i].NAME+"</li>";
						}
						$("#autoComplete2").html(html).fadeIn(200);
					}
					
					$("#autoComplete2 li").click((e)=>{
						$("#eventCategory1").val($(e.target).text());
						$("#eventCategory").val($(e.target).attr("rel"));
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
	    <form id="eventEnrollEnd" name="eventEnrollEnd">
	        <table class="tbl tbl_view">
	            <tr>
	                <th>이벤트 제목<span class="red">*</span></th>
	                <td><input type="text" name="eventTitle" id="eventTitle" required class="dp_block" style="width:415px;" /></td>
	            </tr>
	            <tr>
	                <th>이벤트 내용<span class="red">*</span></th>
	                <td><textarea class="form-control" id="eventContent" name="eventContent"></textarea></td>
	            </tr>
	          
	                	<input type="hidden" name="eventCompany" id="eventCompany" autocomplete="off" style="width:200px;"  />
	
		            </tr>
	            <tr style="display:none;">
	            	<th>이벤트 대상 매장</th>
	            	<td><input type="text" name="marketNo" value="${eventMarketNo }" /></td>
	            </tr>
	            <tr>
	                <th>이벤트 대상 분류</th>
	                <td style="position:relative;">
	                	<input type="hidden" name="eventCategory" id="eventCategory"/>
	                	<input type="text" name="eventCategory1" id="eventCategory1" class="dp_ib" style="width:200px;" autocomplete="off"  />
	                	<ul id="autoComplete2" class="autoComplete"></ul>
	                </td>
	            </tr>
	            <tr>
	            	<th>파일 첨부</th>
	            	<td>
	            	<input type="file" name="eventFile1" id="eventFile" class="dp_ib" style="width:200px;" autocomplete="off" required/>
	            	</td>
	            </tr>
	            <tr>
	                <th>이벤트 날짜<span class="red">*</span></th>
	                <td>
	                	<input type="date" name="eventDateStart" required id="eventDateStart" class="dp_ib eventDate" style="width:200px;" />
            			~
            			<input type="date" name="eventDateEnd" id="eventDateEnd" class="dp_ib eventDate" style="width:200px;" />
	                </td>
	            </tr>
	            <tr>
	            	<th>이벤트 할인율<span class="red">*</span></th>
	            	<td>
	            	<input type="text" name="eventPrice" id="eventPrice" class="dp_ib" style="width:200px;" autocomplete="off" required/>
	            	</td>
	            </tr>
	        </table>
	        <div class="txt_center mt30"><input type="button" value="등록" class="btn submitBtn" /></div>
        </form>
    </article>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>