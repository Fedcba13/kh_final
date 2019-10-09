<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />


<style>

	.pay_list_tbl > tr{
		cursor: pointer;
	}
	
	.pay_list_tbl > tr:hover {
		background-color: #e9e9e9;
	}
	
	.pay_list_tbl > tr > td:nth-child(1) {
		width: 150px;
		text-align: center;
	}
	
	.pay_list_tbl > tr > td:nth-child(4) {
		width: 90px;
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
			
			for(var i = 0; i<data.length; i++){
				
				var date = toDate(data[i].PAY_DATE);
				var flag = '';
				if(data[i].FLAG == 1){
					flag = '배송 준비중';
				}else{
					flag = '배송 완료';
				}
			
				var html = '';
				
				html += '<tr id="'+data[i].PAY_NO+'">';
				html += '<td>';
				html += date+'<br>';
				html += data[i].MARKET_NAME+'<br>';
				html += '['+data[i].PAY_NO+']';
				html += '</td>';
				html += '<td>';
				html += '<img src="'+data[i].FOOD_IMG+'" width="100px" height="140px">';
				html += '</td>';
				html += '<td>';
				html += data[i].TXT;
				html += '<p style="text-align: right; padding-top: 20px;">'+comma(data[i].PAY_PRICE)+'원</p>';
				html += '</td>';
				html += '<td>';
				html += flag;
				html += '</td>';
				html += '</tr>';
				html += '';			
				$(".pay_list_tbl").append(html);
				
			}
			
			$(".pay_list_tbl > tr").click((e)=>{
				var pay_no = $(e.target).parents("tr").prop("id");
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
			    <h3 class="sub_tit" style="background-color: white;">주문내역 확인</h3>
			    <table class="tbl tbl_view pay_list_tbl">
			    	
			    </table>	
	        </div>
        </div>
    </article>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>