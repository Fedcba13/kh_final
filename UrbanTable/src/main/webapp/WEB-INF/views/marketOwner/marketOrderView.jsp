<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/marketOwner.css">
<script>
var payNo = "${payNo}";
$(()=>{
	$(".list_wrap > div").hide();
	$(".list_wrap > div:first").show();
	$(".marketStockTab li").click(function(){
		var ac_tab = $(this).attr("rel");
		$(".marketStockTab li").removeClass("ac_tab");
		$(this).addClass("ac_tab");
		$(".list_wrap > div").hide();
		$(".list_wrap > div#"+ac_tab).fadeIn("fast");
	});
});

function goDelivery(){
	$.ajax({
		url: "${pageContext.request.contextPath}/market/marketOrderDelivery.do",
		type: "post",
		data: {payNo:payNo},
		dataType:"json",
		success: function(data){
			console.log(data);
			var popup = "<div class='marketOrderPopup'>";
			popup += "<p>"+data.msg+"</p>";
			popup += "<div class='marketOrderBtn txt_center'>";
			popup += "<input type='button' value='확인' class='dp_ib btn' onclick='okBtn();' />";
			popup += "</div></div>";
			$(".popupWrap").html(popup).show();
		},
		error: function(xhr, txtStatus, err){
			console.log("ajax 처리 실패", xhr, txtStatus, err);
		}
	});
}

function okBtn(){
	$(".popupWrap").hide();
	$(".popupWrap .marketOrderPopup").remove();
	location.reload();
}
</script>
<section id="marketOrderView">
	<article class="subPage inner">
		<h3 class="sub_tit">주문내역</h3>
		<ul class="marketStockTab txt_center">
	    	<li rel="orderPrd" class="ac_tab">주문 상품</li>
	    	<li rel="orderPay">주문 결제 정보</li>
	    	<li rel="orderMember">주문자/배송 정보</li>
	    </ul>
	    <div class="list_wrap">
	    	<div id="orderPrd">
	    		<table class="tbl txt_center">
		            <tr class="sec_bg">
		                <th width="554">상품명</th>
		                <th width="60">수량</th>
		                <th width="100">가격</th>
		                <th width="150">판매사</th>
		                <th width="80">상태</th>
		            </tr>
		            <c:forEach items="${orderDetailFood }" var="d">
		            	<tr>
			                <td class="txt_left">
			                	<img src="${d.FOOD_IMG }" alt="상품이미지" width="80" class="dp_ib" />
			                	<span class="dp_ib">${d.FOOD_NAME }</span>
			                </td>
			                <td>${d.PAY_DETAIL_AMOUNT }</td>
			                <td><fmt:formatNumber value="${d.PAY_DETAIL_AMOUNT*d.FOOD_MEMBER_PRICE }" pattern="#,###" />원</td>
			                <td>${d.FOOD_COMPANY }</td>
			                <td>
			                	<c:if test="${d.PAY_FLAG eq 0 }">주문</c:if>
			                	<c:if test="${d.PAY_FLAG eq 1 }">결제 완료</c:if>
			                	<c:if test="${d.PAY_FLAG eq 2 }">배송 완료</c:if>
			                </td>
			            </tr>
		            </c:forEach>
		        </table>
	    	</div>
	    	<div id="orderPay">
	    		<table class="tbl txt_center">
		            <tr class="sec_bg">
		                <th>주문 번호</th>
		                <th>주문일</th>
		                <th>결제 방법</th>
		                <th>결제 총액</th>
		            </tr>
		            <c:if test="${not empty orderDetailPay}">
		            	<tr>
			                <td>${orderDetailPay.PAY_NO }</td>
			                <td>${fn:substring(orderDetailPay.PAY_DATE, 0, 10) }</td>
			                <td>
			                	<c:if test="${orderDetailPay.PAYMENT_WAY eq 'card' }">신용 카드</c:if>
			                	<c:if test="${not orderDetailPay.PAYMENT_WAY eq 'card' }">${orderDetailPay.PAYMENT_WAY}</c:if>
			                </td>
			                <td><fmt:formatNumber value="${orderDetailPay.PAY_PRICE }" pattern="#,###" />원<br>(배송비 2500원)</td>
			            </tr>
		            </c:if>
		        </table>
	    	</div>
	    	<div id="orderMember">
	    		<table class="tbl tbl_view">
	    		<c:if test="${not empty orderDetailMember }">
	    			<tr>
		                <th>주문자 ID</th>
		                <td>${orderDetailMember.MEMBER_ID }</td>
		            </tr>
		            <tr>
		                <th>주문자</th>
		                <td>${orderDetailMember.MEMBER_NAME }</td>
		            </tr>
		            <tr>
		                <th>연락처</th>
		                <td>${orderDetailMember.MEMBER_PHONE }</td>
		            </tr>
		            <tr>
		                <th>주소</th>
		                <td>
		                	${orderDetailMember.MEMBER_ADDRESS }
		                	 ${orderDetailMember.MEMBER_ADDRESS2 }
		                </td>
		            </tr>
		            <tr>
		                <th>배송 유형</th>
		                <td>
		                	<c:if test="${orderDetailMember.DELIVER_TYPE eq 'n' }">일반 배송</c:if>
		                	<c:if test="${orderDetailMember.DELIVER_TYPE eq 'd' }">샛별 배송</c:if>
		                	<c:if test="${orderDetailMember.DELIVER_TYPE eq 'r' }">정기 배송</c:if>
		                </td>
		            </tr>
		            <tr>
		                <th>상태</th>
		                <td>
		                	<c:if test="${orderDetailMember.PAY_FLAG eq 0 }">주문</c:if>
		                	<c:if test="${orderDetailMember.PAY_FLAG eq 1 }">결제 완료</c:if>
		                	<c:if test="${orderDetailMember.PAY_FLAG eq 2 }">배송 완료</c:if>
		                </td>
		            </tr>
		        </c:if>
		        </table>
	    	</div>
	    </div>
	    <div class="orderReqWrap txt_center clearfix">
	    	<c:if test="${not empty orderDetailPay }">
				<p class="orderTotal">
					주문일
					<span class="dp_ib red fw600" style="padding:0 20px 0 10px;">
						${fn:substring(orderDetailPay.PAY_DATE, 0, 10) }
					</span>
					총 
					<span class="dp_ib red fw600" style="padding:0 5px 0 10px;">
						<fmt:formatNumber value="${orderDetailPay.PAY_PRICE }" pattern="#,###" />
					</span>원
				</p>
			</c:if>
			<c:if test="${not empty orderDetailMember}">
				<c:if test="${orderDetailMember.PAY_FLAG eq 1 }">
					<input type="button" value="배송하기" class="btn" onclick="goDelivery();" />
				</c:if>
			</c:if>
		</div>
		<div class="popupWrap"></div>
    </article>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>