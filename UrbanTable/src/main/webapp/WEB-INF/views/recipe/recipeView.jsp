<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/recipe.css">

<section class=""> <!--배경색이 있는 경우만 sec_bg 넣으면 됩니다.-->
	<article class="subPage inner">
        <table class="tbl tbl_view">
            <c:if test="${not empty recipe}">
            	<tr>
            		<th>제목</th>
		            <td colspan="3">${recipe.recipeTitle }</td>
		        </tr>
	            <tr>
	                <th>작성자</th>
		            <td colspan="3">${recipe.memberId }</td>	                
	            </tr>
		        <tr>
		        	<th>조회수</th>
		            <td>${recipe.recipeReadcount }</td>
	                <th>작성일</th>
		            <td>${recipe.recipeDate }</td>
		        </tr>
            </c:if>
        </table>
        <h1 class="recipe_view_h1">Recipe</h1>
        <hr style="width:400px;" />
        <h2 class="recipe_view_h2">${recipe.recipeTitle}</h2>
        <h3 class="recipe_view_h3">재료</h3>
        
        <h3 class="recipe_view_h3">레시피</h3>
        <ol class="recipeOl">
        	<c:forEach items="${recipe.recipeSequenceList}" var="rec">
	        	<li>${rec.recipeContent}</li>
        	</c:forEach>
        </ol>
    </article>
    <button class="btn" onclick="location.href='${pageContext.request.contextPath}/recipe/recipe'">목록</button>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>