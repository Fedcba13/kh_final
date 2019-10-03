<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<script>
	var length = ${fn:length(list)};
	$(()=>{
		getMarket();
		getList();
		totalPrice();
		listCount();
		deliveryCost("n");
		discountCost();
		finalPrice();
		totalPayment();		
		
		$("#searchMarket").on("click", function(){
			getClosestMarket();
		});
		
		$("#order").on("click", ()=>{
			var cartArr = [];
			var selectedCount = 0;
			var count = 0;
			var lackedProduct = new Array();
			<c:if test="${empty list}">
				alert("장바구니에 상품을 넣어주세요!")
				return ;
			</c:if>
			if($("#market").val() == ""){
				alert("배송할 매장을 선택하세요!")
				return;
			}
			for(var i = 1; i <= ${fn:length(list)}; i++){
				var root = $("#item" + i);				
				if(root.find("input:checkbox[name='list']").is(":checked") == true){
					selectedCount++;
					var cartInfo = {};
					cartInfo.memberId = "${memberLoggedIn}";
					cartInfo.payPrice = parseInt($("#totalPayment").text());
					cartInfo.payFlag = 0;
					cartInfo.deliverType = $("input:radio[name='delivery']:checked").val();
					cartInfo.foodNo = root.find($("input:hidden[name='foodNo']")).val();
					cartInfo.payDetailAmount = root.find($("input:text[name='amount']")).val();
					var marketAddress = $("#market").val().substring(0, $("#market").val().indexOf("(")-1);
					cartInfo.market = marketAddress;
					$.ajax({
						url: "${pageContext.request.contextPath}/cart/checkstock.do",
						type: "post",
						data: cartInfo,
						async: false,
						success: function(data){
							console.log(data);							
							if(data){
								count++;							
							} else {
								lackedProduct.push(root.find($("td[name='foodName']")).text());
							}
						},
						error: function(xhr, txtStatus, err){
							console.log("ajax처리실패!", xhr, txtStatus, err);
						}
					});
					cartArr.push(cartInfo);					
				}				
			}
			var cartJson = JSON.stringify(cartArr);
			console.log(cartArr);
			console.log(cartJson);
			console.log(count);
			console.log(selectedCount);			
			console.log(lackedProduct);
			$("input[name='cartInfo']").val(cartJson)
			if(count == selectedCount){
				$("#doOrder").submit();				
			} else {
				var str = "";
				for(var i=0; i < lackedProduct.length; i++){
					str += lackedProduct[i] + "\n";
				}
				alert("선택된 매장에 재고가 부족합니다. 매장을 변경하거나 상품을 변경해주세요\n" + str);				
			}
		});
		
	});
	
	function getList(){				
		<c:forEach items="${list}" var="l" varStatus="vs">
			var param ={
				foodNo: '${l.foodNo}'
			};
			var foodInfo = "";
			var dc;
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
							foodNo: data.FOOD_NO		
						},
						success: function(dc){
							console.log(dc);							
							foodInfo += "<tr id='item"+${vs.count}+"'>";
							foodInfo += "<input type='hidden' name='price' value='"+ data.FOOD_MEMBER_PRICE +"'>";
							foodInfo += "<input type='hidden' name='discountPrice' value='"+Math.floor((data.FOOD_MEMBER_PRICE * (1-dc/100))/10)*10+"'>"
							foodInfo += "<input type='hidden' name='foodNo' value='"+ data.FOOD_NO +"'>";
							foodInfo += "<td><input type='checkbox' name='list' id='check"+${vs.count}+"' checked='true' onclick='checkManage(this)'/>&nbsp;&nbsp;&nbsp;";
							foodInfo += "<img src='"+data.FOOD_IMG+"' width='92px' height='130px'/></td>";
							foodInfo += "<td name='foodName'>[" + data.FOOD_COMPANY + "] " + data.FOOD_NAME + "</td>";
							foodInfo += "<td> <input type='button' value='-' onclick='del(this);'>&nbsp;<input type='text' name='amount' value='" + ${l.cartAmount} + "' size='5' style='text-align:center;' onchange='change(this);'>&nbsp;<input type='button' value='+' onclick='add(this);'></td>";
							foodInfo += "<td><input type='text' name='totalDiscountPrice' value='"+Math.floor((data.FOOD_MEMBER_PRICE * (1-dc/100))/10)*10 * ${l.cartAmount}+"' size='11' style='text-align:center;' readonly></td>";
							foodInfo += "<input type='hidden' name='totalPrice' value='" + data.FOOD_MEMBER_PRICE * ${l.cartAmount} + "' size='11' style='text-align:center;' readonly>"
							foodInfo += "</tr>";
							$("#tail").before(foodInfo);
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
		</c:forEach>
	}
	
	function checkManage(e){
		var checkedAll = false;
		if($(e).is(":checked") == false){
			$(e).prop("checked", false);
			$("input:checkbox[name='listAll']").prop("checked", false);
		} else {
			$("input:checkbox[name='list']").each(function(){
				if(this.checked == false){
					checkedAll = false;
					return false;
				}
				checkedAll = true;
			})
			if(checkedAll == true)
				$("input:checkbox[name='listAll']").prop("checked", true);
		}
		listCount();
		totalPrice();
		discountCost();
		finalPrice();
		totalPayment();
	}
	
	function listCount(){
		var total = ${fn:length(list)};
		var selected = $("input:checkbox[name='list']:checked").length;
		var text = "전체선택 (" + selected + "/" + total + ")";
		$("label[for='checkAll']").text(text);
	}
	
	function checkAll(e){
		if($(e).is(":checked") == true){
			$("input:checkbox[name='list']").prop("checked", true);
			$("input:checkbox[name='listAll']").prop("checked", true);
		} else {
			$("input:checkbox[name='list']").each(function(){
				$("input:checkbox[name='list']").prop("checked", false);
				$("input:checkbox[name='listAll']").prop("checked", false);
			}) 	
		}
		listCount();
		totalPrice();
		discountCost();
		finalPrice();
		totalPayment();
	}
	
	function add(e){
		var root = $(e).parent().parent();
		var amount = root.find("input[name='amount']");
		var total = root.find("input[name='totalPrice']");
		var price = root.children("input[name='price']").val();
		var dcTotal = root.find("input[name='totalDiscountPrice']");
		var dcPrice = root.children("input[name='discountPrice']").val();
		amount.val(parseInt(amount.val())+1);
		total.val(amount.val()*price);
		dcTotal.val(amount.val()*dcPrice);
		totalPrice();
		discountCost();
		finalPrice();
		totalPayment();
	}
	
	function del(e){
		var root = $(e).parent().parent();
		var amount = root.find("input[name='amount']");
		var total = root.find("input[name='totalPrice']");
		var price = root.children("input[type='hidden']").val();
		var dcTotal = root.find("input[name='totalDiscountPrice']");
		var dcPrice = root.children("input[name='discountPrice']").val();
		if(parseInt(amount.val())-1 < 1){
			alert("최소 구매수량은 1개입니다 주문을 취소하시려면 구매삭제 버튼을 이용해주세요")
			return ;
		}
		amount.val(parseInt(amount.val())-1);
		total.val(amount.val()*price);
		dcTotal.val(amount.val()*dcPrice);
		totalPrice();
		discountCost();
		finalPrice();
		totalPayment();
	}
	
	function change(e){
		var root = $(e).parent().parent();
		var amount = root.find("input[name='amount']");
		var total = root.find("input[name='totalPrice']");
		var price = root.children("input[type='hidden']").val();
		var dcTotal = root.find("input[name='totalDiscountPrice']");
		var dcPrice = root.children("input[name='discountPrice']").val();
		if(parseInt(amount.val())==0){
			alert("최소 구매수량은 1개입니다 주문을 취소하시려면 구매삭제 버튼을 이용해주세요")
			amount.val(1);
		}
		total.val(amount.val()*price);
		dcTotal.val(amount.val()*dcPrice);
		totalPrice();
		discountCost();
		finalPrice();
		totalPayment();
	}
	
	function totalPrice(){
		var sum = 0;
		for(var i = 1; i <= ${fn:length(list)}; i++){
			if($("#item"+i).find("input:checkbox[name='list']").is(":checked")==true)
				sum += parseInt($("#item" + i).find("input[name='totalPrice']").val());
		}
		$("#priceSum").text(sum + " 원");
		return sum;
	}	
		
	function discountCost(){
		var listPrice = 0;
		var dcPrice = 0;
		for(var i = 1; i <= ${fn:length(list)}; i++){
			if($("#item"+i).find("input:checkbox[name='list']").is(":checked")==true){
				listPrice += parseInt($("#item" + i).find("input[name='totalPrice']").val());
				dcPrice += parseInt($("#item" + i).find("input[name='totalDiscountPrice']").val());
			}				
		}
		$("#discount").text("-" + (listPrice-dcPrice) + " 원");
	}
	
	function finalPrice(){
		var dcPrice = 0;
		for(var i = 1; i <= ${fn:length(list)}; i++){
			if($("#item"+i).find("input:checkbox[name='list']").is(":checked")==true){
				dcPrice += parseInt($("#item" + i).find("input[name='totalDiscountPrice']").val());
			}				
		}
		$("#finalCost").text(dcPrice + " 원");
	}
		
	function deliveryCost(v){
		if(v == "d"){
			$("#deliveryCost").text("5000 원(샛별배송)")	
			totalPayment();
		} else if(v == "n") {
			$("#deliveryCost").text("2500 원(일반배송)")	
			totalPayment();
		} else if(v == "r") {
			$("#deliveryCost").text("30000 원(정기배송)")
			totalPayment();
		}		
	}
		
	function totalPayment(){
		var total = parseInt($("#finalCost").text()) + parseInt($("#deliveryCost").text());
		$("#totalPayment").text(total + " 원");
	}
	
	function getClosestMarket(){
		if(confirm("매장을 변경할 겨우 일부상품의 재고가 없거나 할인에 변동이 있을 수 있습니다.\n 계속하시겠습니까?")){
			var popup = window.open("${pageContext.request.contextPath}/cart/searchMarket.do","매장찾기", "width=750, height=550");
			popup.focus();
			popup.opener = self;	
		}
	}
	
	function getMarket(){
		$.ajax({
			url: "${pageContext.request.contextPath}/cart/getMarket.do",
			data: {
				address: "${memberLoggedIn.memberAddress}"
			},
			async: false,
			success: function(data){
				console.log(data);
				$("#market").val(data.nearMarket + " (" + data.marketName + ")");
				$("#marketNo").val(data.marketNo);
			},
			error: function(xhr, txtStatus, err){
				console.log("ajax처리실패!", xhr, txtStatus, err);
			}
		})
	}
	
	function getMarketNo(){
		$.ajax({
			url: "${pageContext.request.contextPath}/cart/getMarket.do",
			data: {
				address: $("#market").val().substring(0,$("#market").val().indexOf("("))
			},
			async: false,
			success: function(data){
				console.log(data);				
				$("#marketNo").val(data.marketNo);
			},
			error: function(xhr, txtStatus, err){
				console.log("ajax처리실패!", xhr, txtStatus, err);
			}
		});
	}
	
	function changeMarket(){
		console.log($("#market").val().substring(0,$("#market").val().indexOf("(")))
	}
	
	function deleteSel(){
		for(var i = 1; i <= ${fn:length(list)}; i++){
			if($("#item"+i).find("input:checkbox[name='list']").is(":checked")==true){
				var foodNo = $("#item"+i).find("input:hidden[name='foodNo']").val();
				$.ajax({
					url: "${pageContext.request.contextPath}/cart/deleteCart.do",
					data: {
						foodNo: foodNo,
						memberId: "${memberLoggedIn.memberId}"
					},
					async: false,
					success: function(data){
						console.log(data);
					},
					error: function(xhr, txtStatus, err){
						console.log("ajax처리실패!", xhr, txtStatus, err);
					}
				});
			}
			$("#item"+i).remove();
		}
		console.log("${list}");
		getList();
		totalPrice();
		discountCost();
		finalPrice();
		totalPayment();
	}
	
	function deleteAll(){
		
	}

