<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/marketOwner.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script src="${pageContext.request.contextPath }/resources/js/jquery.fileDownload.js"></script>
<script>
var marketNo = '${marketNo}';
var cPage = '${cPage}';
var orderSearchType = '${orderSearchType}';
var orderSearchKeyword = '${orderSearchKeyword}';
var payFlag = '${payFlag}';
var deliverType = '${deliverType}';
var payStartDate = '${payStartDate}';
var payEndDate = '${payEndDate}';
$(()=>{
	var param = {
		marketNo: marketNo,
		cPage: cPage,
		orderSearchType: orderSearchType,
		orderSearchKeyword: orderSearchKeyword,
		payFlag: payFlag,
		deliverType: deliverType,
		payStartDate: payStartDate,
		payEndDate: payEndDate
	}
	
	console.log(param);
	
	$.ajax({
		url: "${pageContext.request.contextPath}/market/marketOrderList.do",
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
	
	$(document).on('click', "#marketOrder .pageBar a", function(e){
		e.preventDefault();
		var param = {
			marketNo: marketNo,
			cPage: $(e.target).attr("rel"),
			orderSearchType: $("#orderSearchType option:selected").val(),
			orderSearchKeyword: $("input[name=orderSearchKeyword]").val(),
			payFlag: $("input[name=payFlag]:checked").val(),
			deliverType: $("input[name=deliverType]:checked").val(),
			payStartDate: $("#orderDate1").val(),
			payEndDate: $("#orderDate2").val()
		}
		
		console.log(param);
			
		$.ajax({
			url: "${pageContext.request.contextPath}/market/marketOrderList.do",
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
	
	$("#orderDate2").change(()=>{
		var start = $("#orderDate1").val();
		var end = $("#orderDate2");
		
		if(start > end.val()){
			alert("검색일자가 유효하지 않습니다.");
			end.val(start);
		}
	});
	
	$(".eventDate").flatpickr({
	  enableTime: false,
	  dateFormat: "Y-m-d",
	});
	
	$("#downloadExcel").on('click', function(){
		var param = {
			marketNo: marketNo,
			cPage: $(".pageBar span.cPage").text(),
			orderSearchType: $("#orderSearchType option:selected").val(),
			orderSearchKeyword: $("input[name=orderSearchKeyword]").val(),
			payFlag: $("input[name=payFlag]:checked").val(),
			deliverType: $("input[name=deliverType]:checked").val(),
			payStartDate: $("#orderDate1").val(),
			payEndDate: $("#orderDate2").val()
		}
		
		$.fileDownload("${pageContext.request.contextPath}/market/excelDown.do",{
			httpMethod: "GET",
			data: param,
			successCallback: function (url) {
				alert("다운로드 성공!");
		  	},
		  	failCallback: function(responesHtml, url) {
		    	alert('관리자에게 문의 주세요.');
		  	}
		});
	});
	
});

function printData(data){
	var mo = data.marketOrderList;
	var html ="<tr class='sec_bg'>";
	html += "<th colspan='2'>주문 번호</th>";
	html += "<th rowspan='2'>주문자 ID</th>";
	html += "<th rowspan='2'>주문자명</th>";
	html += "<th rowspan='2'>연락처</th>";
	html += "<th rowspan='2'>주문 합계<br />(배송비 포함)</th>";
	html += "<th rowspan='2'>주문 일자</th>";
	html += "<th rowspan='2'>배송 종류</th>";
	html += "<th rowspan='2'>상세 내역</th>";
	html += "</tr>";
	html += "<tr class='sec_bg'>";
	html += "<th>주문 상태</th>";
	html += "<th>결제 수단</th>";
	html += "</tr>";
	
	if(mo.length>0) {
		for(var i in mo){
			var flag = "";
			if(mo[i].PAY_FLAG==0){
				flag = "주문";
			} else if(mo[i].PAY_FLAG==1){
				flag = "결제 완료";
			} if(mo[i].PAY_FLAG==2){
				flag = "배송 완료";
			}
			
			var deliverType = "";
			if(mo[i].DELIVER_TYPE=='d'){
				deliverType = "샛별 배송";
			} else if(mo[i].DELIVER_TYPE=='n'){
				deliverType = "일반 배송";
			} else if(mo[i].DELIVER_TYPE=='r'){
				deliverType = "정기 배송";
			}
			
			var paymentway = "";
			if(mo[i].PAYMENT_WAY=='card'){
				paymentway = "신용카드";
			} else if(mo[i].PAYMENT_WAY==null){
				paymentway = "확인 불가";
			} else {
				paymentway = mo[i].PAYMENT_WAY;
			}
			html += "<tr>";
			html += "<td colspan='2'>"+mo[i].PAY_NO+"</td>";
			html += "<td rowspan='2'>"+mo[i].MEMBER_ID+"</td>";
			html += "<td rowspan='2'>"+mo[i].MEMBER_NAME+"</td>";
			html += "<td rowspan='2'>"+mo[i].MEMBER_PHONE+"</td>";
			html += "<td rowspan='2'>"+comma(mo[i].PAY_PRICE)+"원</td>";
			html += "<td rowspan='2'>"+mo[i].PAY_DATE+"</td>";
			html += "<td rowspan='2'>"+deliverType+"</td>";
			html += "<td rowspan='2'><a href='${pageContext.request.contextPath}/market/marketOrderView.do?payNo="+mo[i].PAY_NO+"' class='dp_block txt_center btn'>보기</a></td>";
			html += "</tr>";
			html += "<tr>";
			html += "<td>"+flag+"</td>";
			html += "<td>"+paymentway+"</td>";
			html += "</tr>";
		}
	} else {
		html += "<tr><td colspan='9'>조회된 데이터가 없습니다.</td></tr>";
	}
	$("#marketOrder .tbl").html(html);
	$("#marketOrder .pageBar").html(data.pageBar);
}

function srchOrder(){
	var param = {
		marketNo: marketNo,
		cPage: cPage,
		orderSearchType: $("#orderSearchType option:selected").val(),
		orderSearchKeyword: $("input[name=orderSearchKeyword]").val(),
		payFlag: $("input[name=payFlag]:checked").val(),
		deliverType: $("input[name=deliverType]:checked").val(),
		payStartDate: $("#orderDate1").val(),
		payEndDate: $("#orderDate2").val()
	}
	
	console.log(param);
	
	$.ajax({
		url: "${pageContext.request.contextPath}/market/marketOrderList.do",
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
}

function comma(str) {
    str = String(str);
    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
}
</script>
<section id="marketOrder">
	<article class="subPage inner">
	    <h3 class="sub_tit">주문 내역</h3>
	    <div class="orderSearch_wrap">
	    	<div class="sec_bg">
	    		<select name="orderSearchType" id="orderSearchType" class="dp_ib">
	    			<option value="payNo">주문 번호</option>
	    			<option value="orderId">주문자 ID</option>
	    			<option value="orderName">주문자명</option>
	    		</select>
	    		<input type="text" name="orderSearchKeyword" class="dp_ib" style="width:209px; padding-right:40px;" />
	    		<div class="clearfix">
	    			<p>주문 상태</p>
	    			<div>
	    				<input type="radio" name="payFlag" value="9" id="orderState1" checked />
	    				<label for="orderState1">전체</label>
	    				&nbsp;&nbsp;
	    				<input type="radio" name="payFlag" value="0" id="orderState2" />
	    				<label for="orderState2">주문</label>
	    				&nbsp;&nbsp;
	    				<input type="radio" name="payFlag" value="1" id="orderState3" />
	    				<label for="orderState3">결제 완료</label>
	    				&nbsp;&nbsp;
	    				<input type="radio" name="payFlag" value="2" id="orderState4" />
	    				<label for="orderState4">배송 완료</label>
	    			</div>
	    		</div>
	    		<div class="clearfix">
	    			<p>배송 종류</p>
	    			<div>
	    				<input type="radio" name="deliverType" value="" id="deliver1" checked />
	    				<label for="deliver1">전체</label>
	    				&nbsp;&nbsp;
	    				<input type="radio" name="deliverType" value="d" id="deliver2" />
	    				<label for="deliver2">샛별 배송</label>
	    				&nbsp;&nbsp;
	    				<input type="radio" name="deliverType" value="n" id="deliver3" />
	    				<label for="deliver3">일반 배송</label>
	    				&nbsp;&nbsp;
	    				<input type="radio" name="deliverType" value="r" id="deliver4" />
	    				<label for="deliver4">정기 배송</label>
	    				&nbsp;&nbsp;
	    			</div>
	    		</div>
	    		<div class="clearfix">
	    			<p>주문 일자</p>
	    			<div>
	    				<input type="date" name="orderDate1" id="orderDate1" class="dp_ib eventDate" />
	    				~
	    				<input type="date" name="orderDate2"id="orderDate2" class="dp_ib eventDate" />
	    				<input type="button" value="검색" onclick="srchOrder();" class="dp_ib txt_center btn" />
	    			</div>
	    		</div>
	    	</div>
	    </div>
	    <div class="txt_right mb10"><input type="button" value="Excel 저장" id="downloadExcel" class="txt_center btn btn3" /></div>
	    <table class="tbl txt_center"></table>
        <div class="pageBar" style="margin:20px 0 0;"></div>
    </article>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>