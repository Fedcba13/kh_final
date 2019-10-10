<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/food.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/main.css">
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/main.js"></script>
<style>
.did ~ p{
	font-weight: bold;
	color: #374818;
}

.review_tbl{
	margin-top: 30px;
}

.review_tbl tr th{
	padding: 20px 0;
}

.review_tbl .btn{
	width: 50px;
}

.review_tbl tr > td:nth-child(1){
	width: 130px;
}

.review_tbl tr > td:nth-child(2) {
	text-align: left;
	padding: 20px 0px 20px 30px;
}

.review_tbl tr > td:nth-child(3) {
	width: 250px;
}

.review_tbl tr > td:nth-child(4) {
	width: 150px;
}

.review_tbl tr > td:nth-child(4) > p {
	display: inline-block;
	cursor: pointer;
}

.review_tbl .review_content{
		width: 80%;
	}

</style>

<script>
$(()=>{
	var memberId = '${memberLoggedIn.memberId}';
	var marketNo = '${marketNo}';
	var foodNo = '${food.foodNo}';
	var param = {
			marketNo: marketNo,
			foodNo : foodNo
	}
	
	$("#noticeStock").click(()=>{
		
		$.ajax({
			url: contextPath + "/member/stockNotice",
			data: param,
			type: "POST",
			success: (data)=>{
				alert(data.msg);
				location.reload();
			},
			error: (xhr, txtStatus, err)=> {
				console.log("ajax 처리실패!", xhr, txtStatus, err);
			}
		})
		
	});
	
	$.ajax({
		url: contextPath + "/member/selectReview",
		data: param,
		type: "POST",
		success: (data)=>{
			console.log(data.length);
			console.log(data[0]);
			var html = '';
			if(data.length != 0){
				for(var i=0; i<data.length; i++){
					
					var reviewDate = toDate(data[i].REVIEW_DATE);
					
					html += '<tr>';
					html += '	<td>'+data[i].MEMBER_ID+'<input type="hidden" class="pay_detail_no" value="'+data[i].PAY_DETAIL_NO+'"></td>';
					html += '	<td>'+data[i].REVIEW_CONTENT+'</td>';
					html += '	<td>'+reviewDate+'</td>';
					if(data[i].MEMBER_ID == memberId){
						html += '	<td><p class="modify">수정</p>&nbsp;&nbsp;&nbsp;<p class="delete">삭제</p></td>';
					}else if (memberId == null || memberId == ''){
						html += '	<td></td>';
					}else{
						html += '	<td><p class="report">신고</p></td>';
					}
					html += '</tr>';
					
				}
			}else if(data.length == 0){
				html += '<tr><td colspan="3">관련 리뷰가 없습니다.</td></tr>';	
			}
					$(".review_tbl").append(html);
			
			$(".review_tbl .modify").on('click', modifyReview);
			$(".review_tbl .delete").on('click', deleteReview);
			$(".review_tbl .report").on('click', reportReview);
			
		},
		error: (xhr, txtStatus, err)=> {
			console.log("ajax 처리실패!", xhr, txtStatus, err);
		}
	});

	
});

function reportReview(e){
	var marketNo = '${marketNo}';
	var foodNo = '${food.foodNo}';
	var detailNo = $(e.target).parents("tr").find(".pay_detail_no").val();
	var loc = "${pageContext.request.contextPath}/recipe/recipeBlame?recipeNo=" + detailNo+"&type=2&foodNo="+foodNo+"&marketNo="+marketNo;
	
	window.open(loc,'신고','width=430,height=500,location=no,status=no,scrollbars=no');
}

function modifyReview(e){
	var txt = $(e.target).parents("tr").children().eq(1).text();
	$(e.target).parents("tr").children().eq(1).html('<input type="text" value="'+txt+'" class="review_content">');
	
	$(e.target).parents("tr").find('.modify').addClass('confirm').removeClass('modify').text('확인').off().click((e)=>{
		confirmReview(e);
	});
	
	$(e.target).parents("tr").find('.delete').addClass('cancle').removeClass('.delete').text('취소').off().click((e)=>{
		cancleModify(e);
	});
	
}

