<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/recipe.css">
<script>
var index = 2;
var material_i = 1;
$(()=> {
	index = $(".tab>li").length+1;
	material_i = $("#material_list>li").length+1;
	
	for(var i=1; i<=$(".tab>li").length; i++) {
		$("#recipe_content_div" + i).css("display", "none");
	}
	
	$("#recipe_content_div1").css("display", "");
	
	$("#food_division").change(function() {
		var fr = this.value;
		var num = null;
		var vnum = null;
		var opt = $("#food_section option").length;
		var sel = $("#food_section");
		
		$.ajax({
			url: "${pageContext.request.contextPath}/recipe/materialSelectBox",
			data: {fr: fr},
			dataType: "json",
			type: "GET",
			success: (data)=>{
				console.log(data);
				num = new Array("--소분류--");
				vnum = new Array("");
				for(var i=0; i<data.length; i++) {
					num.push(data[i].foodSectionName);
					vnum.push(data[i].foodSectionName);
				}
				for(var i=0; i<opt; i++) {
					$("#food_section")[0].options[i] = null;
				}
				
				for(var i=0; i<num.length; i++) {
					$("#food_section")[0].options[i] = new Option(num[i], vnum[i]);
				}
			},
			error: (xhr, txtStatus, err)=> {
				console.log("ajax 처리실패!", xhr, txtStatus, err);
			}
		});
	});
	
	$("#tab_add").on("click", function() {
		var html = "";
		var tab = "";
		
		//name="recipeSequenceList[0].recipeContent"
		
		html += "<div id='recipe_content_div" + index + "'>";
		html += "<input type='hidden' name='recipeSequenceList[" + (index-1) + "].recipeOrder' id='recipeOrder" + index + "' value='" + index + "' />";
		html += "<textarea name='recipeSequenceList[" + (index-1) + "].recipeContent' class='recipe_content' id='recipe_content" + index + "' cols='100' rows='5' placeholder='레시피 내용&#13;&#10;ex)중약불로 달군 팬에 올리브유를 두르고 앞뒤로 노릇하게 구워주세요.' style='border: 1px solid #e9e9e9; border-radius: 5px; color: #555; resize: none;'></textarea> <br /><br />";
		html += "<input type='text' name='upload_name_origin' class='upload_name' id='upload_name" + index + "' disabled /><input type='file' name='recipePic' id='upload_file" + index + "' style='display:none;' /> <button class='btn btn_upload' id='btn_upload" + index + "' type='button'>사진 가져오기</button> <br /><br />";
		html += "</div>";
		
		tab += "<li><button type='button' class='btn btn_content' value='"+ index +"'>"+ index +"</button></li>";
		
		//alert("html=" + html);
		
		$("#recipe_content_div").append(html);
		$(".tab").append(tab);
		$("#tab_remove").val(index);
		$("#tab_remove").css("display", "");
		
		for(var i=1; i<=$(".tab>li").length; i++) {
			$("#recipe_content_div" + i).css("display", "none");
		}
		
		$("#recipe_content_div" + index).css("display", "");
		$(".btn_content").css("background", "#374818");
		$(".btn_content").css("color", "#fff");
		$("ul>li>button[value='"+ index +"']").css("background", "#fff");
		$("ul>li>button[value='"+ index +"']").css("color", "#374818");
		
		$("#updateLastOrder").val(Number($("#updateLastOrder").val())+1);
		
		index ++;
		
		tabEvent();
		pic_Event();
	});
	
	tabEvent();
	
	$("#tab_remove").on("click", function() {
		var i = this.value;
		$("#recipe_content_div" + i).remove();
		$("ul>li>button[value='"+ i +"']").remove();
		$(".btn_content:last").trigger("click");
		
		if(i-1 != 1) {			
			$("#tab_remove").css("display", "");
		}
		
		$("#updateLastOrder").val(Number($("#updateLastOrder").val())-1);
		
		index --;
	});
	
	$(".btn_material").on("click", materialInsert);
	
	pic_Event();
	
	$(".btn_insert").on("click", function() {
		if($("#recipe_title").val() == null || $("#recipe_title").val() == "") {
			alert("레시피 제목을 입력해주세요!");
			return false;
		}
		
		if($(".recipe_content").val() == null || $(".recipe_content").val() == "") {
			alert("레시피를 입력해주세요!");
			return false;
		}
		
		if(index != 2) {
			if($("#upload_name" + (index-1)).val() == null || $("#upload_name" + (index-1)).val() == "") {
				alert("마지막 탭에 사진을 첨부해주세요!");
				return false;
			}
			
			for(var i=1; i<=index; i++) {
				if($("#recipe_content" + i).val().includes("바보") || $("#recipe_content" + i).val().includes("멍청이")
						|| $("#recipe_title").val().includes("바보") || $("#recipe_title").val().includes("멍청이")) {
					alert("금지어가 포함되어 있습니다!");
					return false;
				}
			}
		} else {
			if($("#upload_name1").val() == null || $("#upload_name1").val() == "") {
				alert("마지막 탭에 사진을 첨부해주세요!");
				return false;
			}
		}
	});
	
	$(".search_btn").on("click", function() {
		var loc = "${pageContext.request.contextPath}/recipe/searchFrm";
		
		window.open(loc,'추천 상품 선택','width=430,height=500,location=no,status=no,scrollbars=yes');
	});
	
	$(".mate_li_delete").click((e)=>{
		materialDeleteEvent(e);
	});
});

