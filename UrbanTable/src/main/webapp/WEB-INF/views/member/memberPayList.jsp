<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />


<style>

	.pay_card{
		cursor: pointer;
		border-width: 1px 1px 0;
		border-style: solid;
		border-color: #e9e9e9;
	}	
	
	.pay_card:last-child{
		border: 1px solid #e9e9e9;
	}
	
	.pay_card:hover{
		background: #f4f4f0;
	}

	.pay_card > div{
		display: inline-block;
		overflow: hidden;
		padding: 10px;
	}

	.payList .pay_info{
		float: left;
		width: 150px;
	}
	
	.pay_card > div > div:nth-child(2n-1){
		margin-bottom: 20px;
	}
	
	.payList .pay_content{
		width: 480px;
	}
	
	.payList .pay_content > div{
		vertical-align: top;
		display: inline-block;
		width: 340px;
		padding-left: 10px;
	}
	
	.payList .pay_state{
		float: right;
		width: 120px;
	}

</style>

<script>
$(()=>{
	getMemberPayList();
});	

function getMemberPayList(){
	
	var payFlag = '';
	var payEnabled = '';
	
	var param = {
			payFlag : payFlag,
			payEnabled : payEnabled
	}
	
	$.ajax({
		url: '${pageContext.request.contextPath}/member/payList.do',
		data: param,
		type: "POST",
		success: (data)=>{
			$(".payList .pay_card").remove();
			
			for(var i = 0; i<data.length; i++){
				
				var date = toDate(data[i].PAY_DATE);
				var flag = '';
				if(data[i].FLAG == 1){
					flag = '배송 준비중';
				}else{
					flag = '배송 완료';
				}
			
				var html = '';
				
				html += '<div class="pay_card" id="'+data[i].PAY_NO+'">';
				html += '<div class="pay_info"><div class="pay_date">'+date+'</div><div class="pay_price">'+data[i].PAY_PRICE+'원</div></div>';
				html += '<div class="pay_content">';
				html += '<img src="'+data[i].FOOD_IMG+'" width="100px" height="140px">';
				html += '<div>'+data[i].TXT+'</div>';
				html += '</div>';
				html += '<div class="pay_state"><div>'+data[i].MARKET_NAME+'</div><div>'+flag+'</div></div>';
				html += '</div>';
			
				$(".payList").append(html);
				
			}
			
			$(".payList .pay_card").click((e)=>{
				var pay_no = '';
				if($(e.target).hasClass('pay_card')){
					pay_no = $(e.target).prop('id');
				}else{
					pay_no = $(e.target).parents('.pay_card').prop('id');
				}
				location.href = '${pageContext.request.contextPath}/member/payDetail?payNo='+pay_no;
			});
			
		},
		error: (xhr, txtStatus, err)=> {
			console.log("ajax 처리실패!", xhr, txtStatus, err);
		}
	});
}
</script>

<section>
	<article class="subPage inner myPage">
		<div class="payListPage">
		    <jsp:include page="/WEB-INF/views/member/memberNav.jsp" />
		    <div class="payList">
		    	<h3 class="sub_tit" style="background-color: white;">구매 내역</h3>
		    	
	        </div>
        </div>
    </article>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>