function deleteReview(e){
	var detail_no = $(e.target).parents("tr").find('.pay_detail_no').val();
	$.ajax({
		url: contextPath + "/member/deleteReview",
		data: {detailNo : detail_no},
		type: "POST",
		success: function(data){
			console.log(data);
			alert(data.msg);
			
			$(e.target).parents("tr").remove();
			
		},
		error: function(xhr, txtStatus, err){
			console.log("ajax 처리 실패", xhr, txtStatus, err);
		}
	});
}

function confirmReview(e){
	
	var detail_no = $(e.target).parents("tr").find('.pay_detail_no').val();
	var txt = $(e.target).parents("tr").find(".review_content").val();
	
	var param = {
			detailNo : detail_no,
			content : txt
	}
	
	$.ajax({
		url: contextPath + "/member/modifyReview",
		data: param,
		type: "POST",
		success: function(data){
			console.log(data);
			alert(data.msg);
			
			var txt = $(e.target).parents("tr").find(".review_content").val();
			
			$(e.target).parents("tr").children().eq(1).html(txt);
			
			$(e.target).parents("tr").find('.confirm').removeClass('confirm').addClass('modify').text('수정').off().click((e)=>{
				modifyReview(e);
			});
			
			$(e.target).parents("tr").find('.cancle').removeClass('cancle').addClass('.delete').text('삭제').off().click((e)=>{
				deleteReview(e);
			});
			
		},
		error: function(xhr, txtStatus, err){
			console.log("ajax 처리 실패", xhr, txtStatus, err);
		}
	});
}

function cancleModify(e){
	
	var txt = $(e.target).parents("tr").find(".review_content").val()
	
	$(e.target).parents("tr").children().eq(1).html(txt);
	
	$(e.target).parents("tr").find('.confirm').removeClass('confirm').addClass('modify').text('수정').off().click((e)=>{
		modifyReview(e);
	});
	
	$(e.target).parents("tr").find('.cancle').removeClass('cancle').addClass('.delete').text('삭제').off().click((e)=>{
		deleteReview(e);
	});
	
}
</script>
	<article class="subPage inner">
	    <h3 class="sub_tit">상품정보</h3>
		 <div id="foodExpression">
		<div id="foodExpressionImg">
			<c:if test="${not empty food.foodImg }">
				<img src="${food.foodImg }" alt="상품 사진">
			</c:if>
			<c:if test="${not empty food.foodRenamedFileName }">
				<img
					src="${pageContext.request.contextPath}/resources/upload/food/${food.foodRenamedFileName}"
					alt="상품 사진">
			</c:if>
			<div id="good">
				<div id="dislike">
					<img
						src="${pageContext.request.contextPath }/resources/images/food/dislike.png" alt="싫어요" id="badImg" name="BAD" />
						<p id="badText">&lpar;${food.bad }&rpar;</p>
				</div>
				<div id="like">
					<img
						src="${pageContext.request.contextPath }/resources/images/food/like.png" id="goodImg" alt="좋아요" name="GOOD"/>
						<p id="goodText">&lpar;${food.good }&rpar;</p>
				</div>
			</div>
		</div>
		<div id="foodExpressionTb">
				<p> ${food.foodName }</p>
				<table class="tbl">
					<tr>
						<th>판매가</th>
						<td id="foodPrice">
							<p class="prd_price"><fmt:formatNumber value="${food.foodMemberPrice }" pattern="#,###" />원 </p>
							<input type="hidden" id="hiddenPrice" value="${ food.foodMemberPrice-food.foodMemberPrice*(food.eventPercent/100) }" />
						</td>
					</tr>
					<c:if test="${ food.eventPercent ne 0}">
						<tr>
	                        <th>할인가</th>
	                        <td><p class="prd_price"><fmt:formatNumber value="${ food.foodMemberPrice-food.foodMemberPrice*(food.eventPercent/100) } "
								pattern="#,###" />원 </p></td>
	                    </tr>
                    </c:if>
					<tr>
						<th>배송구분</th>
						<td>샛별배송/택배배송</td>
					</tr>
					<tr>
						<th>지점</th>
						<td>
							${market.marketName }
						</td>
					</tr>
					<tr>
						<th>전화번호</th>
						<td>
							${market.marketTelephone }
						</td>
					</tr>
					<tr>
						<th>구매수량</th>
						<td>
						<c:if test="${empty food.marketName }">
							<p>준비중인 상품입니다!</p>						
						</c:if>
						<c:if test="${not empty food.marketName }">
							<input id="amount" type="number" value="1">
						</c:if>
						
						</td>
					</tr>
					<tr>
						<th>안내사항</th>
						<td>별도의 유통기한은 없으나 식품 특성상 가급적 빨리 드시기 바랍니다.</td>
					</tr>
				</table>
					<div class="txt_right">
						<c:if test="${empty food.marketName }">
							<input type="button" id="noticeStock" value="재고 알림" class="btn btn2" >
						</c:if>
						<c:if test="${not empty food.marketName }">
							<p id="finalPrice">총 상품 금액 : 
							<c:if test="${food.eventPercent ne 0}">
									<span class="dp_ib fw600"><fmt:formatNumber value="${ food.foodMemberPrice-food.foodMemberPrice*(food.eventPercent/100) } "
									pattern="#,###" /></span>원 
							</c:if>
							<c:if test="${food.eventPercent eq 0}">
								<span class="dp_ib fw600"><fmt:formatNumber value="${food.foodMemberPrice }" pattern="#,###" /></span>원 
							</c:if>
						</c:if>
						</p>
					</div>
					<div id="buttons">
						<c:if test="${not empty food.marketName }">
							<input type="button" id="noticeStock" value="재고 알림" class="btn btn2" >
							<input type="button" value="장바구니 담기" class="btn btn" onclick="cartValidate();"/>
						</c:if>
						<!-- <button id="noticeStock">재고알림</button> -->
					</div>
			</div>
			</div>
			 <section class="sec_bg">
			 <h3 class="main_tit txt_center">상품 이미지</h3>
			 <div id="detailView">
					 <c:if test="${not empty food.foodImg }">
						<img src="${food.foodImg }" alt="상품 사진">
					</c:if>
					<c:if test="${not empty food.foodRenamedFileName }">
						<img
							src="${pageContext.request.contextPath}/resources/upload/food/${food.foodRenamedFileName}"
							alt="상품 사진">
					</c:if>
			 </div>
			 </section>
			 <h3 class="main_tit txt_center">관련 레시피</h3>
	        <ul class="main_event_list main_receipe txt_center clearfix" id="toAppend">
	            <li>
	                <a href="" class="dp_block">
	                    <div class="event_img_area">
	                        <img src="${pageContext.request.contextPath }/resources/images/example2.PNG" alt="이벤트 사진">
	                    </div>
	                    <div class="event_info_area">
	                        <p>레시피명</p>
	                    </div>
	                </a>
	            </li> 
	        </ul>
        <table class="tbl txt_center review_tbl">
            <tr>
                <th>작성자</th>
                <th>한줄평</th>
                <th>작성일</th>
                <th></th>
            </tr>
        </table>
        
        <input type="hidden" name="" id="foodNoToRe" value="${food.foodNo }" />
        <input type="hidden" name="" id="memberLoggedInView" value="${memberLoggedIn.memberId }" />
        