function materialInsert(){
	if($("#food_division").val() == "") {
		alert("대분류를 선택하세요");
		return false;
	}
	
	if($("#food_section").val() == "") {
		alert("소분류를 선택하세요");
		return false;
	}
	
	var html = "";
	var section = $("#food_section").val();
	var searchResult = $("#searchResultNo").val();
	
	html += "<li class='mate_li' value='" + material_i + "'>" + $("#food_division").val() + ">" + section + "</li>"
	html += "<button type='button' class='mate_li_delete' value='" + material_i + "'>x</button>";
	
	$("#material_list").append(html);
	
	var materialSet = $("#materialSet").val();
	var materialOldSet = $("#materialOldSet").val();
	
	$.ajax({
		url: "${pageContext.request.contextPath}/recipe/materialInsert/" + section,
		data: {materialSet: materialSet, searchResult: searchResult},
		dataType: "json",
		type: "GET",
		success: (data)=>{
			console.log(data);
			$("#materialSet").val(data);	
			console.log('a');
		},
		error: (xhr, txtStatus, err)=> {
			console.log("ajax 처리실패!", xhr, txtStatus, err);
		}
	});
	
	$("#searchResult").val("");
	$("#searchResultNo").val("");
	
	$(".mate_li_delete").off();
	$(".mate_li_delete").click((e)=>{
		materialDeleteEvent(e);
	});
	
	material_i++;
}

function materialDeleteEvent(e) {
	var $this = $(e.target);
	console.log('1');
	
	var text = $(".mate_li[value='" + $this.val() + "']").text();
	console.log('2');
	
	$(".mate_li[value='" + $this.val() + "']").remove();
	console.log('3');
	$this.remove();
	console.log('4');
	$this.prev().remove();
	console.log('5');
		
		
		var arr = text.split(">");
		var materialName = arr[1];
		console.log('6');
		console.log('7');

		if($("#materialOldSet").val().indexOf(materialName) != -1) {
			$.ajax({
				url: "${pageContext.request.contextPath}/recipe/materialOldDelete/" + materialName,
				dataType: "json",
				type: "GET",
				success: (data)=>{
					console.log(data);
					if(data == 0) {
						console.log("삭제 실패!");
					} else {
						console.log("삭제 성공!");
					}
				},
				error: (xhr, txtStatus, err)=> {
					console.log("ajax 처리실패!", xhr, txtStatus, err);
				}
			});
		} else {
			 $.ajax({
	            url: "${pageContext.request.contextPath}/recipe/materialDelete/" + materialName,
                data: {materialSet: $("#materialSet").val()},
				type: "GET",
				success: (data)=>{
					console.log(data);
					//$("#materialSet").val(data);
					console.log('9');
				},
				error: (xhr, txtStatus, err)=> {
					console.log("ajax 처리실패!", xhr, txtStatus, err);
				}
			});	  
		}
		console.log('10');
}

