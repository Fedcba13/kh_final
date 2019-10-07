<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/recipe.css">
<script>
$(()=> {
	$(".insert_btn").on("click", function() {
		if(this.value == null || this.value == "") {
			alert("로그인을 해주세요!");
			return false;
		}
		
		location.href='${pageContext.request.contextPath}/recipe/insert';
	});	
});
</script>
<section class="sub_bg"> <!--배경색이 있는 경우만 sec_bg 넣으면 됩니다.-->
	<article class="subPage inner">
	    <h3 class="sub_tit">레시피</h3>
	    <div class="recipeListDiv">
		    <c:if test="${not empty list}">
	        	<c:forEach items="${list}" var="li" varStatus="vs">
		            <c:if test="${li.recipeEnabled != 0}">
				        <ol class="recipeList">
				            <a href="${pageContext.request.contextPath}/recipe/recipeView.do?recipeNo=${li.recipeNo}&memberId=${memberLoggedIn.memberId}">
				            <li class="recipe_link">
				            <img id="recipeRecomImage" src="${pageContext.request.contextPath}/resources/upload/recipe/${image[vs.index]}" alt="" />
				            ${li.recipeTitle }
				            </li>
				            </a>
				    	</ol>            	
		            </c:if>
	            </c:forEach>
	        </c:if>	    
	    </div>
        <jsp:include page="paging.jsp" flush="true">
		    <jsp:param name="firstPageNo" value="${paging.firstPageNo}" />
		    <jsp:param name="prevPageNo" value="${paging.prevPageNo}" />
		    <jsp:param name="startPageNo" value="${paging.startPageNo}" />
		    <jsp:param name="pageNo" value="${paging.pageNo}" />
		    <jsp:param name="endPageNo" value="${paging.endPageNo}" />
		    <jsp:param name="nextPageNo" value="${paging.nextPageNo}" />
		    <jsp:param name="finalPageNo" value="${paging.finalPageNo}" />
		</jsp:include>
        <div class="recipe_insert">
        	<button class="btn insert_btn" value="${memberLoggedIn.memberId}">글쓰기</button>        
        </div>
    </article>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>