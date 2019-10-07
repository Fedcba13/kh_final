<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />


<style>

	table.pay_detail_tbl .btn{
		width: 100px;
	}

	table.pay_detail_tbl{
		border-bottom: 2px solid #374818;
	}

	table.pay_detail_tbl tr td.food_img{
		width: 120px;
	}
	
	table.pay_detail_tbl tr td.food_info{
		width: 400px;
		padding: 0 30px;
	}
	
	table.pay_detail_tbl tr td.food_amount{
		width: 80px;
	}
	
	table.pay_detail_tbl tr td.food_review{
		width: 100px;
	}
	
	table.pay_market_tbl{
		margin-top: 30px;
	}
	
</style>

<script>
$(()=>{
	$(".write_review").on('click', writeReview);
	
});	

function writeReview(e){
	if($(e.target).parents("tr").next().hasClass('review')){
		alert('이미 리뷰 작성중입니다.')
	}else{
		$(e.target).parents("tr").after("<tr class='review'><td colspan='3'><input type='text' placeholder='리뷰 내용을 작성해주세요.' style='width: 80%;'></td><td><input type='button' value='리뷰 쓰기' class='btn review_btn'></td></tr>");
	}
	
	$(e.target).addClass('cancle_review').removeClass('write_review').addClass('btn2').val('취소하기');
	
	$(".cancle_review").off()
	
	$('.cancle_review').click((e)=>{
		cancleReview(e);
	});
	
	$(e.target).parents("tr").next().find('.review_btn').off().click(()=>{
		alert('a');
	});
}

function cancleReview(e){
	
	$(e.target).parents("tr").next().remove();
	
	$(e.target).removeClass('cancle_review').addClass('write_review').removeClass('btn2').val('리뷰 쓰기');
	
	$('.write_review').off();
	
	$('.write_review').click((e)=>{
		writeReview(e);
	})
	
}

</script>

<section>
	<article class="subPage inner myPage">
		<div class="payDetailPage">
		    <jsp:include page="/WEB-INF/views/member/memberNav.jsp" />
		    <div class="payDetail">
		    	<h3 class="sub_tit" style="background-color: white;">구매 상세</h3>
		    	<table class="tbl txt_center pay_detail_tbl" style="width: 700px">
		            <tr>
		                <th>상품 사진</th>
		                <th>상품 정보</th>
		                <th>수량</th>
		                <th>리뷰</th>
		            </tr>
		            <c:forEach items="${list }" var="food">
			            <tr>
			                <td class="food_img"><img src='${food.FOOD_IMG }' width="100px" height="130px"></td>
			                <td class="food_info">${food.FOOD_NAME }</td>
			                <td class="food_amount">${food.PAY_DETAIL_AMOUNT}</td>
			                <td class="food_review">
			                	<c:if test="${food.FLAG == 0}">
				                	<input type="button" class="btn write_review" value="리뷰 쓰기">
			                	</c:if>
			                	<c:if test="${food.FLAG != 0}">
			                		<input type="button" class="btn btn2" value="리뷰 완료" >
			                	</c:if>
			                </td>
			            </tr>
		            </c:forEach>
		        </table>
		        
		        <table class="tbl tbl_view pay_market_tbl">
		            <tr>
		                <th>총 결제 금액</th>
		                <td>${list[0].PAY_PRICE }원</td>
		            </tr>
		            <tr>
		                <th>결제일</th>
		                <td><fmt:formatDate value="${list[0].PAY_DATE}" pattern="yyyy-MM-dd"/></td>
		            </tr>
		            <tr>
		                <th>결제매장</th>
		                <td>${list[0].MARKET_NAME }</td>
		            </tr>
		        </table>
	        </div>
        </div>
    </article>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>