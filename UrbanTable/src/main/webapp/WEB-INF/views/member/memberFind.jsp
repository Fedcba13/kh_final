<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<style>
	.memberFind nav{
		border-bottom: 2px solid #374818;
		display: block;
		margin-bottom: 30px;
	}
	
	.tab{
		text-align: center;
	}
	
	.memberFind ul{
		display: block;
	}
	
	.memberFind ul:after {
		content:'';
		display:block;
		clear:both;
	}
	
	.memberFind ul li{
		float: left;
	}
	
	.memberFind ul li a{
		display: block;
	}
	
	.memberFind .active{
		position: relative;
	    width: 168px;
	    margin-bottom: -2px;
	    padding-top: 9px;
	    padding-bottom: 13px;
	    border-width: 2px 2px 0 2px;
	    border-style: solid;
	    border-color: #374818;
	    background-color: #fff;
	    color: #000;
	}
	
	.memberFind .active:after {
		content:'';
		display:block;
		position:absolute;
		bottom:-1px;
		width:100%;
		height:2px;
		background:#fff;
	}
	
	.memberFind .inactive{
		display: block;
	    width: 170px;
	    padding-top: 10px;
	    padding-bottom: 11px;
	    border-width: 1px 1px 0 1px;
	    border-style: solid;
	    border-color: #d6d6d6;
	    background-color: #f8f8f8;
	    color: #777;
	    font-size: 14px;
	    text-align: center;
	    text-decoration: none;
	}
	
	.memberFind tr > td input:not([type="button"]){
	    width: 300px;
    	margin-right: 15px;
	}
	
	.memberFind table.tbl{
		border-top: 2px solid #969696;
	}
	
	.memberFind .disabled{
		border: 1px solid #dddfe1;
	    background-color: #fff;
	    color: #dddfe1;
	    cursor: default;
	}
	
	div.auth{
		display: inline-block;
		position: relative;
	}
	
	span.auth{
		position: absolute;
		top: 0px;
		right: 0px;
		padding-right: 30px;
		height: 40px;
	    line-height: 40px;
	}
	
</style>

<script>

var time = 180;
var timer = null;

	$(()=>{
		var type = '${type}';
		var flag = type == 'id' ? 2 : 3;
		
		if(type == 'id'){
			$(".memberFind .tab .id").addClass('active');
			$(".memberFind .tab .pw").addClass('inactive');
		}else if(type == 'pw'){
			$(".memberFind .tab .id").addClass('inactive');
			$(".memberFind .tab .pw").addClass('active');
		}else{
			alert('잘못된 경로 입니다.');
			location.href = '${pageContext.request.contextPath}';
		}
		
		disabled($("[name=auth_code]"));
		disabled($("#checkMsg"));
		
		//sendMSg => 인증번호 받기
		$("#sendMsg").click(()=>{
			var phone = $("[name=memberPhone]").val();
			
			console.log(phone);
			
			if(phone.length < 8){
				alert('핸드폰 번호를 입력하세요,');
				$("[name=memberPhone]").focus();
				return;
			}
			time = 180;
			$.ajax({
				url: "${pageContext.request.contextPath}/member/sendMessage.do",
				data: {phone: phone, flag: flag},
				success: (data)=>{
					alert(data.msg);
					if(data.msg == '인증번호 발송 성공!'){
						timer = setInterval(PrintTime, 1000);
						use($("[name=auth_code]"));
						use($("#checkMsg"));
						disabled($("[name=memberPhone]"));
						disabled($("#sendMsg"));
					}
				},
				error: (xhr, txtStatus, err)=>{
					console.log("ajax처리실패!", xhr, txtStatus, err);
				}
			});
		});
		
		//checkMsg => 인증번호 확인
		$("#checkMsg").click(()=>{
			var param = {
				phone : $("[name=memberPhone]").val(),
				authCode: $("[name=auth_code]").val(),
				flag : flag
			}
			$.ajax({
				url: "${pageContext.request.contextPath}/member/checkMessage.do",
				data: param,
				success: (data)=>{
					alert(data.msg);
					if(data.msg == '인증 성공'){
						clearInterval(timer);
						disabled($("[name=auth_code]"));
						disabled($("#checkMsg"));
						$("#time").html('인증 성공');
						$('#time').removeClass('bad');
						$("#time").addClass('good');
					}
				},
				error: (xhr, txtStatus, err)=>{
					console.log("ajax처리실패!", xhr, txtStatus, err);
				}
			});
		});
		
	});
	
	function disabled($input){
		$input.attr('readonly', true);
		$input.addClass('disabled');
		
	}

	function use($input){
		$input.attr('readonly', false);
		$input.removeClass('disabled');
	}
	
	// 비밀번호 인증 제한시간.
	function PrintTime() {
		
		time = time - 1;
		
		var min = parseInt(time / 60);
		var sec = time - (min*60);
		
		if(min.length < 2){
			min = "0" + min;
		}
		
		if(sec.length <2){
			sec = "0" + sec;
		}
		
	    
	    $("#time").html(min +":" + sec);
	    $('#time').removeClass('good');
	    $('#time').addClass('bad');
	    
	    if(time <= 0){
	    	$("#time").html('시간 종료');
	    	clearInterval(timer);
	    	
	    	disabled($("[name=auth_code]"));
	    	disabled($("#checkMsg"));
			use($("[name=memberPhone]"));
			use($("#sendMsg"));
	    }

	}
	