function tabEvent() {
	$(".tab>li>button").on("click", function() {
		for(var i=1; i<=$(".tab>li").length; i++) {
			$("#recipe_content_div" + i).css("display", "none");
		}
		
		$(".btn_content").css("background", "#374818");
		$(".btn_content").css("color", "#fff");
		
		if(this.value == index-1) {
			$("#tab_remove").css("display", "");
		} else {
			$("#tab_remove").css("display", "none");
		}
		
		$("#recipe_content_div" + this.value).css("display", "");
		$("ul>li>button[value='"+ this.value +"']").css("background", "#fff");
		$("ul>li>button[value='"+ this.value +"']").css("color", "#374818");
		
		$("#tab_remove").val(this.value);
	});
}

function pic_Event() {
var pic_index = $("#tab_remove").val();

	$("#btn_upload" + pic_index).click(function(e) {
		alert(pic_index);
		e.preventDefault();
		$("#upload_file" + pic_index).click();
		var ext = $("#upload_file" + pic_index).val().split(".").pop().toLowerCase();
		if(ext.length > 0) {
			if($.inArray(ext, ["gif", "png", "jpg", "jpeg"]) == -1) {
				alert("gif, png, jpg 파일만 업로드 할 수 있습니다.");
				return false;
			}
		}
		$("#upload_file" + pic_index).val().toLowerCase();
	});
	
	$("#upload_file" + pic_index).change(function() {
		var name = this.value.split("\\");
		
		$("#upload_name" + pic_index).val(name[name.length-1]);
	});
}

function setChildValue(searchResult){
	
/* 	if(searchResult.length > 9) {
		searchResult = searchResult.substring(0, 8) + "...";
	} */

    $("#searchResult").val(searchResult);

}

