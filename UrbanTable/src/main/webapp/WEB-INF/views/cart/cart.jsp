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
					console.log(data);
					foodInfo += "<tr id='item"+${vs.count}+"'>";
					foodInfo += "<td><input type='checkbox' name='list' checked='true'/>&nbsp;&nbsp;";
					foodInfo += "<img src='"+data.FOOD_IMG+"' width='92px' height='130px'/></td>";
					foodInfo += "<td>[" + data.FOOD_COMPANY + "] " + data.FOOD_NAME + "</td>";
					foodInfo += "<td> <input type='button' value='-' onclick='del();'>&nbsp;<input type='text' name='amount' value='" + ${l.cartAmount} + "' size='5' style='text-align:center;' onchage='change();'>&nbsp;<input type='button' value='+' onclick='add();'></td>";
					foodInfo += "<td><input type='text' name='totalPrice' value='" + data.FOOD_MEMBER_PRICE * ${l.cartAmount} + "' size='11' style='text-align:center;' readonly></td>";
					foodInfo += "</tr>";
					$("#tail").before(foodInfo);
				},
				error: function(xhr, txtStatus, err){
					console.log("ajax처리실패!", xhr, txtStatus, err);
				}				
			});		
		</c:forEach>
		
		$("#order").on("click", ()=>{
			location.href = "${pageContext.request.contextPath}/cart/order.do";
		});
		
		
	});
	
	function add(){
		
	}
	
	function del(){
		
	}
	
	function change(){
		
	}
	
	function totalPrice(){
			
	}
		
	function totalDiscount(){
			
	}
		
	function deliveryCost(){
			
	}
		
	function totalPayment(){
			
	}

</script>

<section class="sub_bg"> <!--배경색이 있는 경우만 sec_bg 넣으면 됩니다.-->
	<article class="subPage inner">
	    <h2 class="sub_tit">장바구니</h2>
	    <table class="tbl txt_center" id="cartList"> <!--가운데 정렬 아니면 txt_center 빼셔도 됩니다.
	                                    width 값은 th에 width="150" 이런식으로 써주시면 됩니다.-->
            <tr id="head">
                <th>
                	<input type="checkbox" name="list" id="checkAll" checked="true"/>
                	<label for="checkAll">전체선택(${fn:length(list)}개 품목)</label>
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
<%--             <c:forEach items="${list}" var="l">
	            <tr>
	                <td>
	                	
					</td>
	                <td>
	                	
	                </td>
	                <td>
	                	
	                </td>
	                <td>
	                	
	                </td>
	            </tr>
            </c:forEach>
 --%>       <tr id="tail">
            	<td>
            		<input type="checkbox" name="list" id="checkAll" checked="true"/>
                	<label for="checkAll">전체선택(3/3)</label>
            	</td>	
            	<td>
            		<button type="button" class="btn btn-outline-secondary">선택삭제</button>
            		<button type="button" class="btn btn-outline-secondary">전체삭제</button>
            	</td>	
            	<td colspan="2">
            		<input type="radio" name="dilivery" id="dawn" value="d"/>
            		<label for="dawn">샛별배송</label>
            		<input type="radio" name="dilivery" id="nomal" vlue="n" checked/>
            		<label for="nomal">일반배송</label>
            		<input type="radio" name="dilivery" id="regular" value="r"/>
            		<label for="regular">정기배송</label>
            	</td>	
            </tr>
        </table>
        <table class="tbl tbl_view">
            <tr>
                <th>총 상품금액</th>
                <td>행 내용</td>
            </tr>
            <tr>
                <th>할인금액</th>
                <td>행 내용</td>
            </tr>
            <tr>
                <th>배송비</th>
                <td>행 내용</td>
            </tr>
            <tr>
                <th>총 결제금액</th>
                <td>행 내용</td>
            </tr>
        </table>
        <hr />
        <div class="btn">
	        <button type="button" class="btn btn-primary" id="order"><h1>주문하기</h1></button>
        </div>
    </article>    
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>