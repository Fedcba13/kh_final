<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js" type="text/javascript"></script>
<style>
	#open:hover{
		cursor: pointer;
	}
</style>
<script>
	var cartInfoArr = JSON.parse('${cartInfo}');	
	$(()=>{		
		var IMP = window.IMP; 
		IMP.init('imp69002758');
		
		$("#pay-btn").on("click", ()=>{			
			createPayInfo();
			IMP.request_pay({
			    pg : 'danal',
			    pay_method : $("input:radio[name='paymentWay']:checked").val(),
			    merchant_uid : $("#payNo").val(),
			    name : '주문명:결제테스트',
			    amount : 100,//parseInt($("#totalPaymentCost").val()),			    
			    buyer_name : "${memberLoggedIn.memberName}",
			    buyer_tel : '${memberLoggedIn.memberPhone}',
			    buyer_addr : '${memberLoggedIn.memberAddress}',
			    m_redirect_url : 'https://www.yourdomain.com/payments/complete'
			}, function(rsp) {
			    if ( rsp.success ) {	//결제 성공시
			        updatePayInfo();		//pay테이블의 flag를 0->1 로 update	        
			        $.ajax({			//결제정보를 받아오는 ajax를 작성
			        	url: "${pageContext.request.contextPath}/pay/getPayInfo.do",
			        	type: "post",
			        	data: {
			        		imp_uid: rsp.imp_uid
			        	},
			        	dataType: "json",
			        	success: function(data){
			        		console.log(data);
			        		$.ajax({
			        			url: "${pageContext.request.contextPath}/pay/insertPayment.do",
			        			type: "POST",
			        			data: {
			        				memberId: "${memberLoggedIn.memberId}",
			        				paymentWay: data.response.payMethod,
			        				card: data.response.cardName,
			        				bank: data.response.vbankName,
			        				account: data.response.vbankNum,
			        				payNo: $("#payNo").val()
			        			},
			        			success: function(data){
			        				if(data==1){
			        					//alert("paymentTable에 삽입성공");
			        				}
			        			}, 
			        			error: function(xhr, txtStatus, err){
									console.log("ajax처리실패!", xhr, txtStatus, err);
								}
			        		})
					        var msg = '결제가 완료되었습니다.\n';
					        msg += '고유ID : ' + rsp.imp_uid + "\n";
					        msg += '결제ID : ' + rsp.merchant_uid + "\n";
					        msg += '결제 금액 : ' + rsp.paid_amount + "\n";
					        msg += '카드 승인번호 : ' + rsp.apply_num;
							alert(msg);
							deleteCart();
							updateCoupon();
							updatePoint();
						},
						error: function(xhr, txtStatus, err){
							console.log("ajax처리실패!", xhr, txtStatus, err);
						},
						complete: function(){
							location.replace("${pageContext.request.contextPath}/pay/payEnd.do?payNo=" + $("#payNo").val());
						}
			        })			        
			    } else {
			        var msg = '결제에 실패하였습니다.\n';
			        msg += '에러내용 : ' + rsp.error_msg;
			        deletePayDetail();
			        deletePayInfo();
			        alert(msg);
			    }
			    
			});
		});
		orderInfo();
		getCartList();
		getCouponList();
		$("#open").on("click", ()=>{
			$("#list").slideToggle(100, "swing", function(){
				if($("#list").css("display") == "none"){
					$("#open").text("펼치기");
				} else {
					$("#open").text("접기");					
				}
			});
		});
		
		$("#deliveryAddress").on("click", ()=>{
			new daum.Postcode({
				oncomplete: function(data) {		            
		           $("#userAddressField").val(data.roadAddress);
		        }
			}).open()
		});
		
		$("#marketAddress").on("click", ()=>{
			//var popup = window.open("${pageContext.request.contextPath}/cart/searchMarket.do?addr=" + $("#userAddressField").val(),"매장찾기", "width=750, height=550");
			//popup.focus();
			//popup.opener = self;
			if(confirm("매장 변경시 장바구니 페이지로 돌아가게 됩니다. 계속 하시겠습니까?")){
				location.href="${pageContext.request.contextPath}/cart/cartList.do?memberId=${memberLoggedIn.memberId}&memberCheck=${memberLoggedIn.memberCheck}";
			}
		});
		
		$("#selectCoupon").on("click", ()=>{
			$("#selectCouponModal").css("display", "block");
		});
		$("#showPoint").on("click", ()=>{
			console.log(${memberLoggedIn.memberPoint});
			if(${memberLoggedIn.memberPoint} < 1000){
				alert("보유하신 포인트가 1000포인트 미만입니다("+${memberLoggedIn.memberPoint}+"보유중)");
			} else {
				$("#showPointModal").css("display", "block");
			}
		})
	});	//onload 함수 끝
	
	
	console.log(${cartInfo});
	//console.log(${cartInfo});	
	//console.log(${cartInfo});	
	//console.log(${cartInfo});
	
	function getCartList(){			
		$("#totalList").text(cartInfoArr.length + "개 품목");
		$("#totalCost").text(cartInfoArr[0].payPrice + " 원");
		for(var i=0; i < cartInfoArr.length; i++){
			var param ={
					foodNo: cartInfoArr[i].foodNo
				};
			var foodInfo = "";
			$.ajax({
				url: "${pageContext.request.contextPath}/cart/foodInfo.do",
				type: "POST",
				data: param,
				dataType: "json",
				async: false,
				success: function(data){
					$.ajax({
						url: "${pageContext.request.contextPath}/cart/getDiscount.do",
						type: "post",
						async: false,
						data: {
							marketNo: $("#marketNo").val(),
							foodNo: cartInfoArr[i].foodNo		
						},
						success: function(dc){
							foodInfo += "<tr id='item"+(i+1)+"'>";					
							foodInfo += "<td><img src='"+data.FOOD_IMG+"' width='92px' height='130px'/></td>";
							foodInfo += "<td>[" + data.FOOD_COMPANY + "] " + data.FOOD_NAME + "</td>";
							foodInfo += "<td>수량 <input type='text' name='amount' value='" + cartInfoArr[i].payDetailAmount + "' size='5' style='text-align:center;' readonly></td>";
							foodInfo += "<td>금액 <input type='text' name='totalPrice' value='" + Math.floor((data.FOOD_MEMBER_PRICE * (1-dc/100))/10)*10 * cartInfoArr[i].payDetailAmount + "' size='11' style='text-align:center;' readonly></td>";
							foodInfo += "</tr>";
							$("#list").append(foodInfo);	
						},
						error: function(xhr, txtStatus, err){
							console.log("ajax처리실패!", xhr, txtStatus, err);
						}			
					})
				},
				error: function(xhr, txtStatus, err){
					console.log("ajax처리실패!", xhr, txtStatus, err);
				}
			});
		}
	}
	
	function orderInfo(){
		if(cartInfoArr[0].deliverType == "d"){
			$("#totalPrice").val((cartInfoArr[0].payPrice - 5000) + " 원");		
		} else if (cartInfoArr[0].deliverType == "n") {
			$("#totalPrice").val((cartInfoArr[0].payPrice - 2500) + " 원");			
		} else {
			$("#totalPrice").val((cartInfoArr[0].payPrice - 30000) + " 원");
		}
		//$("#orderInfo td").eq(0).append(cartInfoArr[0].payPrice + " 원");
		$("#userAddressField").val("${memberLoggedIn.memberAddress}");
		$("#marketAddressField").val(cartInfoArr[0].market);
		getMarketNo();
		if(cartInfoArr[0].deliverType == "d"){
			$("#deliveryType").val("샛별배송 (5000원+)");
			$("#deliveryCost").val("5000");
			$("#deliverType").val("d")
		} else if (cartInfoArr[0].deliverType == "n") {
			$("#deliveryType").val("일반배송 (2500원+)");
			$("#deliveryCost").val("2500");
			$("#deliverType").val("n")
		} else {
			$("#deliveryType").val("정기배송 (30000원+)");
			$("#deliveryCost").val("30000");
			$("#deliverType").val("r");
		}
		$("#totalPaymentCost").val(cartInfoArr[0].payPrice + " 원");
	}
	
	function getCouponList(){
		$.ajax({
			url: "${pageContext.request.contextPath}/pay/getCoupons.do",
			type: "post",
			data: {
				memberId: "${memberLoggedIn.memberId}"
			},
			success: function(data){
				//.log(data[0].COUPON_DISCOUNT);
				//console.log(data);
				var coupons = "";
				for(var i =0; i < data.length; i++){
					if(data[i].COUPON_MIN_PRICE < parseInt($("#totalPrice").val())){
						var endDate = new Date(data[i].COUPON_END_DATE);
						coupons += "<option value='"+data[i].COUPON_DISCOUNT+"|"+data[i].COUPON_ID+"'>"
						coupons += data[i].COUPON_DISCOUNT + "% 할인쿠폰 (유효기간: " + endDate.getFullYear() + "년 " + (parseInt(endDate.getMonth())+1) + "월 " + endDate.getDate() +"일 까지)";
					}
					
				}
				$("#couponList").append(coupons);
			},
			error: function(xhr, txtStatus, err){
				console.log("ajax처리실패!", xhr, txtStatus, err);
			}
		});
	}
	
	function submitCoupon(){
		$("#selectCouponModal").css("display", "none");
		var selectedCoupon = $("#couponList option:selected").val()
		$("#selectedCoupon").val($("#couponList option:selected").text());
		//console.log(selectedCoupon);
		$("#couponDiscount").val(selectedCoupon.substring(0, selectedCoupon.indexOf("|")));
		$("#couponId").val(selectedCoupon.substring(selectedCoupon.indexOf("|")+1));
		console.log($("#couponId").val());
		//console.log($("#couponDiscount").val());
		var payPrice = cartInfoArr[0].payPrice;
		var dcRate = $("#couponDiscount").val();
		var delCost = $("#deliveryCost").val();
		$("#totalPrice").val(((payPrice - delCost) * (1-(dcRate/100))) + " 원");
		var totalPrice = parseInt($("#totalPrice").val());
		var totalPayment = totalPrice + parseInt(delCost);
		$("#totalPaymentCost").val(totalPayment+ " 원");
	}
	
	function submitPoint(){
		if($("#usePoint").val() < 1000){
			alert("최소 1000포인트부터 사용하실수 있습니다");
			return ;
		}
		$("#showPointModal").css("display", "none");
		var point = $("#usePoint").val();		
		$("#memberPoint").val(point);
		var totalPrice = parseInt($("#totalPrice").val());
		var delCost = $("#deliveryCost").val();
		var totalPayment = (totalPrice + parseInt(delCost)) - parseInt($("#memberPoint").val());
		$("#totalPaymentCost").val(totalPayment+ " 원");
	}
	
	function createPayInfo(){
		var payInfo ={
				memberId: "${memberLoggedIn.memberId}",
				payPrice: parseInt($("#totalPaymentCost").val()),
				payFlag: 0,
				deliverType: $("#deliverType").val(),
				marketNo: $("#marketNo").val()
		}
		console.log(payInfo);
		$.ajax({
			url: "${pageContext.request.contextPath}/pay/pay.do",
			type: "post",
			data: payInfo,
			async: false,
			success: function(data){
				//console.log(data);
				$("#payNo").val(data);
				for(var i=0; i < cartInfoArr.length; i++){
					var param = {};
					param.payNo = data;
					param.foodNo = cartInfoArr[i].foodNo;
					param.payDetailAmount = cartInfoArr[i].payDetailAmount;
					param.marketNo = $("#marketNo").val();
					$.ajax({
						url: "${pageContext.request.contextPath}/pay/payDetail.do",
						type: "post",
						data: param,
						async: false,
						success: function(data){
							console.log(data);
						},
						error: function(xhr, txtStatus, err){
							console.log("ajax처리실패!", xhr, txtStatus, err);
						}
					})
				}
			},
			error: function(xhr, txtStatus, err){
				console.log("ajax처리실패!", xhr, txtStatus, err);
			}
		});
	}
	
	function getMarketNo(){
		var addr = $("#marketAddressField").val().substring($("#marketAddressField").val().indexOf(" ") +1);
		var param = {
				address: addr
		}
		$.ajax({
			url: "${pageContext.request.contextPath}/pay/marketNo.do",
			type: "post",
			data: param,
			async: false,
			success: function(data){
				//console.log(data);
				$("#marketNo").val(data);
			},
			error: function(xhr, txtStatus, err){
				console.log("ajax처리실패!", xhr, txtStatus, err);
			}
		});
	}
	
	function deletePayDetail(){
		for(var i=0; i < cartInfoArr.length; i++){
			var param = {};
			param.payNo = $("#payNo").val();
			param.foodNo = cartInfoArr[i].foodNo;
			param.payDetailAmount = cartInfoArr[i].payDetailAmount;
			param.marketNo = $("#marketNo").val();
			$.ajax({
				url: "${pageContext.request.contextPath}/pay/delDetail.do",
				type: "post",
				data: param,
				async: false,
				success: function(data){
					console.log(data);
				},
				error: function(xhr, txtStatus, err){
					console.log("ajax처리실패!", xhr, txtStatus, err);
				}
			})
		}
	}
	
	function deletePayInfo(){
		var param = {
			payNo: $("#payNo").val(),
			memberId: "${memberLoggedIn.memberId}",
			payFlag: 0
		}
		$.ajax({
			url: "${pageContext.request.contextPath}/pay/delPay.do",
			type: "post",
			data: param,
			success: function(data){
				console.log(data);
			},
			error: function(xhr, txtStatus, err){
				console.log("ajax처리실패!", xhr, txtStatus, err);
			}
		})
	}
	
	function updatePayInfo(){
		var param = {
				payNo: $("#payNo").val(),
				memberId: "${memberLoggedIn.memberId}",
				payFlag: 1
		}
		$.ajax({
			url: "${pageContext.request.contextPath}/pay/updatePay.do",
			type: "post",
			data: param,
			success: function(data){
				console.log(data);
			},
			error: function(xhr, txtStatus, err){
				console.log("ajax처리실패!", xhr, txtStatus, err);
			}
		})
	}
	
	function deleteCart(){
		var param = {
				memberId: "${memberLoggedIn.memberId}",
				flag: 1
		}
		$.ajax({
			url: "${pageContext.request.contextPath}/pay/deleteCart.do",
			data: param,
			type: "post",
			success: function(data){
				if(data>0){
					console.log("cart table 삭제 완료");
				}
				
			},
			error: function(xhr, txtStatus, err){
				console.log("ajax처리실패!", xhr, txtStatus, err);
			}
		})
	}
	
	function updateCoupon(){
		$.ajax({
			url: "${pageContext.request.contextPath}/pay/updateCoupon.do",
			data: {
				memberId: "${memberLoggedIn.memberId}",
				couponId: $("#couponId").val()
			},
			type: "post",
			success: function(data){
				
			},
			error: function(xhr, txtStatus, err){
				console.log("ajax처리실패!", xhr, txtStatus, err);
			}
		});
	}
	
	function updatePoint(){
		$.ajax({
			url: "${pageContext.request.contextPath}/pay/updatePoint.do",
			data: {
				memberId: "${memberLoggedIn.memberId}",
				memberPoint: parseInt($("#memberPoint").val())
			},
			type: "post",
			success: function(data){
				
			},
			error: function(xhr, txtStatus, err){
				console.log("ajax처리실패!", xhr, txtStatus, err);
			}
		});
	}
	
	function closeModal(){
		$("#selectCouponModal").css("display", "none");
	}
	
	function closePoint(){
		$("#showPointModal").css("display", "none");
	}
	