</script>

<section class="sub_bg"> <!--배경색이 있는 경우만 sec_bg 넣으면 됩니다.-->
	<article class="subPage inner">
	    <h2 class="sub_tit">장바구니</h2>
	    <table class="tbl txt_center" id="cartList"> <!--가운데 정렬 아니면 txt_center 빼셔도 됩니다.
	                                    width 값은 th에 width="150" 이런식으로 써주시면 됩니다.-->
            <tr id="head">
                <th>
                	<input type="checkbox" name="listAll" id="checkAll" checked="true" onclick="checkAll(this);"/>                
                	<label for="checkAll"></label>
                </th>
                <th>
                	상품정보
                </th>
                <th>
                	수량
                </th>
                <th>
                	금액
                </th>
           </tr>
           <tr id="body">
           </tr>
    	   <tr id="tail">
            	<td>
            		<input type="checkbox" name="listAll" id="checkAll" checked="true" onclick="checkAll(this);"/>
                	<label for="checkAll"></label>
            	</td>	
            	<td>
            		<button type="button" class="btn" onclick="deleteSel()">선택삭제</button>
            		<button type="button" class="btn" onclick="deleteAll()">전체삭제</button>
            	</td>	
            	<td colspan="2">
            		<input type="radio" name="delivery" id="dawn" value="d" onchange="deliveryCost(this.value)"/>
            		<label for="dawn">샛별배송</label>
            		<input type="radio" name="delivery" id="nomal" value="n" onchange="deliveryCost(this.value)" checked/>
            		<label for="nomal">일반배송</label>
            		<input type="radio" name="delivery" id="regular" value="r" onchange="deliveryCost(this.value)"/>
            		<label for="regular">정기배송</label>
            	</td>	
            </tr>
            <tr>
            	<td>
            		<input type="button" class="btn" id="searchMarket" value="매장찾기"/>
            	</td>
            	<td colspan="3">
            		<input type="text" id="market" size="80" readonly/>
            		<input type="hidden" id="marketNo" />
            	</td>
            </tr>
        </table>
        <table class="tbl tbl_view">
            <tr>
                <th>총 상품금액</th>
                <td id="priceSum"></td>
            </tr>
            <tr>
                <th>할인금액</th>
                <td id="discount"></td>	
            </tr>
            <tr>
            	<th>최종금액</th>
            	<td id="finalCost"></td>
            </tr>
            <tr>
                <th>배송비</th>
                <td id="deliveryCost"></td>
            </tr>
            <tr>
                <th>총 결제금액</th>
                <td id="totalPayment"></td>
            </tr>
        </table>
        <hr />
        <form action="${pageContext.request.contextPath}/pay/order.do" method="post" id="doOrder">
        	<input type="hidden" name="cartInfo" />        	
	        <div class="btn">
		        <button type="button" class="btn" id="order"><h2>주문하기</h2></button>
		    </div>        
        </form>
    </article>    
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>