<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/kakaoAPI.js" charset="UTF-8"></script>

<style>

	.address_footer{
		text-align: center;
	}
	
	.address_content{
   		width: 600px;
   		margin-bottom: 30px;
   	}
   
   	.address-card .btn{
   		width: 60px;
   	}
   	
   	.address-card{
   		border-width: 0 1px;
   		border-style: solid;
   		border-color: #e9e9e9;
   	}
   	
   	.address .insertAddr, .address .confirmAddr{
   		margin-right: 30px;
   	}
   	
   	.addr_tbl{
   		margin-bottom: 15px;
   	}
   	
   	.addr_tbl .modifyAddr, .addr_tbl .confirmAddr{
   		width: 100px;
   	}
   	
   	.addr_tbl tr th{
		vertical-align: top;
		padding-top: 20px;
	}
	
	.addr_tbl tr > td input:not([type="button"]){
		width: 300px;
		margin-right: 15px;
	}
	
	.addr_tbl td.red{
		font-size: 12px;
	}

</style>

<script>
$(()=>{
	
	//추가
	$(".insertAddr").click(()=>{
		var size = $(".address-card").length;
		
		if(size >= 5){
			alert('주소는 최대 5개까지 저장 가능합니다.')
		}else{
			
			$(".insertAddr").val('적용하기');
			$(".insertAddr").addClass("confirmAddr").removeClass("insertAddr");
			$(".address_footer").append('<input type="button" value="취소하기" class="btn btn2 cancleAddr">');
			
			var html = '<div class="address-card">';
			html += '<table class="tbl tbl_view addr_tbl">';
			html +=  '<tr>';
			html += '<td>';
			html += '<input type="text" placeholder="주소 이름을 입력하세요. 예) 집" style="width:350px;" name="addressName">';
			html += '</td>';
			html += '</tr>';
			html += '<tr class="tbl_addr1">';
			html += '<td><input type="text" name="memberAddress" readonly="readonly" value="${address.MEMBER_ADDRESS }"></td>';
			html += '</tr>';
			html += '<tr class="tbl_addr2">';
			html += '<td><input type="text" placeholder="세부주소를 입력해주세요." maxlength="35" name="memberAddress2"></td>';
			html += '</tr>';
			html += '<tr>';
			html += '<td><input type="button" value="주소 검색" class="btn srchAddr" style="width:150px"></td>';
			html += '</tr>';
			html += '</table>';
			html += '</div>';
				
			$(".address_content").append(html);
			
			$(".cancleAddr").click(()=>{
				alert('취소하셨습니다.');
				location.reload();
			});
			
			$(".srchAddr").click(()=>{
				sample6_execDaumPostcode();	
			});
			
			$(".confirmAddr").off();
			
			$(".confirmAddr").click(()=>{
				 var param = {
						 	addressName : $("[name=addressName]").val(),
							memberAddress : $(".tbl_addr1  [name=memberAddress]").val(),
							memberAddress2 : $(".tbl_addr2 [name=memberAddress2]").val()
					}
					
					$.ajax({
						url: contextPath+'/member/insertAddr',
						data: param,
						success: (data)=>{
							alert(data.msg);
							location.reload();
						},
						error: (xhr, txtStatus, err)=> {
							console.log("ajax 처리실패!", xhr, txtStatus, err);
						}
					}); 
			});
			
		}
	});
	
	
	//수정
	$(".modifyAddr").click((e)=>{
		
		if($('.confirmAddr').length != 0){
			alert('이전 작업을 완료해주세요.');
			return;
		}
		
		var $tbl = $(e.target).parents(".addr_tbl");
		
		console.log($tbl);
		
		$tbl.find('.addr1').addClass('tbl_addr1');
		$tbl.find('.addr2').addClass('tbl_addr2');
		
		$tbl.find('.modifyAddr').addClass('confirmAddr').removeClass('modifyAddr').val("수정 완료");
		$tbl.find('.deleteAddr').addClass('cancleAddr').removeClass('deleteAddr').val('취소하기');
		
		$tbl.find('[name=address]').prop('name', 'memberAddress');
		$tbl.find('[name=address2]').prop('name', 'memberAddress2').prop("readonly", false);
		
		sample6_execDaumPostcode();
		
		//모든 함수 제거
		$(".confirmAddr").off();
		
		$(".confirmAddr").on("click", ()=>{
			
			 var param = {
					addressNo : $($tbl.find('#addr_id')).val(),
					memberAddress : $(".tbl_addr1  [name=memberAddress]").val(),
					memberAddress2 : $(".tbl_addr2 [name=memberAddress2]").val()
			}
			
			console.log(param);
			
			$.ajax({
				url: contextPath+'/member/modifyAddr',
				data: param,
				success: (data)=>{
					alert(data.msg);
					location.reload();
				},
				error: (xhr, txtStatus, err)=> {
					console.log("ajax 처리실패!", xhr, txtStatus, err);
				}
			}); 
		});
		
	});
	
	$(".deleteAddr").click((e)=>{
		var $tbl = $(e.target).parents(".addr_tbl");
		
		$.ajax({
			url: contextPath+'/member/deleteAddr',
			data: {addressNo : $tbl.find("#addr_id").val()},
			success: (data)=>{
				alert(data.msg);
				location.reload();
			},
			error: (xhr, txtStatus, err)=> {
				console.log("ajax 처리실패!", xhr, txtStatus, err);
			}
		}); 
	});
	
	
	
});	

</script>

<section>
	<article class="subPage inner myPage">
		<div class="addressPage">
		    <jsp:include page="/WEB-INF/views/member/memberNav.jsp" />
		    <div class="address">
		    	<h3 class="sub_tit" style="background-color: white;">주소지 관리</h3>
			    <div class="address_content">
			    	<c:forEach items="${addressList }" var="address" varStatus="vs">
			    		<div class="address-card">
			    				<table class="tbl tbl_view addr_tbl">
			    					<tr>
			    						<td class="sec_bg">
			    							<input type="hidden" id="addr_id" value="${address.ADDRESS_NO }">
			    							<c:if test="${vs.count == 1 }">
						    					기본 주소
						    				</c:if>
						    				<c:if test="${empty address.ADDRESS_NAME && vs.count != 1}">
						    					주소${vs.count }
						    				</c:if>
						    				<c:if test="${not empty address.ADDRESS_NAME}">
						    					${address.ADDRESS_NAME }
						    				</c:if>
			    						</td>
			    					</tr>
			    					<tr class="addr1">
										<td><input type="text" name="address" readonly="readonly" value="${address.MEMBER_ADDRESS }"></td>
									</tr>
									<tr class="addr2">
										<td>
											<input type="text" placeholder="세부주소를 입력해주세요." maxlength="35" name="address2" readonly="readonly" value="${address.MEMBER_ADDRESS2 }">
											<c:if test="${vs.count != 1 }">
												<input type="button" class="btn modifyAddr" value="주소 수정">
												<input type="button" class="btn btn2 deleteAddr" value="삭제">
											</c:if>
										</td>
									</tr>
									<tr>
										<c:if test="${vs.count == 1 }">
											<td class="red">
												기본배송지는 수정 불가합니다.
											</td>
										</c:if>
									</tr>
			    				</table>
			    		</div>
			    	</c:forEach>
			    </div>
			    <p class="address_footer"><input type="button" value="주소 추가" class="btn insertAddr"></p>
	        </div>
        </div>
    </article>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>