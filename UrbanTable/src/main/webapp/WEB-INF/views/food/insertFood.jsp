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
<jsp:include page="/WEB-INF/views/common/header.jsp" />

	<article class="subPage inner">
	    <h3 class="sub_tit">서브페이지 제목</h3>
	    <table class="tbl txt_center"> <!--가운데 정렬 아니면 txt_center 빼셔도 됩니다.
	                                    width 값은 th에 width="150" 이런식으로 써주시면 됩니다.-->
            <tr>
                <th>컬럼 제목</th>
                <td>컬럼 내용</td>
            </tr>
            <tr>
                <th>상품명</th>
                <td>컬럼 내용</td>
            <tr>
                <th>상품 등록자</th>
                <td>컬럼 내용</td>
            </tr>
		<tr>
			<th>상품 분류</th>
			<td><select id="divisionOptions" onchange="getDivisionList()">
					<option selected>대분류</option>
					<%
						for (FoodDivision division : FoodServiceImpl.foodDivisionList) {
					%>
					<option value="<%=division.getFoodDivisionNo()%>"><%=division.getFoodDivisionName()%></option>>
					<%
						}
					%>
			</select> <select name="upper">
					<option selected>중분류</option>
					<%
						for (FoodUpper upper : FoodServiceImpl.foodUpperList) {
					%>
					<option value="<%=upper.getFoodUpperNo()%>"><%=upper.getFoodUpperName()%></option>>
					<%
						}
					%>
			</select> <select name="section">
					<option selected>소분류</option>
					<c:forEach items="${ sectionList}" var="section">
						<option value="${section.foodSectionNo }">${section.foodSectionName }</option>
					</c:forEach>
			</select></td>
		</tr>
		<tr>
                <th>납품 업체명</th>
                <td></td>
            </tr>
            <tr>
                <th>상품 가격</th>
                <td></td>
            </tr>
            <tr>
                <th>상품 사진</th>
                <td></td>
            </tr>
        </table>
       
    </article>
    <script>
    function getDivisionList(){	
		var foodDivisionNo = $("#divisionOptions option:selected").val();
    	
	var param ={
			foodDivisionNo: foodDivisionNo
		}
    	
    	$.ajax({
    		url: "${pageContext.request.contextPath}/food/admin/getUpperListToInsertFood.do",
    		data: param,
    		dataType: "json",
    		type: "POST",
    		success: (data)=> {
    			console.log(data);
    			/* for(var i in data){
    			html = "";
    			html += "<div class='main_banner_con'>";
    			html += "<a href='${pageContext.request.contextPath}/"+data[i].bannerURL + "' style='background-image:URL(${pageContext.request.contextPath}/resources/images/banner/"+data[i].bannerFileRenamed+");'class='aTag'>";
    			html += "</a></div>";
    			
    			console.log(html);
    			$(".main_banner").append(html); 
    			} */
    		},
    		error: (xhr, txtStatus, err)=> {
    			console.log("ajax 처리실패!", xhr, txtStatus, err);
    		}
    	});
    }
    	
    </script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>