<%@page import="com.kh.urbantable.food.model.vo.FoodUpper"%>
<%@page import="com.kh.urbantable.food.model.service.FoodServiceImpl"%>
<%@page import="com.kh.urbantable.food.model.vo.FoodDivision"%>
<%@page import="org.apache.taglibs.standard.lang.jstl.DivideOperator"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/main.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/food.css">
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/main.js"></script>
<jsp:include page="/WEB-INF/views/common/header.jsp" />

	<article class="subPage inner">
	    <h3 class="sub_tit">서브페이지 제목</h3>
        <form action="${pageContext.request.contextPath}/food/admin/foodInsert.do" id="foodInsertFrm"  method="post" enctype="multipart/form-data">
	    <table class="tbl" id="insertFoodTb"> <!--가운데 정렬 아니면 txt_center 빼셔도 됩니다.
	                                    width 값은 th에 width="150" 이런식으로 써주시면 됩니다.-->
            <tr>
                <th >상품명</th>
                <td><input type="text" name="foodName" id="foodName"/></td>
            <tr>
                <th>상품 등록자</th>
                <td>urbanTable</td>
            </tr>
		<tr>
			<th>상품 분류</th>
			<td><select class="catSelect"  id="divisionOptions" onchange="getDivisionList()">
					<option selected>대분류</option>
					<%
						for (FoodDivision division : FoodServiceImpl.foodDivisionList) {
					%>
					<option value="<%=division.getFoodDivisionNo()%>"><%=division.getFoodDivisionName()%></option>>
					<%
						}
					%>
			</select>
			 <select class="catSelect" id="upperOptions" onchange="getSectionList()">
					<option selected>중분류</option>
					
			</select> 
			<select  class="catSelect" id="sectionOptions" name="foodSectionNo">
					<option selected>소분류</option>

			</select></td>
		</tr>
		<tr>
                <th class="sec_bg">납품 업체명</th>
                <td><input type="text" name="foodCompany" id="foodCompany"/></td>
            </tr>
            <tr>
                <th>상품 납품가</th>
                <td><input type="number" name="foodMarketPrice" id="foodMarketPrice"/>원</td>
            </tr>
            <tr>
                <th>상품 판매가</th>
                <td><input type="number" name="foodMemberPrice" id="foodMemberPrice"/>원</td>
            </tr>
            <tr>
                <th>상품 사진</th>
                <td><input type="file" name="foodImgFile" /></td>
            </tr>
        </table>
        <br />
		<div>
		<div style="text-align: right">
       	<input type="submit" class="btn btn2" value="등록" onsubmit="return validate();" />
		</div>
       	
        </form>
       
    </article>
    <script>
    function validate(){
    	var foodName = $("#foodName").val();
    	var foodSectionNo = $("#foodSectionNo option:selected").val();
    	var foodCompany = $("#foodCompany").val();
    	var foodMarketPrice = $("#foodMarketPrice").val();
    	var foodMemberPrice = $("#foodMemberPrice").val();
    	
    	if(foodName == ''){
    		console.log("음식명을 입력하세요.");
    		return false;
    	}
    	if(foodCompany == ''){
    		console.log("납품 업체명을 입력하세요.");
    		return false;
    	}
    	if(foodSectionNo == '소분류'){
    		console.log("분류를 명확하게 선택해주십시오");
    		return false;
    	}
    	if(foodMarketPrice <= 0){
    		console.log("상품 납품가를 다시 정해주세요.");
    		return false;
    	}
    	if(foodMemberPrice <= 0){
    		console.log("상품 판매가를 다시 정해주세요.");
    		return false;
    	}
    	return true;
    }
    
    function getDivisionList(){	
		var foodDivisionNo = $("#divisionOptions option:selected").val();
    	
	var param ={
			foodDivisionNo: foodDivisionNo
		}
    	
    	$.ajax({
    		url: "${pageContext.request.contextPath}/food/admin/getUpperListToInsertFood.do",
    		data: param,
    		success: (data)=> {
    			html = "<option selected>중분류</option>";
    			for(var i in data){
    			html += "<option value='"+data[i].foodUpperNo+"'>"+data[i].foodUpperName+"</option>";
    			
    			} 
    			$("#upperOptions").html(html);
    			$("#sectionOptions").html("<option selected>소분류</option>"); 
    		},
    		error: (xhr, txtStatus, err)=> {
    			console.log("ajax 처리실패!", xhr, txtStatus, err);
    		}
    	});
    }
    function getSectionList(){	
		var foodUpperNo = $("#upperOptions option:selected").val();
    	
	var param ={
			foodUpperNo: foodUpperNo
		}
    	
    	$.ajax({
    		url: "${pageContext.request.contextPath}/food/admin/getSectionListToInsertFood.do",
    		data: param,
    		success: (data)=> {
    			html = "<option selected>소분류</option>";
    			for(var i in data){
    			html += "<option value='"+data[i].foodSectionNo+"'>"+data[i].foodSectionName+"</option>";
    			
    			} 
    			$("#sectionOptions").html(html); 
    		},
    		error: (xhr, txtStatus, err)=> {
    			console.log("ajax 처리실패!", xhr, txtStatus, err);
    		}
    	});
    }
    	
    </script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>