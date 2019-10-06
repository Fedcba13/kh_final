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
	font-size: 2em;
}
</style>
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
						src="${pageContext.request.contextPath }/resources/images/food/like.png" id="goodImg" alt='좋아요' name="GOOD"/>
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
						<%--                 <td><fmt:formatNumber value="${food.afterEventPrice}" pattern="\#,###.##"/>원</td> --%>
						<td id="foodPrice">
						<fmt:formatNumber value="${food.afterEventPrice eq 0? food.foodMemberPrice :food.afterEventPrice }"
								pattern="#,###.##" />원 
						<input type="hidden" id="hiddenPrice" value="${food.afterEventPrice eq 0? food.foodMemberPrice :food.afterEventPrice }" /></td>
								
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
						<p id="finalPrice">총 상품금액 : <fmt:formatNumber value="${food.afterEventPrice eq 0? food.foodMemberPrice :food.afterEventPrice }"
								pattern="#,###.##" />원</p>
					</div>
					<br />
					<div id="buttons">
					<button>장바구니 담기</button>
					<button>늘 사는 것</button>
					<button>상품 문의</button>
					<button>재고알림</button>
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
	
	
	
	
/* 	var foodNo = $("#foodNoToRe").val();
	var memberId = $("#memberLoggedInView").val();
	var param = {
			foodNo : foodNo,
			memberId : memberId
	}
	
	
	$(".did").on('click', function(event){
			console.log("did이벤트핸들러");
			$.ajax({
		    	url: "${pageContext.request.contextPath}/food/cancelGood.do",
		    	type: "get",
				data: param,
		   		success: (data)=> {
		   			goodValidate();
		   			$("#badText").html('('+data.bad+')');
		   			$("#goodText").html('('+data.good+')');
		   		},
		   		error: (xhr, txtStatus, err)=> {
		   			console.log("ajax 처리실패!", xhr, txtStatus, err);
		   		}
		   	}); 
			
		});
		$(".didnt").on('click', function(event){
			console.log("didnt이벤트핸들러");
			console.log($(this).attr('id'));
			 $.ajax({
		    	url: "${pageContext.request.contextPath}/food/changeGood.do",
		    	type: "get",
				data: param,
		   		success: (data)=> {
		   			goodValidate();
		   			$("#badText").html('('+data.bad+')');
		   			$("#goodText").html('('+data.good+')');
		   	
		   		},
		   		error: (xhr, txtStatus, err)=> {
		   			console.log("ajax 처리실패!", xhr, txtStatus, err);
		   		}
		   	});  
		
		});
		
		$(".didntToUp").on('click', function(event){
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
		   			goodValidate();
		   			$("#badText").html('('+data.bad+')');
		   			$("#goodText").html('('+data.good+')');
		   		},
		   		error: (xhr, txtStatus, err)=> {
		   			console.log("ajax 처리실패!", xhr, txtStatus, err);
		   		}
		   	}); 
		});
		
	//좋아요/ 싫어요 했는지 검사 함수
	var goodValidate = function(){
			$.ajax({
		    	url: "${pageContext.request.contextPath}/food/goodOrBad.do",
		    	type: "get",
				data: param,
		   		success: (data)=> {
		   			//좋아요 싫어요를 했다면
		   			if(data && ((data.good == 1) || data.bad == 1)){
		   					
		   				//좋아요
		   				if(data.good == 1 ){
		   					$("#goodImg").removeClass();
		   					$("#badImg").removeClass();
		   					
		   					$("#goodImg").addClass("did");
		   					$("#badImg").addClass("didnt");	
		   				}//싫어요
		   				else if (data.bad == 1){
		   					 $("#goodImg").removeClass();
		   					$("#badImg").removeClass(); 
		   					
 		   					$("#badImg").addClass("did");
		   					$("#goodImg").addClass("didnt");
		   				
		   				}
		   			}
		   			//한적만 있음.
	   				else if((data.good==0) && (data.good==0)){
	   					$("#goodImg").removeClass();
	   					$("#badImg").removeClass();
	   					 
	   					$("#goodImg").addClass("didntToUp");
	   					$("#badImg").addClass("didntToUp");
	   				}
		   			//좋아요 싫어요 한번도 안함
	   				else if(!data ){
	   					 $("#goodImg").removeClass();
	   					$("#badImg").removeClass();
	   					 
	   					$("#goodImg").addClass("didntX");
	   					$("#badImg").addClass("didntX");
	   				}

		   		},
		   		error: (xhr, txtStatus, err)=> {
		   			console.log("ajax 처리실패!", xhr, txtStatus, err);
		   		}
		   	}); 
		}
	 */

	
	$(()=>{

		
		var foodNo = $("#foodNoToRe").val();
		var memberId = $("#memberLoggedInView").val();
		var param = {
				foodNo : foodNo,
				memberId : memberId
		}//로그인한 사용자라면
		if(memberId.trim().length != 0 ){
			goodValidate();
		}
		
		
		
		// 관련 레시피 출력
	 	$.ajax({
	    	url: "${pageContext.request.contextPath}/food/selectRelatedRecipe.do",
	    	type: "get",
			data: param,
			dataType:"json",
	   		success: (data)=> {
	   			var html = ' ';
	   			for(var i in data){
	   				console.log(data[i].recipeNo);
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