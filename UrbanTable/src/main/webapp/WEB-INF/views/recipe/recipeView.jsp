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
	
	$(".reply_btn").on("click", function(e) {
		var html = "";
		
		$(".comment_update_div").remove();
		$(".reply_add").remove();
		$(".comment_update").prop("disabled", false);
		$(".reply_btn").prop("disabled", false);
		
		html += "<div class='reply_add'>";
		html += "<form action='${pageContext.request.contextPath}/recipe/commentInsert'>"
		html += "<textarea name='boardCommentContent' id='boardCommentContentRef2' cols='70' rows='3' placeholder='비속어가 들어간 댓글은 삭제될 수 있습니다.'></textarea> ";
		html += "<button class='btn comment_insert_ref2'>등록</button>";
		html += "<input type='hidden' name='recipeNo' value='${recipe.recipeNo}' />";
		html += "<input type='hidden' name='boardCommentWriter' id='memberId' value='${memberLoggedIn.memberId}' />";
		html += "<input type='hidden' name='boardCommentLevel' value='2' />"
		html += "<input type='hidden' name='boardCommentRef' value='" + this.value + "'/>";
		html += "</form>";
		html += "</div>";
		
		$(".comment_td[value='" + this.value + "']").append(html);
		
		$(".comment_insert_ref2").on("click", function() {
			if($("#memberId").val() == "") {
				alert("로그인 후 이용해 주세요");
				return false;
			}
			
			if($("#boardCommentContentRef2").val() == null || $("#boardCommentContentRef2").val() == "") {
				alert("내용을 입력해주세요");
				return false;
			}
		});
		
		$(this).prop("disabled", true);
	});
	
	$(".comment_update").on("click", function(e) {
		var html = "";
		
		$(".reply_add").remove();
		$(".comment_update_div").remove();
		$(".reply_btn").prop("disabled", false);
		$(".comment_update").prop("disabled", false);
		
		var comment = $(".comment_content_span[value='" + this.value + "']").text();
		
		html += "<div class='comment_update_div'>";
		html += "<form action='${pageContext.request.contextPath}/recipe/commentUpdate'>"
		html += "<textarea name='boardCommentContent' id='updateCommentArea' cols='70' rows='3'>" + comment + "</textarea> ";
		html += "<button class='btn comment_update_btn'>수정</button>";
		html += "<input type='hidden' name='boardCommentNo' value='" + this.value + "' />";
		html += "<input type='hidden' name='recipeNo' value='${recipe.recipeNo}' />";
		html += "</form>";
		html += "</div>";
		
		$(".comment_td[value='" + this.value + "']").append(html);
		
		$(this).prop("disabled", true);
		
		$(".comment_update_btn").on("click", function() {
			if($("#updateCommentArea").val() == null || $("#updateCommentArea").val() == "") {
				alert("내용을 입력해주세요");
				return false;
			}
		});
	});
	
	$(".comment_insert").on("click", function() {
		if($("#memberId").val() == "") {
			alert("로그인 후 이용해 주세요");
			return false;
		}
		
		if($("#boardCommentContentRef1").val() == null || $("#boardCommentContentRef1").val() == "") {
			alert("내용을 입력해주세요");
			return false;
		}
	});
	
	$(".comment_delete").on("click", function() {
		var result = confirm("삭제하시겠습니까?");
		
		if(result) {
			return true;
		} else {
			return false;
		}
	});
	
	$(".comment_decla").on("click", function() {
		if($("#memberId").val() == "") {
			alert("로그인 후 이용해 주세요");
			return false;
		}
		
		location.href = "${pageContext.request.contextPath}/recipe/blameComment?blameTargetId=" + this.value + "&memberId="
				+ $(this).attr("memberId") + "&blameContent=" + $(this).attr("boardCommentContent") + "&recipeNo=" + $(this).attr("recipeNo");		
	});
});
</script>
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
    		<c:forEach items="${comment}" var="com" varStatus="vs">
    			<c:if test="${com.boardCommentEnabled == 1}">
		    		<c:if test="${com.boardCommentLevel == 1}">
		    			<tr class="level1">
		    				<td class="comment_td" value="${com.boardCommentNo}">
		    					<sub>${com.boardCommentWriter}</sub>
		    					<sub>${com.boardCommentDate}</sub> <br />
		    					<span class="comment_content_span" value="${com.boardCommentNo}">${com.boardCommentContent}</span> <br />
		    					<button class="reply_btn" value="${com.boardCommentNo}"><sub>답글쓰기</sub></button>
		    					<c:if test="${memberLoggedIn.memberId eq com.boardCommentWriter}">
			    					<button class="comment_update" value="${com.boardCommentNo}"><sub>수정</sub></button>
			    				</c:if>	
			    				<c:if test="${memberLoggedIn.memberId ne com.boardCommentWriter}">
			    					<button class="comment_decla" value="${com.boardCommentWriter}" memberId=${memberLoggedIn.memberId}
			    						boardCommentContent=${com.boardCommentContent} recipeNo=${recipe.recipeNo}><sub>신고</sub></button>
			    				</c:if>
		    				</td>
		    				<td style="text-align:right; vertical-align:top;">
		    					<c:if test="${memberLoggedIn != null && (memberLoggedIn.memberId eq com.boardCommentWriter || memberLoggedIn.memberCheck == 9)}">
			    					<form action="${pageContext.request.contextPath}/recipe/commentDelete">
				    					<button class="comment_delete">x</button>
				    					<input type="hidden" name="boardCommentNo" value="${com.boardCommentNo}" />
				    					<input type="hidden" name="recipeNo" value="${recipe.recipeNo}" />		    					
			    					</form>
			    				</c:if>	
		    				</td>
		    			</tr>    		
		    		</c:if>
		    		<c:if test="${com.boardCommentLevel == 2}">
		    			<tr class="level2">
		    				<td class="comment_td" value="${com.boardCommentNo}">
		    					<sub>${com.boardCommentWriter}</sub>
		    					<sub>${com.boardCommentDate}</sub> <br />
		    					<c:forEach items="${comment}" var="c">
		    						<c:if test="${c.boardCommentNo eq com.boardCommentRef}">
		    							<span class="ref_writer">@${c.boardCommentWriter}</span> 
		    						</c:if>
		    					</c:forEach>
		    					<span class="comment_content_span" value="${com.boardCommentNo}">${com.boardCommentContent}</span> <br />
		    					<button class="reply_btn" value="${com.boardCommentNo}"><sub>답글쓰기</sub></button>
		    					<c:if test="${memberLoggedIn != null && memberLoggedIn.memberId eq com.boardCommentWriter}">
			    					<button class="comment_update" value="${com.boardCommentNo}"><sub>수정</sub></button>
			    				</c:if>
			    				<c:if test="${memberLoggedIn.memberId ne com.boardCommentWriter}">
			    					<button class="comment_decla" value="${com.boardCommentWriter}" memberId=${memberLoggedIn.memberId}
			    						boardCommentContent=${com.boardCommentContent} recipeNo=${recipe.recipeNo}><sub>신고</sub></button>
			    				</c:if>
		    				</td>
		    				<td style="text-align:right; vertical-align:top;">
		    					<c:if test="${(memberLoggedIn.memberId eq com.boardCommentWriter || memberLoggedIn.memberCheck == 9)}">
			    					<form action="${pageContext.request.contextPath}/recipe/commentDelete">
				    					<button class="comment_delete">x</button>
				    					<input type="hidden" name="boardCommentNo" value="${com.boardCommentNo}" />
				    					<input type="hidden" name="recipeNo" value="${recipe.recipeNo}" />		    					
			    					</form>
			    				</c:if>	
		    				</td>
		    			</tr>
		    		</c:if>	
    			</c:if>
    		</c:forEach>
    	</c:if>
    	<c:if test="${empty comment}">
    		<tr>
    			<td colspan="2" style="text-align:center;">댓글이 없습니다</td>
    		</tr>
    	</c:if>
    </table>
    <div class="content_add">
    	<form action="${pageContext.request.contextPath}/recipe/commentInsert">
    		<textarea name="boardCommentContent" id="boardCommentContentRef1" cols="100" rows="3" placeholder="비속어가 들어간 댓글은 삭제될 수 있습니다."></textarea>
    		<button class="btn comment_insert">등록</button>
    		<input type="hidden" name="recipeNo" value="${recipe.recipeNo}" />
    		<input type="hidden" name="boardCommentWriter" id="memberId" value="${memberLoggedIn.memberId}" />
    		<input type="hidden" name="boardCommentLevel" value="1" />
    	</form>
    </div>
    <div class="list_btn">
    	<button class="btn" onclick="location.href='${pageContext.request.contextPath}/recipe/recipe'">목록</button>    
    </div>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>