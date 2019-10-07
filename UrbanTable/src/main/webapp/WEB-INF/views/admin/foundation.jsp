<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<script>
	function approval(memberId, no) {

		var bool = confirm("승인하시겠습니까");
		var marketName = $("#marketName" + no).val();
		var marketResident = $("#marketResident" + no).val();

		if (!bool) {
			return false;
		}

		location.href = "${pageContext.request.contextPath}/admin/updateMarket.do?memberId="
				+ memberId
				+ "&marketName="
				+ marketName
				+ "&marketResident="
				+ marketResident;
		return true;
	}

	function refuse(memberId) {
		var bool = confirm("승인 거절하시겠습니까");

		if (!bool) {
			return false;
		}

		location.href = "${pageContext.request.contextPath}/admin/refuseMarket.do?memberId="
				+ memberId;

	}
	
	$(()=>{
	
		$(".choise").on("change", function(e){
			var param = $(e.target).val();
				
			
			$.ajax({
				url:"${pageContext.request.contextPath}/admin/selectListBychoise.do",
				data:{param:param},
				success: (data)=>{
						console.log(data);
  					var html = "<table class='tbl txt_center'>";
	                html+="<tr class='sec_bg'><th>아이디</th><th>점주명</th><th>지점명</th><th style='width: 150px;'>등록번호</th><th style='width: 200px;'>매장주소</th><th>연락처</th><th> </th></tr>"; 
	                for(var i in data){
	                	
	                 	console.log(data.memberId); 
	                     html += "<tr><td>"+data[i].memberId+"</td>";
	                    html += "<td>"+data[i].member.memberName+"</td>";
	                    if(data[i].marketName == null){
	                    	html += "<td>" + "<input type='text' id='marketName"+i+"' style='width: 100px;' /></td>";
	                    }else{
	                    	html += "<td>"+data[i].marketName+"</td>";	                    	
	                    }
	                    if(data[i].marketResident == null){
	                    	html += "<td>" + "<input type='text' id='marketResident"+i+"' style='width: 150px;' /></td>";
	                    }else{	                    	
	                    	html += "<td>"+data[i].marketResident+"</td>";	                    	
	                    }
	                    html += "<td>"+data[i].marketAddress + "&nbsp;"+data[i].marketAddress2 +"</td>";
	                    html += "<td>"+data[i].marketTelephone+"</td>";
	                    if(data[i].flag == 0){	                    	
	                    	html += "<td><input type='button' value='승인' class='btn txt_center button' onclick='approval(\""+data[i].memberId+"\",\""+i+"\") ' /> &nbsp;";
	                    	html += "<input	type='button' value='삭제' class='btn btn2 txt_center button'	onclick='refuse('data[i].memberId')' /></td></tr>";
	                    } else{
	                    	html += "<td style='width:140px;'></td>";
	                    }
	                  	html += "</tr>"; 
	                }
	                html+="</table>";
	                $(".marketList").html(html); 
				},
				error: (xhr, txtStatus, err)=>{
					console.log("ajax 처리 실패", xhr, txtStatus, err);
				}
			});
		});
		
	})
	

</script>
<style>
input.button{
	width:70px;
}
</style>
<sections>
	<article class="subPage inner">

		<h3 class="sub_tit">창업 신청</h3>

		<div class="txt_right choise">
			<input type="radio" name="choise" id="all" value="3" checked/>
			<label for="all">전체보기</label>
			<input type="radio" name="choise" id="notYet" value="1"/>
			<label for="notYet">공사중</label>
			<input type="radio" name="choise" id="open" value="2"/>
			<label for="open">오픈완료</label>
			<input type="radio" name="choise" id="noApproval" value="0"/>
			<label for="noApproval">비승인</label>
		</div>
		<div class="marketList">
		<table class="tbl txt_center">
			<tr class="sec_bg">
				<th>신청 아이디</th>
				<th>점주명</th>
				<th >지점명</th>
				<th>매장 등록번호</th>
				<th style="width: 200px;">매장 주소</th>
				<th>연락처</th>
				<th></th>
			</tr>
			<c:forEach items="${list }" var="m" varStatus="vs">
				<tr>
					<td>${m.memberId}</td>
					<td style="width: 70px;">${m.member.memberName}</td>
					<c:if test="${m.marketName != null}">
						<td id="marketName${vs.index }">${m.marketName }</td>
					</c:if>
					<c:if test="${m.marketName == null}">
						<td><input type="text" id="marketName${vs.index }"
							style="width: 100px;" /></td>
					</c:if>
					<c:if test="${m.marketResident != null}">
						<td style="width: 150px;" id="marketResident${vs.index }">${m.marketResident }</td>
					</c:if>
					<c:if test="${m.marketResident == null }">
						<td><input type="text" id="marketResident${vs.index }"
							style="width: 150px;" /></td>
					</c:if>
					<td>${m.marketAddress} &nbsp;${m.marketAddress2}
					</td>
					<td>${m.marketTelephone}</td>
					<c:if test="${m.flag == 0 or m.marketName == null or m.marketResident == null }">
						<td class="app"><input type="button" value="승인" class="btn txt_center button" onclick="approval('${m.memberId}', '${vs.index}') " />
							 <input	type="button" value="삭제" class="btn btn2 txt_center button"	onclick="refuse('${m.memberId}')" />
						</td>
					</c:if>
					<c:if test="${m.flag == 1 or m.flag == 2 }">
						<td></td>
					</c:if>
				</tr>
			</c:forEach>
		</table>
		</div>
		
 
	</article>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>