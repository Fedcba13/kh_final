<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<script>
	$(()=>{
		getList();
		totalPrice();
		listCount();
		deliveryCost("n");
		totalPayment();
		
		$("#searchMarket").on("click", function(){
			getClosestMarket();
		});
		
		$("#order").on("click", ()=>{
			var cartArr = [];
			var cartInfo = {};
			for(var i = 1; i <= ${fn:length(list)}; i++){
				var root = $("#item" + i);
				if(root.find("input:checkbox[name='list']").is(":checked") == true){
					cartInfo.memberId = "jsi124";
					cartInfo.payPrice = parseInt($("#totalPayment").text());
					cartInfo.payFlag = 0;
					cartInfo.deliverType = $("input:radio[name='delivery']:checked").val();
					cartInfo.foodNo = root.find($("input:hidden[name='foodNo']")).val();
					cartInfo.payDetailAmount = root.find($("input:text[name='amount']")).val();
					cartArr.push(cartInfo);
				}
			}
			console.log(cartArr);
			console.log(cartInfo);
			//location.href = "${pageContext.request.contextPath}/pay/order.do";
		});
		
	});
	
	function getList(){
		<c:forEach items="${list}" var="l" varStatus="vs">
			var param ={
				foodNo: '${l.foodNo}'
			};
			var foodInfo = "";
			$.ajax({
				url: "${pageContext.request.contextPath}/cart/foodInfo.do",
				type: "POST",
				data: param,
				dataType: "json",
				async: false,
				success: function(data){
					foodInfo += "<tr id='item"+${vs.count}+"'>";
					foodInfo += "<input type='hidden' name='price' value='"+ data.FOOD_MEMBER_PRICE +"'>";
					foodInfo += "<input type='hidden' name='foodNo' value='"+ data.FOOD_NO +"'>";
					foodInfo += "<td><input type='checkbox' name='list' checked='true' onclick='checkManage(this)'/>&nbsp;&nbsp;";
					foodInfo += "<img src='"+data.FOOD_IMG+"' width='92px' height='130px'/></td>";
					foodInfo += "<td>[" + data.FOOD_COMPANY + "] " + data.FOOD_NAME + "</td>";
					foodInfo += "<td> <input type='button' value='-' onclick='del(this);'>&nbsp;<input type='text' name='amount' value='" + ${l.cartAmount} + "' size='5' style='text-align:center;' onchange='change(this);'>&nbsp;<input type='button' value='+' onclick='add(this);'></td>";
					foodInfo += "<td><input type='text' name='totalPrice' value='" + data.FOOD_MEMBER_PRICE * ${l.cartAmount} + "' size='11' style='text-align:center;' readonly></td>";
					foodInfo += "</tr>";
					$("#tail").before(foodInfo);
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
		totalPayment();
	}
	
	function add(e){
		var root = $(e).parent().parent();
		var amount = root.find("input[name='amount']");
		var total = root.find("input[name='totalPrice']");
		var price = root.children("input[type='hidden']").val();
		amount.val(parseInt(amount.val())+1);
		total.val(amount.val()*price);
		totalPrice();
		totalPayment();
	}
	
	function del(e){
		var root = $(e).parent().parent();
		var amount = root.find("input[name='amount']");
		var total = root.find("input[name='totalPrice']");
		var price = root.children("input[type='hidden']").val();
		if(parseInt(amount.val())-1 < 1){
			alert("최소 구매수량은 1개입니다 주문을 취소하시려면 구매삭제 버튼을 이용해주세요")
			return ;
		}
		amount.val(parseInt(amount.val())-1);
		total.val(amount.val()*price);
		totalPrice();
		totalPayment();
	}
	
	function change(e){
		var root = $(e).parent().parent();
		var amount = root.find("input[name='amount']");
		var total = root.find("input[name='totalPrice']");
		var price = root.children("input[type='hidden']").val();
		total.val(amount.val()*price);
		totalPrice();
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
		
	function totalDiscount(){
			
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
		var total = parseInt($("#priceSum").text()) + parseInt($("#deliveryCost").text());
		$("#totalPayment").text(total + " 원");
	}
	
	function getClosestMarket(){
		var popup = window.open("${pageContext.request.contextPath}/cart/searchMarket.do","매장찾기", "width=750, height=550");
		popup.focus();
		popup.opener = self;
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
    	   <tr id="tail">
            	<td>
            		<input type="checkbox" name="listAll" id="checkAll" checked="true" onclick="checkAll(this);"/>
                	<label for="checkAll"></label>
            	</td>	
            	<td>
            		<button type="button" class="btn btn-outline-secondary">선택삭제</button>
            		<button type="button" class="btn btn-outline-secondary">전체삭제</button>
            	</td>	
            	<td colspan="2">
            		<input type="radio" name="delivery" id="dawn" value="d" onclick="deliveryCost(this.value)"/>
            		<label for="dawn">샛별배송</label>
            		<input type="radio" name="delivery" id="nomal" value="n" onclick="deliveryCost(this.value)" checked/>
            		<label for="nomal">일반배송</label>
            		<input type="radio" name="delivery" id="regular" value="r" onclick="deliveryCost(this.value)"/>
            		<label for="regular">정기배송</label>
            	</td>	
            </tr>
            <tr>
            	<td>
            		<input type="button" class="btn btn-outline-secondary" id="searchMarket" value="매장찾기"/>
            	</td>
            	<td colspan="3">
            		<input type="text" id="market" size="80" readonly/>
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
                <th>배송비</th>
                <td id="deliveryCost"></td>
            </tr>
            <tr>
                <th>총 결제금액</th>
                <td id="totalPayment"></td>
            </tr>
        </table>
        <hr />
        <div class="btn">
	        <button type="button" class="btn btn-primary" id="order"><h2>주문하기</h2></button>
        </div>
    </article>    
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>