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
</style>
<script>
$(()=>{
	
	var marketNo = '${food.marketNo}';
	var foodNo = '${food.foodNo}';
	
	$("#noticeStock").click(()=>{
		
		var param = {
				marketNo: marketNo,
				foodNo : foodNo
		}
		
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
});
</script>
	<article class="subPage inner">
	    <h3 class="sub_tit">상품정보</h3>
		 <div id="foodExpression">
		<div id="foodExpressionImg">
			<img src="${food.foodImg }" alt="상품사진" />
			<div id="good">
				<div id="dislike">
					<img
						src="${pageContext.request.contextPath }/resources/images/food/dislike.png" alt="싫어요" id="badImg" name="BAD" />
						<br />
						<p id="badText">&lpar;${food.bad }&rpar;</p>
				</div>
				<div id="like">
					<img
						src="${pageContext.request.contextPath }/resources/images/food/like.png" id="goodImg" alt="좋아요" name="GOOD"/>
						<br />
						<p id="goodText">&lpar;${food.good }&rpar;</p>
				</div>
			</div>
		</div>
		<div id="foodExpressionTb">
				<p> ${food.foodName }</p>
				<table class="tbl txt_center">
					<!--가운데 정렬 아니면 txt_center 빼셔도 됩니다.
	                                    width 값은 th에 width="150" 이런식으로 써주시면 됩니다.-->
					<tr>
						<th>판매가</th>
						<td id="foodPrice">
						<c:if test="${ food.eventPercent ne 0}">
								<p class="prd_price"><fmt:formatNumber value="${ food.foodMemberPrice-food.foodMemberPrice*(food.eventPercent/100) } "
								pattern="#,###" />원 </p>
							<p class="prd_price2"><fmt:formatNumber value="${food.foodMemberPrice }" pattern="#,###" />원 </p>
						</c:if>
						<c:if test="${ food.eventPercent eq 0}">
							<p class="prd_price"><fmt:formatNumber value="${food.foodMemberPrice }" pattern="#,###" />원 </p>
						</c:if>
							<input type="hidden" id="hiddenPrice" value="${ food.foodMemberPrice-food.foodMemberPrice*(food.eventPercent/100) }" />
						</td>
					</tr>
					<tr>
						<th>배송구분</th>
						<td>샛별배송/택배배송</td>
					</tr>
					<tr>
						<th>지점</th>
						<td>${food.marketName }</td>
					</tr>
					<tr>
						<th>전화번호</th>
						<td>${food.marketTelephone }</td>
					</tr>
					<tr>
						<th>구매수량</th>
						<td>
							<input id="amount" type="number" placeholder="1">
						</td>
					</tr>
				</table>
					<br />
					<div style="float: right;">
						<p id="finalPrice">총 상품금액 : 
						<c:if test="${food.eventPercent ne 0}">
								<fmt:formatNumber value="${ food.foodMemberPrice-food.foodMemberPrice*(food.eventPercent/100) } "
								pattern="#,###" />원 
						</c:if>
						<c:if test="${food.eventPercent eq 0}">
							<fmt:formatNumber value="${food.foodMemberPrice }" pattern="#,###" />원 
						</c:if>
						</p>
					</div>
					<br />
					<div id="buttons">
					<img src="${pageContext.request.contextPath }/resources/images/cart.png" alt="" onclick="cartValidate();"/>
					<button>늘 사는 것</button>
					<button id="noticeStock">재고알림</button>
					</div>
			</div>
			</div>
			<hr>
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
        <input type="hidden" name="" id="foodNoToRe" value="${food.foodNo }" />
        <input type="hidden" name="" id="memberLoggedInView" value="${memberLoggedIn.memberId }" />
        
</article>
	<script>
	$('#amount').change(function() {
		var amount = $("#amount").val();
		var html = "";		
		if(amount <=0){
			$("#amount").val(0);
			html = "총 상품금액 : 0원"; 
		}else{
		var finalPrice = $("#hiddenPrice").val()*amount;
		var ppp =  finalPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		html = "총 상품금액 : "+ppp+"원" 
			
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
		var param = {
				foodNo : foodNo,
				memberId : memberId
		}
			console.log(memberId);
		
		
		var getGoodInView = function(){
			console.log("보내기전에 memberId 확인!", memberId);
			$.ajax({
		    	url: "${pageContext.request.contextPath}/food/goodOrBad.do",
		    	type: "get",
				data: param,
		   		success: (data)=> {
		   			var htmlInLike = '';
		   			var htmlInBad= ' ';
		   			
	   				//좋아요 싫어요를 아예 못할 사람
	   				if(memberCheck != 1){
			   				htmlInLike += '<img src="${pageContext.request.contextPath }/resources/images/food/like.png"  id="goodImg" alt="좋아요" name="GOOD"/> <br /> <p id="goodText">&lpar;'+data.totalGood+'&rpar;</p> ';
			   				htmlInBad += '<img src="${pageContext.request.contextPath }/resources/images/food/dislike.png"  id="badImg" alt="싫어요" name="BAD"/><br /> <p id="badText">&lpar;'+data.totalBad+'&rpar;</p> ';
	   				}
	   				//좋아요 싫어요 가능할
	   				else{
	   					//좋아요 싫어요를 했다면
			   			if(data && ((data.good == 1) || data.bad == 1)){
			   				
			   				//좋아요
			   				if(data.good == 1 ){
			   					htmlInLike += '<img src="${pageContext.request.contextPath }/resources/images/food/liked.png" class="did" id="goodImg" alt="좋아요" name="GOOD"/> <br /> <p id="goodText">&lpar;'+data.totalGood+'&rpar;</p> ';
			   					htmlInBad += '<img src="${pageContext.request.contextPath }/resources/images/food/dislike.png" class="didnt" id="badImg" alt="싫어요" name="BAD"/><br /> <p id="badText">&lpar;'+data.totalBad+'&rpar;</p> ';
			   						
			   				}//싫어요
			   				else if (data.bad == 1){
			   					htmlInLike += '<img src="${pageContext.request.contextPath }/resources/images/food/like.png" class="didnt"  id="goodImg" alt="좋아요" name="GOOD"/> <br /> <p id="goodText">&lpar;'+data.totalGood+'&rpar;</p> ';
			   					htmlInBad += '<img src="${pageContext.request.contextPath }/resources/images/food/disliked.png" class="did"  id="badImg" alt="싫어요" name="BAD"/><br /> <p id="badText">&lpar;'+data.totalBad+'&rpar;</p> ';
			   				
			   				}
			   			}
			   			//한적만 있음.
		   				else if((data.good==0) && (data.good==0)){
		   					htmlInLike += '<img src="${pageContext.request.contextPath }/resources/images/food/like.png"  class="didntX"  id="goodImg" alt="좋아요" name="GOOD"/> <br /> <p id="goodText">&lpar;'+data.totalGood+'&rpar;</p> ';
		   					htmlInBad += '<img src="${pageContext.request.contextPath }/resources/images/food/dislike.png" class="didntX" id="badImg" alt="싫어요" name="BAD"/><br /> <p id="badText">&lpar;'+data.totalBad+'&rpar;</p> ';
		   				}
			   			//좋아요 싫어요 한번도 안함
		   				else if(!data ){
		   					htmlInLike += '<img src="${pageContext.request.contextPath }/resources/images/food/like.png" class="didntXX" id="goodImg" alt="좋아요" name="GOOD"/> <br /> <p id="goodText">&lpar;'+data.totalGood+'&rpar;</p> ';
		   					htmlInBad += '<img src="${pageContext.request.contextPath }/resources/images/food/dislike.png" class="didntXX" id="badImg" alt="싫어요" name="BAD"/><br /> <p id="badText">&lpar;'+data.totalBad+'&rpar;</p> ';
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
		
		
		/* 1. 좋아요 싫어요 출력
			2. 멤버 체크 확인  => 일반회원이면 did, didnt 먹이기
		 */
		 
		 
/* 		if((memberId.trim().length != 0)){
			getGoodInView();
		} */
			getGoodInView();
		
		$(document).on('click', '.did', function(){
			console.log("did이벤트핸들러");
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
			console.log("didnt이벤트핸들러");
			console.log($(this).attr('id'));
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
			console.log("didntToUp이벤트핸들러");
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
			console.log("didntXX이벤트핸들러");
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
			dataType:"json",
	   		success: (data)=> {
	   			var html = ' ';
	   			for(var i in data){
	   				html += '<li>  <a href="${pageContext.request.contextPath}/recipe/recipeView.do?recipeNo='+data[i].recipeNo+'&memberId='+memberId+'" class="dp_block"><div class="event_img_area">';
	   				html += '<img src="${pageContext.request.contextPath }/resources/upload/recipe/'+data[i].renamedRecipePic+'">';
	   				console.log('<img src="${pageContext.request.contextPath }/resources/upload/recipe/'+data[i].renamedRecipePic+'">');
	   				html += '</div><div class="event_info_area">  <p>'+data[i].recipeTitle+'</p>';
	   				html += '</div> </a> </li> ';
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