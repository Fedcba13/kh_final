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
		width: 350px;
		padding: 0 30px;
	}
	
	table.pay_detail_tbl tr td.food_amount{
		width: 80px;
	}
	
	table.pay_detail_tbl tr td.food_review{
		width: 150px;
	}
	
	table.pay_market_tbl{
		margin-top: 30px;
	}
	
	table.pay_detail_tbl .modify_btn, table.pay_detail_tbl .delete_btn, table.pay_detail_tbl .confirm_btn{
		width: 50px;	
	}
	
	table.pay_detail_tbl .review > td:nth-child(1){
		 text-align: left;
		 padding-left: 10px;
	}
	
	table.pay_detail_tbl input[type=button][value='리뷰 완료']{
		cursor: default;
	}
	
	table.pay_detail_tbl .review_content{
		width: 460px;
	}
	
</style>

<script>
$(()=>{
	$(".write_review").on('click', writeReview);
	$(".modify_btn").on('click', modifyReview);
	$(".delete_btn").on('click', deleteReview);
});	

function writeReview(e){
	if($(e.target).parents("tr").next().hasClass('review')){
		alert('이미 리뷰 작성중입니다.')
	}else{
		$(e.target).parents("tr").after("<tr class='review sec_bg'><td colspan='3'><input type='text' placeholder='리뷰 내용을 작성해주세요.' class='review_content'></td><td><input type='button' value='리뷰 쓰기' class='btn review_btn'></td></tr>");
	}
	
	$(e.target).addClass('cancle_review').removeClass('write_review').addClass('btn2').val('취소하기');
	
	$(".cancle_review").off()
	
	$('.cancle_review').click((e)=>{
		cancleReview(e);
	});
	
	$(e.target).parents("tr").next().find('.review_btn').off().click((e)=>{
		var $txt = $(e.target).parents(".review").find('input[type=text]');
		
		if($txt.val().length == 0){
			alert('리뷰를 써주세요.');
			$txt.focus();
			return;
		}
		
		var detail_no = $(e.target).parents("tr").prev().find('.order_detail_no').val();
		
		var param = {
				detailNo : detail_no,
				content : $txt.val()
		}
		
		$.ajax({
			url: contextPath + "/member/writeReview",
			data: param,
			type: "POST",
			success: function(data){
				console.log(data);
				alert(data.msg);
				
				var $tr = $(e.target).parents("tr").prev();
				$tr.next().remove();
				$tr.after('<tr class="review sec_bg"><td colspan="3">'+param.content+'</td><td><input type="button" value="수정" class="btn modify_btn"> <input type="button" value="삭제" class="btn btn2 delete_btn"></td></tr>');
				$tr.find('.cancle_review').removeClass('cancle_review').off().val('리뷰 완료');

				$tr.next().find('.modify_btn').click((e)=>{
					modifyReview(e);
				});
				
				$tr.next().find('.delete_btn').click((e)=>{
					deleteReview(e);
				});
				
			},
			error: function(xhr, txtStatus, err){
				console.log("ajax 처리 실패", xhr, txtStatus, err);
			}
		});
		
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

function modifyReview(e){
	var txt = $(e.target).parents("tr").children().eq(0).text();
	$(e.target).parents("tr").children().eq(0).html('<input type="text" value="'+txt+'" class="review_content">');
	
	$(e.target).parents("tr").find('.modify_btn').addClass('confirm_btn').removeClass('modify_btn').val('확인').off().click((e)=>{
		confirmReview(e);
	});
	
	$(e.target).parents("tr").find('.delete_btn').addClass('cancle_btn').removeClass('.delete_btn').val('취소').off().click((e)=>{
		cancleModify(e);
	});
	
}

function deleteReview(e){
	var detail_no = $(e.target).parents("tr").prev().find('.order_detail_no').val();
	$.ajax({
		url: contextPath + "/member/deleteReview",
		data: {detailNo : detail_no},
		type: "POST",
		success: function(data){
			console.log(data);
			alert(data.msg);
			
			var $tr = $(e.target).parents("tr").prev();
			$tr.next().remove();
			
			$tr.find("input[type=button][value='리뷰 완료']").addClass('write_review').removeClass('btn2').val('리뷰 쓰기');
			
			$tr.find(".write_review").off().click((e)=>{
				writeReview(e);
			});
			
		},
		error: function(xhr, txtStatus, err){
			console.log("ajax 처리 실패", xhr, txtStatus, err);
		}
	});
}

function confirmReview(e){
	
	var detail_no = $(e.target).parents("tr").prev().find('.order_detail_no').val();
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
			alert(data.msg);
			
			var $tr = $(e.target).parents("tr").prev();
			$tr.next().remove();
			$tr.after('<tr class="review sec_bg"><td colspan="3">'+param.content+'</td><td><input type="button" value="수정" class="btn modify_btn"> <input type="button" value="삭제" class="btn btn2 delete_btn"></td></tr>');
			
			$tr.next().find('.modify_btn').click((e)=>{
				modifyReview(e);
			});
			
			$tr.next().find('.delete_btn').click((e)=>{
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
	
	$(e.target).parents("tr").children().eq(0).html(txt);
	
	$(e.target).parents("tr").find('.confirm_btn').removeClass('confirm_btn').addClass('modify_btn').val('수정').off().click((e)=>{
		modifyReview(e);
	});
	
	$(e.target).parents("tr").find('.cancle_btn').removeClass('cancle_btn').addClass('.delete_btn').val('삭제').off().click((e)=>{
		deleteReview(e);
	});
	
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
			                <td class="food_img"><img src='${food.FOOD_IMG }' width="100px" height="130px"><input type="hidden" class="order_detail_no" value="${food.PAY_DETAIL_NO }"></td>
			                <td class="food_info">${food.FOOD_NAME }</td>
			                <td class="food_amount">${food.PAY_DETAIL_AMOUNT}</td>
			                <td class="food_review">
			                	<c:if test='${empty food.REVIEW or food.REVIEW == ""}'>
				                	<input type="button" class="btn write_review" value="리뷰 쓰기">
			                	</c:if>
			                	<c:if test='${not empty food.REVIEW and food.REVIEW != ""}'>
			                		<input type="button" class="btn btn2" value="리뷰 완료" >
			                	</c:if>
			                </td>
			            </tr>
			            <c:if test='${not empty food.REVIEW and food.REVIEW != ""}'>
			            <tr class='review sec_bg'>
			            	<td colspan="3">${food.REVIEW }</td>
			            	<td>
				            	<input type="button" value="수정" class="btn modify_btn">
				            	<input type="button" value="삭제" class="btn btn2 delete_btn">
				            </td>
			            </tr>
			            </c:if>
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