<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />


<style>

.myPage > div > div{
	display: inline-block;
}

.coupon label{
    margin-right: 50px;
}

.coupon .coupon-card{
	width: calc(50% - 20px);
	border: 1px solid black;
	display: inline-block;
	margin: 10px;
}

.coupon .disabled .date, .coupon .disabled .flag{
	color: red;
}

.coupon .coupon-card .flag{
	padding: 0px;
}

.coupon .coupon-card div{
	padding: 10px;
}

.coupon .coupon-card .discount{
	color: #374818;
	font-size: 22px;
	font-weight: bold;
	padding-top: 15px;
}

.coupon .date{
	font-size: 12px;
}

.coupon .minPrice{
	background-color: #f4f4f0;
}

.myPage-nav{
	float: left;
}

.coupon{
	float: right;
	width: 730px;
}
</style>

<script>
$(()=>{
	getCoupon();
	
	//라디오 버튼 변경시 데이터 변경
	$("[name=coupon]").change(()=>{
		getCoupon();
	});
});

//데이터 불러오기
function getCoupon(){
	
	var enabled = $("[name=coupon]:checked").val();
	
	$.ajax({
		url: "${pageContext.request.contextPath}/member/myCoupon.do",
		data: {enabled: enabled},
		type: "POST",
		success: (data)=>{
			
			$(".couponPage .coupon").children("div").remove();
			
			for(var i=0; i<data.length; i++){
				var startDate = toDate(data[i].COUPON_START_DATE);
				var endDate = toDate(data[i].COUPON_END_DATE);
				 
				var html = '';
				if(data[i].FLAG == 1){
					html += '<div class="coupon-card txt_center">'; 					
				}else{
					html += '<div class="coupon-card txt_center disabled">';
				}
				html += '<div class="discount">'+data[i].COUPON_DISCOUNT+'% 쿠폰</div>';
				if(data[i].FLAG == 1){
					html += '<div class="flag">사용가능</div>';
				}else{					
					if(data[i].COUPON_ENABLED == 1){
						html += '<div class="flag">사용불가</div>';
					}else{
						html += '<div class="flag">사용완료</div>';
					}
				}
	    		html += '<div class="date">사용기간 : '+startDate+' ~ '+endDate+'</div>';
                html += '<div class="minPrice">최소주문금액 : '+comma(data[i].COUPON_MIN_PRICE)+'원</div>';
	    		html += '</div>';
	    		
	    		$(".couponPage .coupon").append(html);
			}
		},
		error: (xhr, txtStatus, err)=> {
			console.log("ajax 처리실패!", xhr, txtStatus, err);
		}
	});
}
</script>

<section>
	<article class="subPage inner myPage">
		<div style="overflow: hidden;" class="couponPage">
		    <jsp:include page="/WEB-INF/views/member/memberNav.jsp" />
		    <div class="coupon">
		    	<h3 class="sub_tit" style="background-color: white;">쿠폰 관리</h3>
		    	<input type="radio" value="" id="couponAll" checked="checked" name="coupon">&nbsp;&nbsp;<label for="couponAll">전체보기</label>
		    	<input type="radio" value="1" id="couponY" name="coupon">&nbsp;&nbsp;<label for="couponY">사용가능쿠폰</label>		    	
		    	<input type="radio" value="0" id="couponN" name="coupon">&nbsp;&nbsp;<label for="couponN">사용불가쿠폰</label>		    	
		    	<br>
	        </div>
        </div>
    </article>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>