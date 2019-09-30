<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/recipe.css">
<c:if test="${recipe.recipeEnabled != 1}">
	<script>
		alert("삭제된 게시물입니다!");
		history.back();
	</script>
</c:if>
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
        <div class="materialList">
        	<c:if test="${not empty material}">
		        <c:forEach items="${material}" var="m" varStatus="st">
		        	${m.foodSectionName}
		        	<c:if test="${!st.last}">
		        		,
		        	</c:if>
		        </c:forEach>                	
        	</c:if>
        </div>
        <h3 class="recipe_view_h3">레시피</h3>
        <ol class="recipeOl">
        	<c:forEach items="${recipe.recipeSequenceList}" var="rec">
	        	<li>${rec.recipeContent}</li>
        	</c:forEach>
        </ol>
    </article>
    <hr width="97%" />
    <h2 class="comment_h2">댓글(${comment.size()})</h2>
    <table class="tbl tbl_view" style="width:90%; margin:auto; margin-top:20px;">
    	<c:if test="${not empty comment}">
    		<c:forEach items="${comment}" var="com" >
    			<tr class="level${com.boardCommentLevel}">
    				<td>
    					<sub>${com.boardCommentWriter}</sub>
    					<sub>${com.boardCommentDate}</sub> <br />
    					${com.boardCommentContent}
    				</td>
    				<td class="comment_btn">
	    				<button class="btn btn2" value="${com.boardCommentNo}">답글</button>
	    				<c:if test="${memberLoggedIn != null && (memberLoggedIn.memberId eq com.boardCommentWriter || memberLoggedIn.memberCheck == 9)}">
	    					<button class="" value="${com.boardCommentNo}">x</button>
	    				</c:if>    					
    				</td>
    			</tr>
    		</c:forEach>
    	</c:if>
    	<c:if test="${empty comment}">
    		<tr>
    			<td colspan="2" style="text-align:center;">댓글이 없습니다</td>
    		</tr>
    	</c:if>
    </table>
    <div class="content_add">
    	<form action="">
    		<textarea name="boardCommentContent" id="boardCommentContent" cols="100" rows="3"></textarea>
    		<button class="btn comment_insert">등록</button>
    	</form>
    </div>
    <div class="list_btn">
    	<button class="btn" onclick="location.href='${pageContext.request.contextPath}/recipe/recipe'">목록</button>    
    </div>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>