function setChildNoValue(searchResultNo){

    $("#searchResultNo").val(searchResultNo);

}
</script>
<section class=""> <!--배경색이 있는 경우만 sec_bg 넣으면 됩니다.-->
	<article class="subPage inner">
	    <h3 class="sub_tit">레시피 수정</h3>
	    <form action="${pageContext.request.contextPath}/recipe/recipeUpdateEnd.do" method="post" enctype="multipart/form-data">
		    <table class="tbl tbl_view recipe_insert_tbl"> <!--가운데 정렬 아니면 txt_center 빼셔도 됩니다.
		                                    width 값은 th에 width="150" 이런식으로 써주시면 됩니다.-->
	            <tr>
	                <th style="width:200px">이름</th>
	                <td><input type="text" value="${recipe.recipeTitle}" id="recipe_title" name="recipeTitle" style="width:720px;" /></td>
	            </tr>
	            <tr>
	            	<th>재료</th>
	                <td>
	                	<select name="food_division" id="food_division">
	                		<option value="">--대분류--</option>
	                		<option value="생수/탄산수">생수/탄산수</option>
	                		<option value="우유/두유/요구르트">우유/두유/요구르트</option>
	                		<option value="잡곡/혼합곡">잡곡/혼합곡</option>
	                		<option value="채소">채소</option>
	                		<option value="과일">과일</option>
	                		<option value="견과류">견과류</option>
	                		<option value="건과일/말랭이">건과일/말랭이</option>
	                		<option value="건어물">건어물</option>
	                		<option value="생선류">생선류</option>
	                		<option value="해산물">해산물</option>
	                		<option value="해조류">해조류</option>
	                		<option value="쇠고기">쇠고기</option>
	                		<option value="돼지고기">돼지고기</option>
	                		<option value="닭고기">닭고기</option>
	                		<option value="양고기/오리고기">양고기/오리고기</option>
	                		<option value="축산가공식품">축산가공식품</option>
	                	</select>
	                	<select name="food_section" id="food_section">
	                		<option value="">--소분류--</option>
	                	</select>
	                	<input type="text" id="searchResult" placeholder="추천 재료(선택 사항)" readonly />
	            		<input type="hidden" name="searchResultNo" id="searchResultNo" />
	            		<button type="button" class="btn search_btn" style="width:50px;">검색</button>
	                	<button type="button" class="btn btn_material">추가</button>
	                	<br />
	                	<ol id="material_list">
	                		<c:forEach items="${material}" var="m" varStatus="vs">
	                			<li class='mate_li' value="${vs.count}">${m.foodDivisionName}>${m.foodSectionName}</li>
								<button type='button' class='mate_li_delete' value="${vs.count}">x</button>
	                		</c:forEach>
	                	</ol>
	                </td>
	            </tr>
	            <tr>
	            	<th>레시피</th>
	                <td>
	                	<div id="recipe_content_div">
	                		<c:if test="${not empty recipe.recipeSequenceList}">
			                	<ul class="tab">
			                		<c:forEach items="${recipe.recipeSequenceList}" var="rec" varStatus="vs">
					               		<li><button type="button" class="btn btn_content" value="${vs.count}">${vs.count}</button></li>
			                		</c:forEach>
			                	</ul>
		                		<c:forEach items="${recipe.recipeSequenceList}" var="rec" varStatus="vs">
				                	<div id="recipe_content_div${vs.count}">
				                		<input type="hidden" value="${rec.recipeOrder}" name="recipeSequenceList[${vs.index}].recipeOrder" id="recipeOrder${vs.count}" value="${vs.count}" />
					                	<textarea name="recipeSequenceList[${vs.index}].recipeContent" id="recipe_content${vs.count}" class="recipe_content" cols="100" rows="5" placeholder="레시피 내용&#13;&#10;ex)중약불로 달군 팬에 올리브유를 두르고 앞뒤로 노릇하게 구워주세요." style="border: 1px solid #e9e9e9; border-radius: 5px; color: #555; resize: none;">${rec.recipeContent}</textarea> <br /><br />
					                	<input type="text" name='upload_name_origin' class="upload_name" id="upload_name${vs.count}" value="${rec.originalRecipePic}" readonly /><input type="file" name="recipePic" id="upload_file${vs.count}" style="display:none;" /> <button class="btn btn_upload" id="btn_upload${vs.count}" type="button">사진 가져오기</button> <br /><br />
				                	</div>
				                	<c:if test="${vs.last}">
				                		<input type="hidden" id="sequenceLast" name="sequenceLast" value="${rec.recipeOrder}" />
				                		<input type="hidden" id="updateLastOrder" name="updateLastOrder" value="${rec.recipeOrder}" />
				                	</c:if>            		
		                		</c:forEach>              		
	                		</c:if>
	                	</div><br />
	                	<p>
	                		*레시피 순서에 따라 하나씩 넣어주세요<br />
	                		*욕설이 들어간 게시글은 삭제 될 수 있습니다<br />
	                		*마지막 탭에는 완성된 요리 사진을 필수로 첨부해주세요
	                	</p>
	                	<div class="btn_add">
		                	<button type="button" class="btn btn_content_ar" id="tab_add">+</button>
		                	<button type="button" class="btn btn_content_ar" id="tab_remove" value="1" style="display:none;">-</button>		                	
	                	</div>
	                </td>
	            </tr>
	        </table>
	       	<c:set var="set">
	      		<c:forEach items="${material}" var="m" varStatus="vs">${m.foodSectionName}-${m.foodNo}<c:if test="${!vs.last}">,</c:if></c:forEach>
	       	</c:set>
	        <input type="hidden" id="materialSet" name="materialSet" />
	        <input type="hidden" id="materialOldSet" name="materialOldSet" value="${set}" />
	        <input type="hidden" id="recipeNo" name="recipeNo" value="${recipe.recipeNo}" />
	        <div class="btn_submit">
	        	<input type="submit" class="btn btn_insert" value="글 등록하기" />	        
	        </div>
        </form>
    </article>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>