</script>

<section> <!--배경색이 있는 경우만 sec_bg 넣으면 됩니다.-->
	<article class="subPage inner memberFind">
		<nav>
			<ul>
				<li class='tab'><a class='id' href="${pageContext.request.contextPath }/member/memberFind/id">아이디찾기</a></li>
				<li class='tab'><a class='pw' href="${pageContext.request.contextPath }/member/memberFind/pw">비밀번호찾기</a></li>
			</ul>
		</nav>
		<c:if test="${empty type || type == 'id' }">
			<div>
		    <h3 class="sub_tit">아이디 찾기</h3>
				<form id="findIdFrm">
					<table class="tbl tbl_view memberFind">
						<tr>
							<th>이름</th>
							<td><input type="text" name="memberName" placeholder="예: 김어반"></td>
						</tr>
						<tr>
							<th rowspan="2">휴대폰</th>
							<td><input type="text" name="memberPhone" maxlength="11" placeholder="'-'없이 숫자만 입력해주세요."><input type="button" class="btn" id="sendMsg" value="인증번호받기"></td>
						</tr>
						<tr>
							<td><div class="auth"><input type="text" name="auth_code" maxlength="6"><span class="auth" id="time"></span></div><input type="button" class="btn" id="checkMsg" value="인증번호확인"></td>
						</tr>
					</table>
					<input type="button" id="findIdBtn" value="아이디 찾기" class="btn">
				</form>
			</div>
		</c:if>
		<c:if test="${not empty type && type == 'pw' }">
			<div>
		    <h3 class="sub_tit">비밀번호 찾기</h3>
				<form id="findPwFrm">
					<table class="tbl tbl_view memberFind">
						<tr>
							<th>이름</th>
							<td><input type="text" name="memberName" placeholder="예: 김어반"></td>
						</tr>
						<tr>
							<th>아이디</th>
							<td>
								<input type="text" name="memberId" placeholder="예: UrbanTable">
							</td>
							<td></td>
						</tr>
						<tr>
							<th rowspan="2">휴대폰</th>
							<td><input type="text" name="memberPhone" maxlength="11" placeholder="'-'없이 숫자만 입력해주세요."><input type="button" class="btn" id="sendMsg" value="인증번호받기"></td>
						</tr>
						<tr>
							<td><div class="auth"><input type="text" name="auth_code" maxlength="6"><span class="auth" id="time"></span></div><input type="button" class="btn" id="checkMsg" value="인증번호확인"></td>
						</tr>
					</table>
					<input type="button" id="findPwBtn" value="비밀번호 찾기" class="btn">
				</form>
			</div>
		</c:if>
    </article>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>