</article>
	<script>
	$('#amount').change(function() {
		var amount = $("#amount").val();
		var html = "";		
		if(amount <=0){
			$("#amount").val(0);
			html = "총 상품금액 : <span class='dp_ib fw600'>0</span>원"; 
		}else{
		var finalPrice = $("#hiddenPrice").val()*amount;
		var ppp =  finalPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		html = "총 상품금액 : <span class='dp_ib fw600'>"+ppp+"</span>원" 
			
		}
		 $("#finalPrice").html(html);  
	}); 
	
	
	function cartValidate(){
		var foodNo = $("#foodNoToRe").val();
		var memberId = $("#memberLoggedInView").val();
		var cartAmount = $("#amount").val()
		var memberCheck = '${memberLoggedIn.memberCheck}';
		
		var goCart = function(){
			var pram = {
					memberId : memberId,
					memberCheck : memberCheck
			}
			$.ajax({
				 url: "${pageContext.request.contextPath}/cart/cartList.do",
				 dataType: "json",
				type: "POST",
				success: (data)=> {
				},
				error: (xhr, txtStatus, err)=> {
					console.log("ajax 처리실패!", xhr, txtStatus, err);
				}
			});
		}
		
		if(memberId.trim().length == 0 ){
			alert("로그인 후 이용가능합니다!");
		}else if(cartAmount == 0){
			alert("구매수량을 입력해주세요!");
		} else if(memberCheck != 1){
			alert("접근하실 수 없는 권한이십니다.");
		}
		else{
			var param = {
					foodNo : foodNo,
					memberId : memberId,
					cartAmount : cartAmount
			}
			$.ajax({
				 url: "${pageContext.request.contextPath}/cart/insertToCartByUser.do", 
				 dataType: "json",
				 data: param,
				type: "POST",
				success: (data)=> {
				},
				error: (xhr, txtStatus, err)=> {
					console.log("ajax 처리실패!", xhr, txtStatus, err);
				}
			});
			var bool  = confirm("장바구니에 담겼습니다. 장바구니로 이동하시겠습니까?");
			if(bool){
				location.href = "${pageContext.request.contextPath}/cart/cartList.do?memberId="+memberId+"&memberCheck="+memberCheck;
			}
		} 
		
		
	}
	
	
	$(()=>{

		
		var foodNo = $("#foodNoToRe").val();
		var memberId = $("#memberLoggedInView").val();
		var memberCheck = '${memberLoggedIn.memberCheck}';
		if(memberCheck != 1){
			memberId = 'all';
		}
		var param = {
				foodNo : foodNo,
				memberId : memberId
		}
		
		
		var getGoodInView = function(){
			$.ajax({
		    	url: "${pageContext.request.contextPath}/food/goodOrBad.do",
		    	type: "get",
				data: param,
		   		success: (data)=> {
		   			var htmlInLike = '';
		   			var htmlInBad= ' ';
		   			
	   				//좋아요 싫어요를 아예 못할 사람
	   				if(memberCheck != 1){
			   				htmlInLike += '<img src="${pageContext.request.contextPath }/resources/images/food/like.png"  id="goodImg" alt="좋아요" name="GOOD"/><p id="goodText">&lpar;'+data.totalGood+'&rpar;</p> ';
			   				htmlInBad += '<img src="${pageContext.request.contextPath }/resources/images/food/dislike.png"  id="badImg" alt="싫어요" name="BAD"/><p id="badText">&lpar;'+data.totalBad+'&rpar;</p> ';
	   				}
	   				//좋아요 싫어요 가능할
	   				else{
	   					//좋아요 싫어요를 했다면
			   			if(data && ((data.good == 1) || data.bad == 1)){
			   				
			   				//좋아요
			   				if(data.good == 1 ){
			   					htmlInLike += '<img src="${pageContext.request.contextPath }/resources/images/food/liked.png" class="did" id="goodImg" alt="좋아요" name="GOOD"/><p id="goodText">&lpar;'+data.totalGood+'&rpar;</p> ';
			   					htmlInBad += '<img src="${pageContext.request.contextPath }/resources/images/food/dislike.png" class="didnt" id="badImg" alt="싫어요" name="BAD"/><p id="badText">&lpar;'+data.totalBad+'&rpar;</p> ';
			   						
			   				}//싫어요
			   				else if (data.bad == 1){
			   					htmlInLike += '<img src="${pageContext.request.contextPath }/resources/images/food/like.png" class="didnt"  id="goodImg" alt="좋아요" name="GOOD"/><p id="goodText">&lpar;'+data.totalGood+'&rpar;</p> ';
			   					htmlInBad += '<img src="${pageContext.request.contextPath }/resources/images/food/disliked.png" class="did"  id="badImg" alt="싫어요" name="BAD"/><p id="badText">&lpar;'+data.totalBad+'&rpar;</p> ';
			   				
			   				}
			   			}
			   			//한적만 있음.
		   				else if((data.good==0) && (data.good==0)){
		   					htmlInLike += '<img src="${pageContext.request.contextPath }/resources/images/food/like.png"  class="didntX"  id="goodImg" alt="좋아요" name="GOOD"/><p id="goodText">&lpar;'+data.totalGood+'&rpar;</p> ';
		   					htmlInBad += '<img src="${pageContext.request.contextPath }/resources/images/food/dislike.png" class="didntX" id="badImg" alt="싫어요" name="BAD"/><p id="badText">&lpar;'+data.totalBad+'&rpar;</p> ';
		   				}
			   			//좋아요 싫어요 한번도 안함
		   				else if(!data ){
		   					htmlInLike += '<img src="${pageContext.request.contextPath }/resources/images/food/like.png" class="didntXX" id="goodImg" alt="좋아요" name="GOOD"/><p id="goodText">&lpar;'+data.totalGood+'&rpar;</p> ';
		   					htmlInBad += '<img src="${pageContext.request.contextPath }/resources/images/food/dislike.png" class="didntXX" id="badImg" alt="싫어요" name="BAD"/><p id="badText">&lpar;'+data.totalBad+'&rpar;</p> ';
		   				}
	   				}
		   			
		   			$("#like").html(htmlInLike);
		   			$("#dislike").html(htmlInBad);
	
		   		},
		   		error: (xhr, txtStatus, err)=> {
		   			console.log("ajax 처리실패!", xhr, txtStatus, err);
		   		}
		   	}); 
		}
		
			getGoodInView();
		
			$(document).on('click', '#like', function(){
				var memberId = $("#memberLoggedInView").val();
				if(memberId.trim().length == 0 ){
					alert("로그인 후 이용가능합니다!");
				}
			});
			$(document).on('click', '#dislike', function(){
				var memberId = $("#memberLoggedInView").val();
				if(memberId.trim().length == 0 ){
					alert("로그인 후 이용가능합니다!");
				}
			});
			
		$(document).on('click', '.did', function(){
			$.ajax({
		    	url: "${pageContext.request.contextPath}/food/cancelGood.do",
		    	type: "get",
				data: param,
		   		success: (data)=> {
		   			getGoodInView();
		   		},
		   		error: (xhr, txtStatus, err)=> {
		   			console.log("ajax 처리실패!", xhr, txtStatus, err);
		   		}
			});
		});
		$(document).on('click', '.didnt', function(){
			 $.ajax({
		    	url: "${pageContext.request.contextPath}/food/changeGood.do",
		    	type: "get",
				data: param,
		   		success: (data)=> {
		   			getGoodInView();
		   		},
		   		error: (xhr, txtStatus, err)=> {
		   			console.log("ajax 처리실패!", xhr, txtStatus, err);
		   		}
		   	});  
		});
		$(document).on('click', '.didntX', function(){
			var column = $(this).attr('name')
			
			var params = {
					foodNo : foodNo,
					memberId : memberId,
					column : column
			}
			
			$.ajax({
		    	url: "${pageContext.request.contextPath}/food/updateGood.do",
		    	type: "get",
				data: params,
		   		success: (data)=> {
		   			getGoodInView();
		   		},
		   		error: (xhr, txtStatus, err)=> {
		   			console.log("ajax 처리실패!", xhr, txtStatus, err);
		   		}
		   	}); 
		});
		$(document).on('click', '.didntXX', function(){
			var column = $(this).attr('name')
			var params = {
				foodNo : foodNo,
				memberId : memberId,
				column : column
			}
			
			$.ajax({
		    	url: "${pageContext.request.contextPath}/food/insertGood.do",
		    	type: "get",
				data: params,
		   		success: (data)=> {
		   			getGoodInView();
		   		},
		   		error: (xhr, txtStatus, err)=> {
		   			console.log("ajax 처리실패!", xhr, txtStatus, err);
		   		}
		   	}); 
			
		});
			
		
		// 관련 레시피 출력
		$.ajax({
	    	url: "${pageContext.request.contextPath}/food/selectRelatedRecipe.do",
	    	type: "get",
			data: param,
	   		success: (data)=> {
	   			console.log(data);
	   			var html = ' ';
	   			if(data.length != 0){
		   			for(var i in data){
		   				console.log('<img src="${pageContext.request.contextPath }/resources/upload/recipe/'+data[i].renamedRecipePic+'">');
		   				html += '<li>  <a href="${pageContext.request.contextPath}/recipe/recipeView.do?recipeNo='+data[i].recipeNo+'&memberId='+memberId+'" class="dp_block"><div class="event_img_area">';
		   				html += '<img src="${pageContext.request.contextPath }/resources/upload/recipe/'+data[i].renamedRecipePic+'">';
		   				html += '</div><div class="event_info_area">  <p>'+data[i].recipeTitle+'</p>';
		   				html += '</div> </a> </li> ';
		   			} 
	   				
	   			}else if(data.length == 0){
	   				html += '<p>관련 레시피가 없습니다.</p>';
	   			}
	   				$("#toAppend").html(html); 
	   		},
	   		error: (xhr, txtStatus, err)=> {
	   			console.log("ajax 처리실패!", xhr, txtStatus, err);
	   		}
	   	}); 
	});
	
	</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>