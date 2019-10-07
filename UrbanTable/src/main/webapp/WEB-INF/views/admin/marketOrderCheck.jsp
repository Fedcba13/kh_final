<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/css/marketOwner.css">

<script>
 
 $(()=>{

	var html = '';
	 $.ajax({
			url:"${pageContext.request.contextPath}/check/marketOrderCheckList1.do",
			success: (data)=>{
 				console.log(data);
 				var cnt = 0;
 				var cntArr = [];
 				for(var i in data){
 					
					html += '<tr class="'+data[i].MARKET_ORDER_NO+'">';
					html += '<td class="market_name">'+data[i].MARKETNAME+'</td>';
					html += '<td class="txt_left">'+data[i].FOODNAME+'</td>';
					html += '<td >'+data[i].MARKET_ORDER_DETAIL_AMOUNT+'</td>';
					html += '<td class="market_name">'+data[i].ORDER_DATE+'</td>';
					html += '<input type="hidden" name="marketNo" value="'+data[i].MARKET_NO+'" id="marketNo'+i+'"/>';
					html += '<input type="hidden" name="orderNo" value="'+data[i].MARKET_ORDER_NO+'" id="orderNo'+i+'"/>';
					html += '<td class="market_name"><input type="button" value="O" class="btn" onclick="order('+i+')" style="width:50px;"/></td>';
					html += '</tr>'; 
					if(cntArr.indexOf(data[i].MARKET_ORDER_NO)==-1){
						cntArr.push(data[i].MARKET_ORDER_NO);
					}
 				}
 				$('.orderTbl tbody').append(html);
 				
				console.log(cntArr);
				for(var j=0; j<cntArr.length; j++){	
					var as = $(".orderTbl tr."+cntArr[j]).length;
					console.log(j+";"+as);
					$(".orderTbl tbody tr."+cntArr[j]).eq(0).children("td").eq(0).attr("rowspan", as);
					$(".orderTbl tbody tr."+cntArr[j]+":not(:eq(0))").children("td.market_name").css("display","none");
					
 					$(".orderTbl tbody tr."+cntArr[j]).eq(0).children("td").eq(3).attr("rowspan", as);
					$(".orderTbl tbody tr."+cntArr[j]+":not(:eq(0))").children("td").eq(3).css("display","none");
					$(".orderTbl tbody tr."+cntArr[j]).eq(0).children("td").eq(4).attr("rowspan", as);
					$(".orderTbl tbody tr."+cntArr[j]+":not(:eq(0))").children("td").eq(4).css("display","none"); 
				}
			},
			error: (xhr, txtStatus, err)=>{
				console.log("ajax처리실패!", xhr, txtStatus, err);
			}
		});
	 
	 
 })
 
function order(idx){
	
	var marketNo = $('#marketNo'+idx).val();
	var orderNo = $('#orderNo'+idx).val();

	location.href = "${pageContext.request.contextPath}/check/updateOrder.do?marketNo="
		+ marketNo
		+ "&orderNo="
		+ orderNo;
return true;
	
	}

</script>
<section>
	<article class="subPage inner asda">

		<div class="list_wrap">
			<table class="tbl txt_center"></table>
			<div class="pageBar"></div>
		</div>
		<div id="orderList">

			<h3 class="sub_tit">발주 요청 예정 품목</h3>
			<table class="tbl txt_center orderTbl">
				<thead>
					<tr class="sec_bg">
						<th>발주매장</th>
						<th style="width: 450px;">품목</th>
						<th>수량</th>
						<th>발주일시</th>
						<th style="width: 70px;"></th>
					</tr>
				</thead>
				<tbody></tbody>
			</table>
			<div class="pageBar"></div>
			<div id="orderTotal"></div>
		</div>
		</div>
		<div class="popupWrap"></div>
	</article>

</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>