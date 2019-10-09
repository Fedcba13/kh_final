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
	
	var memberId = "${memberLoggedIn.memberId}";
	var recipeNo = "${recipe.recipeNo}";
	
	if(memberId != "") {
		$.ajax({
			url: "${pageContext.request.contextPath}/recipe/selectGood",
			data: {memberId: memberId, recipeNo: recipeNo},
			dataType: "json",
			type: "GET",
			success: (data)=>{
				console.log(data);
				$("#good").val(data);
			},
			error: (xhr, txtStatus, err)=> {
				console.log("ajax 처리실패!", xhr, txtStatus, err);
			}
		});
		
		$.ajax({
			url: "${pageContext.request.contextPath}/recipe/selectBad",
			data: {memberId: memberId, recipeNo: recipeNo},
			dataType: "json",
			type: "GET",
			success: (data)=>{
				console.log(data);
				$("#bad").val(data);
			},
			error: (xhr, txtStatus, err)=> {
				console.log("ajax 처리실패!", xhr, txtStatus, err);
			}
		});
	}
	
	$(".reaction").on("click", function(e) {
		if($("#memberId").val() == "") {
			alert("로그인을 해주세요!");
			return false;
		}
		
		var checkMember = "${recipe.memberId}";
		if(memberId == checkMember) {
			alert("본인의 글에 좋아요 혹은 싫어요를 누를 수 없습니다.");
			return false;
		}
		
		var type = $(this).attr("id");
		var check = $(this).val();
		var targetId = recipeNo;
		$.ajax({
			url: "${pageContext.request.contextPath}/recipe/insertGoodorBad",
			data: {type: type, check: check, memberId: memberId, targetId: targetId},
			dataType: "json",
			type: "GET",
			success: (data)=>{
				console.log(data);
				if(data > 0) {
					if(type == "good") {
						if(check == 0) {
							$(this).val(1);
						} else {
							$(this).val(0);
						}
					} else {
						if(check == 0) {
							$(this).val(1);
						} else {
							$(this).val(0);
						}
					}
					alert($(this).val());
				}
			},
			error: (xhr, txtStatus, err)=> {
				console.log("ajax 처리실패!", xhr, txtStatus, err);
			}
		});
		
		$.ajax({
			url: "${pageContext.request.contextPath}/recipe/countGoodorBad",
			data: {type: type, targetId: targetId},
			dataType: "json",
			type: "GET",
			success: (data)=>{
				console.log(data);
				alert(data);
				if(type == "good") {
					$("#good>p").html(data);
				} else {
					$("#bad>p").html(data);
				}
			},
			error: (xhr, txtStatus, err)=> {
				console.log("ajax 처리실패!", xhr, txtStatus, err);
			}
		});
	});
	
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
		
		var html = "";
		
		$(".reply_add").remove();
		$(".comment_update_div").remove();
		$(".comment_decla_div").remove();
		$(".reply_btn").prop("disabled", false);
		$(".comment_update").prop("disabled", false);
		$(".comment_blame_btn").prop("disabled", false);
		
		var comment = $(".comment_content_span[value='" + this.value + "']").text();
		
		html += "<div class='comment_decla_div'>";
		html += "<form action='${pageContext.request.contextPath}/recipe/blameComment'>"
		html += "<textarea name='blameContent' id='blameContent' cols='70' rows='3'></textarea> ";
		html += "<button class='btn comment_blame_btn'>신고</button>";
		html += "<input type='hidden' name='blameTargetId' value='" + this.value + "' />";
		html += "<input type='hidden' name='memberId' value='${memberLoggedIn.memberId}' />";
		html += "<input type='hidden' name='recipeNo' value='${recipe.recipeNo}' />";
		html += "<input type='hidden' name='targetType' value='4' />";
		html += "</form>";
		html += "</div>";
		
		$(".comment_td[value='" + this.value + "']").append(html);
		
		$(this).prop("disabled", true);
		
		$(".comment_blame_btn").on("click", function() {
			if($("#blameContent").val() == null || $("#blameContent").val() == "") {
				alert("내용을 입력해주세요");
				return false;
			}
		});		
	});
	
	$(".recipe_delete_btn").on("click", function() {
		var result = confirm("삭제하시겠습니까?");
		
		if(result) {
			location.href = "${pageContext.request.contextPath}/recipe/recipeDelete?recipeNo=" + this.value;
		} else {
			return false;
		}
	});
	
	$(".recipe_update_btn").on("click", function() {
		location.href = "${pageContext.request.contextPath}/recipe/recipeUpdate?recipeNo=" + this.value;
	});
	
	$(".recipe_declare_btn").on("click", function() {
		var loc = "${pageContext.request.contextPath}/recipe/recipeBlame?recipeNo=" + this.value;
		
		window.open(loc,'신고','width=430,height=500,location=no,status=no,scrollbars=no');
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
		<div class="update_div">
		<c:if test="${memberLoggedIn != null && memberLoggedIn.memberId eq recipe.memberId}">
			<button class="btn recipe_update_btn" value="${recipe.recipeNo}">수정</button>
			<button class="btn recipe_delete_btn" value="${recipe.recipeNo}">삭제</button>
		</c:if>		
		<c:if test="${memberLoggedIn != null && memberLoggedIn.memberId ne recipe.memberId}">
			<button class="btn recipe_declare_btn" value="${recipe.recipeNo}">신고</button>
		</c:if>		
		</div>
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
        <table class="recipe_sequence_table">
        	<c:forEach items="${recipe.recipeSequenceList}" var="rec">
        		<tr>
	        		<td class="recipeImgTd"><img id="recipeImg" src="${pageContext.request.contextPath}/resources/upload/recipe/${rec.renamedRecipePic}" alt="" /></td>
		        	<td class="recipeContentTd">${rec.recipeContent}</td>        		
        		</tr>
        	</c:forEach>
        </table>
        <div class="recomList">
        	<hr width="20px" style="border:2px solid black; display:inline-block; text-align:left; margin-bottom:0px;" />
        	<h5 style="margin-bottom: 10px;">RECIPE ITEMS</h5>
        	<div id="recomOlDiv">
			    <ol class="recomOl">
		        	<c:if test="${not empty material}">
				        <c:forEach items="${material}" var="m">
				        	<c:if test="${m.foodNo != null}">
				        			<li>
				        				<img class="foodImg" src="${m.foodImg}" alt="" />
				        				${m.foodName}
				        			</li>
				        	</c:if>
				        </c:forEach>                	
		        	</c:if>
	    		</ol>        	
        	</div>
        </div>
    </article>
    <div class="reaction_div">
	    <button class="reaction" id="good" value=0><img src="${pageContext.request.contextPath}/resources/images/recipe/thumbs-up.png" alt="" /><p>${goodCount}</p></button>
	    <button class="reaction" id="bad" value=0><img src="${pageContext.request.contextPath}/resources/images/recipe/thumb-down.png" alt="" /><p>${badCount}</p></button>    
    </div>
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
			    					<button class="comment_decla" value="${com.boardCommentNo}"><sub>신고</sub></button>
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
			    					<button class="comment_decla" value="${com.boardCommentNo}"><sub>신고</sub></button>
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