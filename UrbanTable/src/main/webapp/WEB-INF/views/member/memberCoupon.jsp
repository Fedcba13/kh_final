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


.coupon .coupon-card{
	width: 350px;
	border: 1px solid black;
	display: inline-block;
	margin: 10px;
}

.coupon .coupon-card div{
	padding: 10px;
}

.coupon .discount{
	color: #374818;
	font-size: 22px;
	font-weight: bold;
}

.coupon .minPrice{
	background-color: #f4f4f0;
}

.myPage-nav{
	float: left;
}

.coupon{
	float: right;
	width: 760px;
}
</style>

<script>
$(()=>{
	getCoupon();
});

//데이터 불러오기
function getCoupon(){
	
	var enabled = "";
	
	$.ajax({
		url: "${pageContext.request.contextPath}/member/myCoupon.do",
		data: {enabled: enabled},
		type: "POST",
		success: (data)=>{
			
			$(".couponPage .coupon").children("div").remove();
			
			for(var i=0; i<data.length; i++){
				var startDate = toDate(data[i].couponStartDate);
				var endDate = toDate(data[i].couponStartDate);
				 
				var html = '';
				html += '<div class="coupon-card txt_center">'; 
				html += '<div class="discount">'+data[i].couponDiscount+'% 쿠폰</div>';	
	    		html += '<div class="date">사용기간 : '+startDate+' ~ '+endDate+'</div>';
	    		html += '<div class="minPrice">최소주문금액 : '+data[i].couponMinPrice+'</div>';
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
		    	
	        </div>
        </div>
    </article>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>