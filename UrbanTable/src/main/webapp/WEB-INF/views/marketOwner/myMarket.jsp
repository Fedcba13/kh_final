<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/marketOwner.css">
<script>
	$(()=>{
		$("#myMarketUpdate").on("click", function(){
			var param = {
				marketNo : "${market.marketNo}",
				marketTelephone : $("#marketTelephone").val()
			};
			
			console.log(param);
			
			$.ajax({
				url: "${pageContext.request.contextPath}/market/myMarketUpdate.do",
				data: param,
				dataType: "json",
				type: "POST",
				success: function(data){
					alert(data.result);
				},
				error: function(xhr, txtStatus, err){
					console.log("ajax 처리 실패", xhr, txtStatus, err);
				}
			});
		});
		
		$("#myMarketOpen").on("click", function(){
			var param = {
				marketNo : "${market.marketNo}"
			};
			
			console.log(param);
			
			$.ajax({
				url: "${pageContext.request.contextPath}/market/myMarketOpen.do",
				data: param,
				dataType: "json",
				type: "POST",
				success: function(data){
					alert(data.result);
					location.reload();
				},
				error: function(xhr, txtStatus, err){
					console.log("ajax 처리 실패", xhr, txtStatus, err);
				}
			});
		});
	});
</script>
<section>
	<article class="subPage inner">
	    <h3 class="sub_tit">내 지점 관리</h3>
        <table class="tbl tbl_view">
            <tr>
                <th>지점명</th>
                <td><input type="text" name="marketName" id="marketName" value="${market.marketName}" readonly required class="dp_block" required style="width:200px;" /></td>
            </tr>
            <tr>
                <th>지점장</th>
                <td><input type="text" name="marketMemberName" id="marketMemberName" value="${market.member.memberName}" readonly required class="dp_block" style="width:200px;" /></td>
            </tr>
            <tr>
                <th>지점 주소</th>
                <td>
                	<input type="text" id="marketAddress" name="marketAddress" value="${market.marketAddress}" placeholder="주소" required readonly>
					<input type="text" id="marketAddress2" name="marketAddress2" placeholder="상세주소" value="${market.marketAddress2}" required readonly>
                </td>
            </tr>
            <tr>
                <th>지점 전화번호</th>
                <td>
                	<input type="text" name="marketTelephone" id="marketTelephone" value="${market.marketTelephone }" class="dp_block" style="width:200px;" />
                </td>
            </tr>
            <tr>
            	<th>지점 휴일</th>
            	<td></td>
            </tr>
            <tr>
            	<th>사업자 등록번호</th>
            	<td><input type="text" name="marketResident" id="marketResident" value="${market.marketResident }" class="dp_block" readonly style="width:200px;" /></td>
            </tr>
            <tr>
            	<th>지점 오픈여부</th>
            	<td>
            		<c:if test="${market.flag eq 1 }">
            			오픈 대기중
            		</c:if>
            		<c:if test="${market.flag eq 2 }">
            			오픈
            		</c:if>
            	</td>
            </tr>
        </table>
        <div class="founded_btn txt_center">
        	<button id="myMarketUpdate" class="btn">지점 정보 수정</button>
        	<c:if test="${market.flag eq 1 }">
       			<button id="myMarketOpen" class="btn btn2">지점 오픈하기</button>
       		</c:if>
        </div>
    </article>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>