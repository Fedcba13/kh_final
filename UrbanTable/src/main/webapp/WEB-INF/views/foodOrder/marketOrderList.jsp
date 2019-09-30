<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/marketOwner.css">
<script>
var marketNo = "${marketNo}";
var cPage = "${cPage}";
$(()=>{
	var param = {
		marketNo: marketNo,
		cPage : cPage
	}
	$.ajax({
		url: "${pageContext.request.contextPath}/foodOrder/marketOrderList.do",
		data: param,
		dataType: "json",
		type: "get",
		success: function(data){
			console.log(data);
			printData(data);
		},
		error: function(xhr, txtStatus, err){
			console.log("ajax 처리 실패", xhr, txtStatus, err);
		}
	});
	
	$(document).on('click', ".pageBar a", function(e){
		e.preventDefault();
		var param = {
			marketNo: marketNo,
			cPage: $(e.target).attr("rel")
		}
		
		console.log(param);
			
		$.ajax({
			url: "${pageContext.request.contextPath}/foodOrder/marketOrderList.do",
			type: "get",
			data: param,
			dataType:"json",
			success: function(data){
				printData(data);
			},
			error: function(xhr, txtStatus, err){
				console.log("ajax 처리 실패", xhr, txtStatus, err);
			}
		});
	});
});

function printData(data){
	var html = "<thead><tr class='sec_bg'>";
	html += "<th>발주 번호</th>";
	html += "<th>발주 날짜</th>";
	html += "<th>총액</th>";
	html += "<th>진행 사항</th>";
	html += "</tr></thead>";
	
	var mo = data.marketOrderList;
	html += "<tbody>";
	if(mo.length>0){
		for(var i in mo){
			var flag = "";
			if(mo[i].MARKET_ORDER_FLAG == 0){
				flag = "발주 요청";
			} else {
				flag = "입고 완료";
			}
			html += "<tr>";
			html += "<td><a href='${pageContext.request.contextPath}/foodOrder/marketOrderView.do?marketOrderNo="+mo[i].MARKET_ORDER_NO+"' class='dp_block'>"+mo[i].MARKET_ORDER_NO+"</a></td>";
			html += "<td>"+mo[i].ORDER_DATE+"</td>";
			html += "<td>"+comma(mo[i].MARKET_ORDER_PRICE)+"원</td>";
			html += "<td>"+flag+"</td>";
			html += "</tr>";
		}
	} else {
		html += "<tr><td colspan='4'>조회된 결과가 없습니다.</td></tr>";
	}
	html += "</tbody>";
	
	$(".tbl").html(html);
	$(".pageBar").html(data.pageBar);
}

function comma(str) {
    str = String(str);
    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
}
</script>
<section id="foodOrderRequest">
	<article class="subPage inner">
	    <h3 class="sub_tit">발주 요청 내역</h3>
	    <table class="tbl txt_center"></table>
	    <div class="pageBar"></div>
    </article>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>