</script>

<section class="sec_bg"> <!--배경색이 있는 경우만 sec_bg 넣으면 됩니다.-->
	<article class="subPage inner">
	    <h3 class="sub_tit">주문하기</h3>
	    <table class="tbl txt_center"> <!--가운데 정렬 아니면 txt_center 빼셔도 됩니다.
	                                    width 값은 th에 width="150" 이런식으로 써주시면 됩니다.-->
            <thead>
	            <tr>
	                <th colspan="3" id="totalList"></th>
	                <th id="totalCost"></th>                
	            </tr>
            </thead>
            <tbody id="list" style="display: none;">
            	
            </tbody>
            <tfoot>
	            <tr>
	                <td colspan="4" id="open">펼치기</td>
	                
	            </tr>
            </tfoot>
        </table>
        <table class="tbl tbl_view" id="orderInfo">
            <tr>
                <th>총 상품금액</th>
                <td colspan="2"><input type="text" id="totalPrice" size="50" readonly/></td>
            </tr>
            <tr>
                <th>배송지 주소</th>
                <td>
                	<input type="text" id="userAddressField" size="50" readonly/>             	
                </td>
                <td>
                	&nbsp;&nbsp;<input type="button" id="deliveryAddress" class="btn" value="배송지 변경"/>
                </td>
            </tr>
            <tr>
                <th>배송매장 주소</th>
                <td>
                	<input type="text" id="marketAddressField" size="50" readonly/>
                	<input type="hidden" id="marketNo" />
                </td>
                <td>
                	&nbsp;&nbsp;<input type="button" id="marketAddress" class="btn" value="매장변경" />
                </td>
            </tr>
            <tr>
                <th>배송방식</th>
                <td colspan="2">
                	<input type="text" id="deliveryType" size="50" readonly/>
                	<input type="hidden" id="deliveryCost" />
                	<input type="hidden" id="deliverType" />
                </td>
            </tr>
            <tr>
                <th>쿠폰사용</th>
                <td>
                	<input type="text" id="selectedCoupon" size="50" placeholder="쿠폰을 선택하세요" readonly/>
                	<input type="hidden" id="couponId" value=""/>
                	<input type="hidden" id="couponDiscount" value=""/>
                </td>
                <td>&nbsp;&nbsp;<input type="button" id="selectCoupon" class="btn" value="쿠폰사용" /></td>
            </tr>
            <tr>
            	<th>포인트 사용</th>
            	<td>
            		<input type="text" id="memberPoint" size="50" placeholder="1000포인트 이상 보유시 사용할수 있습니다" readonly/>
            	</td>
            	<td>&nbsp;&nbsp;<input type="button" id="showPoint" class="btn" value="포인트 보기"/></td>
            </tr>
            <tr>
                <th>총 결제금액</th>
                <td colspan="2"><input type="text" id="totalPaymentCost" size="50" readonly/></td>
            </tr>
            <tr>
                <th colspan="2">※결제를 진행하기 전에 결제정보를 꼼꼼히 확인해 주세요</th>                
            </tr>
        </table>
        <hr />
        <table class="tbl tbl_view" >
            <tr>
                <th>결제방식</th>
                <td>
                	<input type="radio" name="paymentWay" id="card" value="card" checked/>
                	<label for="card">카드</label>
                	<input type="radio" name="paymentWay" id="bank" value="vbank"/>
                	<label for="bank">무통장입금</label>
                	<input type="radio" name="paymentWay" id="mobile" value="phone"/>
                	<label for="mobile">휴대폰</label>
                </td>
            </tr>
        </table>
        <input type="hidden" id="payNo" />
        <input type="button" class="btn" value="결제하기" id="pay-btn"/>
    </article>
    <div class="modal txt_center" id="selectCouponModal">
		<form class="modal-content animate">
			<div class="container txt_center">
				<span>쿠폰을 선택하세요(유효기간이 지난 쿠폰은 자동으로 삭제됩니다)</span><br />
				<select class="select" name="coupons" id="couponList">
				</select>
			</div>
			<div class="container txt_center" style="background-color:#f4f4f0;">
				<button type="button" class="btn btn2 cancelbtn" style="float:right; margin-right: 10px;" onclick="closeModal();">취소</button>
				<button type="button" class="btn btn2 cancelbtn" style="float:right; margin-right: 10px;" onclick="submitCoupon();">쿠폰선택</button>
		    </div>
		</form>
	</div>
    <div class="modal txt_center" id="showPointModal">
		<form class="modal-content animate">
			<div class="container txt_center">
				<span>${memberLoggedIn.memberId}님이 보유하고 있는 포인트는 총 ${memberLoggedIn.memberPoint}점 입니다</span><br />
				<input type="number" id="usePoint" style="width: 100px;" value=0 max="${memberLoggedIn.memberPoint}" min="1000"/> 포인트 사용
				</select>
			</div>
			<div class="container txt_center" style="background-color:#f4f4f0;">
				<button type="button" class="btn btn2 cancelbtn" style="float:right; margin-right: 10px;" onclick="closePoint();">취소</button>
				<button type="button" class="btn btn2 cancelbtn" style="float:right; margin-right: 10px;" onclick="submitPoint();">포인트사용</button>
		    </div>
		</form>
	</div>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>