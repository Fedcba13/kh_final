<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/food.css">
	<article class="subPage inner">
	    <h3 class="sub_tit">서브페이지 제목</h3>
		 <div id="foodExpression"> 
			<div id="foodExpressionImg">
			<img src="${food.foodImg }" alt="상품사진" />
			</div>
			<div id="foodExpressionTb">
				<p> ${food.foodName }</p>
				<table class="tbl txt_center">
					<!--가운데 정렬 아니면 txt_center 빼셔도 됩니다.
	                                    width 값은 th에 width="150" 이런식으로 써주시면 됩니다.-->
					<tr>
						<th>판매가</th>
						<%--                 <td><fmt:formatNumber value="${food.afterEventPrice}" pattern="\#,###.##"/>원</td> --%>
						<td id="foodPrice"><fmt:formatNumber value="${food.afterEventPrice}"
								pattern="#,###.##" />원 <input type="hidden" id="hiddenPrice" value="${food.afterEventPrice}" /></td>
								
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
						<p id="finalPrice">총 상품금액 : <fmt:formatNumber value="${food.afterEventPrice}"
								pattern="#,###.##" />원</p>
					</div>
					<br />
					<div id="buttons">
					<button>장바구니 담기</button>
					<button>늘 사는 것</button>
					<button>상품 문의</button>
					</div>
			</div>
			</div>
    </article>
	<script>
	$('#amount').change(function() {
		var amount = $("#amount").val();
		var html = "";		
		if(amount <=0){
			$("#amount").val(0);
			html = "총 상품금액 : 0원"; 
		}else{
		console.log(amount);
		var finalPrice = $("#hiddenPrice").val()*amount;
		console.log(finalPrice);
		var ppp =  finalPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		 html = "총 상품금액 : "+ppp+"원" 
			
		}
		 $("#finalPrice").html(html);  
	}); 
	</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>