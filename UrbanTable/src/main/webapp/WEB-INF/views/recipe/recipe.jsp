<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/recipe.css">
<section class="sub_bg"> <!--배경색이 있는 경우만 sec_bg 넣으면 됩니다.-->
	<article class="subPage inner">
	    <h3 class="sub_tit">레시피</h3>
	    <table class="tbl txt_center"> <!--가운데 정렬 아니면 txt_center 빼셔도 됩니다.
	                                    width 값은 th에 width="150" 이런식으로 써주시면 됩니다.-->
            <tr>
                <th>작성자</th>
                <th>제목</th>
                <th>조회수</th>
                <th>작성일</th>
            </tr>
            <c:if test="${not empty list}">
            	<c:forEach items="${list}" var="li">
	            	<c:if test="${li.recipeEnabled != 0}">
			            <tr>
			                <td>${li.memberId }</td>
			                <td class="recipe_link"><a href="${pageContext.request.contextPath}/recipe/recipeView.do?recipeNo=${li.recipeNo}&memberId=${memberLoggedIn.memberId}">${li.recipeTitle }</a></td>
			                <td>${li.recipeReadcount }</td>
			                <td>${li.recipeDate }</td>
			            </tr>            	
	            	</c:if>
            	</c:forEach>
            </c:if>
        </table>
        <div class="recipe_insert">
        	<button class="btn" onclick="location.href='${pageContext.request.contextPath}/recipe/insert'">글쓰기</button>        
        </div>
    </article>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>