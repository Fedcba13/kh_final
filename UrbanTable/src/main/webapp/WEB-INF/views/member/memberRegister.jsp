<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<style>

.sub_tit+span{
	float: right;
}

.register_form{
    margin: 0 auto;
    width: 640px;
}

.member_register .good{
	color: #0f851a;
}

.member_register .bad{
	color: #b3130b;
}

.register_require{
	text-align: right;
	font-size: 11px;
}

.member_register span{
	display: block;
	font-size: 12px;
	color: #514859;
	line-height: 20px;
}


/* input[type=text] 사이즈  */
.member_register tr > td input:not([type="button"]){
	width: 300px;
	margin-right: 15px;
}

/* input[type=text] 뒤에 버튼 사이즈 변경*/
.member_register tr > td input[type="text"] + [type="button"], #checkMsg{
	width: 100px;
	margin-right: 15px;
}

.member_register tr th{
	vertical-align: top;
	padding-top: 20px;
}

.member_register .txt_guide{
	padding-top: 10px;
}

.member_register .tbl_addr2 p{
	padding-top: 10px;
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

.member_register .disabled{
	border: 1px solid #dddfe1;
    background-color: #fff;
    color: #dddfe1;
    cursor: default;
}

.member_register input[type="text"].disabled{
	color: #555;
}

</style>

<script>

var time = 180;
var timer = null;

$(()=>{
	
	disabled($("[name=auth_code]"));
	disabled($("#checkMsg"));

    $('.txt_guide').hide();
    
    $("input").on('focus', e => {
		$(e.target).siblings(".txt_guide").show();
	});
	
    $("[name=memberId]:eq(1)").on('keyup', function(){
		var $target = $(this).parent().find('.txt_guide');
	});
	
	//sendMSg => 인증번호 받기
	$("#sendMsg").click(()=>{
		var phone = $("[name=memberPhone]").val();
		if(phone.length < 8){
			alert('핸드폰 번호를 입력하세요,');
			$("[name=memberPhone]").focus();
			return;
		}
		time = 180;
		$.ajax({
			url: "${pageContext.request.contextPath}/member/sendMessage.do",
			data: {phone: phone},
			success: (data)=>{
				alert(data.msg);
				if(data.msg == '인증번호 발송 성공!'){
					$("[name=memberPhone]").css
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
			authCode: $("[name=auth_code]").val()
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
	
	//아이디 중복 검사
	$("#checkId").click(()=>{
		$.ajax({
			url: "${pageContext.request.contextPath}/member/checkIdDuplicate.do",
			data: {memberId : $("[name=memberId]:eq(1)").val()},
			success: (data)=>{
				if(data.isUsable == true){
					$("[name=memberId]").siblings(".txt_guide").children('.txt_case2').removeClass('bad');
					$("[name=memberId]").siblings(".txt_guide").children('.txt_case2').addClass('good');
					alert('사용 가능합니다.');
				}else{
					alert('사용 불가능합니다.');
				}
			},
			error: (xhr, txtStatus, err)=>{
				console.log("ajax처리실패!", xhr, txtStatus, err);
			}
		});
	})
	
	//아이디 유효성 검사
	function memberId_case1(){
		
		$("[name=memberId]").siblings(".txt_guide").children('.txt_case1').removeClass('good');
		$("[name=memberId]").siblings(".txt_guide").children('.txt_case1').addClass('bad');
		
		var rep1 = /^[a-z][a-z0-9]{5,11}$/;
		var memberId = $("[name=memberId]:eq(1)").val();
		
		if(rep1.test(memberId)){
			$("[name=memberId]").siblings(".txt_guide").children('.txt_case1').addClass('good');
			$("[name=memberId]").siblings(".txt_guide").children('.txt_case1').removeClass('bad');
		}
	}
	
	//아이디 유효성 검사
	$("[name=memberId]").keyup(()=>{
		memberId_case1();
		$("[name=memberId]").siblings(".txt_guide").children('.txt_case2').removeClass('good');
		$("[name=memberId]").siblings(".txt_guide").children('.txt_case2').addClass('bad');
	});
	
	//비밀번호 유효성 검사
	function password_case1(){
		
		$("[name=memberPassword]").siblings(".txt_guide").children('.txt_case1').removeClass('good');
		$("[name=memberPassword]").siblings(".txt_guide").children('.txt_case1').addClass('bad');
		
		var password = $("[name=memberPassword]").val();
		var rep = /^[a-zA-Z0-9!@#$*-]{10,}$/;
		
		if(rep.test(password)){
			$("[name=memberPassword]").siblings(".txt_guide").children('.txt_case1').addClass('good');
			$("[name=memberPassword]").siblings(".txt_guide").children('.txt_case1').removeClass('bad');
		}
		
	}
	
	function password_case2(){
		$("[name=memberPassword]").siblings(".txt_guide").children('.txt_case2').removeClass('good');
		$("[name=memberPassword]").siblings(".txt_guide").children('.txt_case2').addClass('bad');
		
		var password = $("[name=memberPassword]").val();
		var rep1 = /^[a-zA-Z]*$/;
		var rep2 = /^[0-9]*$/;
		var rep3 = /^[!@#$*-]*$/;
		
		if(!(rep1.test(password) || rep2.test(password) || rep3.test(password))){
			$("[name=memberPassword]").siblings(".txt_guide").children('.txt_case2').addClass('good');
			$("[name=memberPassword]").siblings(".txt_guide").children('.txt_case2').removeClass('bad');
		}
		
	}
	
	$("[name=memberPassword]").keyup(()=>{
		password_case1();
		password_case2();
		rePassword_case1();
	})
	
	//비밀번호 확인 유효성 검사
	function rePassword_case1(){
		
		$("[name=password2]").siblings(".txt_guide").children('.txt_case1').removeClass('good');
		$("[name=password2]").siblings(".txt_guide").children('.txt_case1').addClass('bad');
		
		var password = $("[name=memberPassword]").val();
		var rePassword = $("[name=password2]").val();
		
		if(password == rePassword && password != ''){
			$("[name=password2]").siblings(".txt_guide").children('.txt_case1').addClass('good');
			$("[name=password2]").siblings(".txt_guide").children('.txt_case1').removeClass('bad');
		}
		
	}
	
	$("[name=password2]").keyup(()=>{
		rePassword_case1();
	});
	
	//회원가입 버튼
	$("#register_btn").click(()=>{
		
		var $case = $(".txt_guide").children('.txt');
		
		//아이디, 비밀번호, 비밀번호확인
		for(var i=0; i<$case.length; i++){
			if(!$($case[i]).hasClass('good')){
				alert($($case[i]).text());
				$($case[i]).parent().siblings('input:not(.btn)').focus();
				return;
			}
		}
		
		//이름
		if($("[name=memberName]").val() == ''){
			$("[name=memberName]").focus();
			alert('이름을 입력해주세요.');
			return;
		} 
		
		//휴대폰
		if($("[name=memberPhone]").val() == ''){
			$("[name=memberPhone]").focus();
			alert('핸드폰 번호를 입력해주세요.');
			return;
		}
		
		if(!$("#time").hasClass('good') || $("#time").html() != '인증 성공'){
			alert('핸드폰 인증을 진행해주세요.');
			return;
		}
		
		//주소
		if($("[name=memberAddress]").length == 0 || $("[name=memberAddress]").val() == ''){
			alert('주소를 입력해주세요.');
			return;
		}
		
		//disabled 는 값 전송이 안되므로 disabled 속성 제거
		use($("[name=memberPhone]"));
		
		$("#form_register").submit();
		
	});
	
	
});

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

function disabled($input){
	$input.attr('disabled', true);
	$input.addClass('disabled');
	
}

function use($input){
	$input.attr('disabled', false);
	$input.removeClass('disabled');
	
	console.log($input.attr('type'));
}

//카카오 주소찾기 api
function sample6_execDaumPostcode() {
	
	var width = 500; //팝업의 너비
	var height = 600; //팝업의 높이
	
	new daum.Postcode({
		oncomplete: function(data) {
			// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

			// 각 주소의 노출 규칙에 따라 주소를 조합한다.
			// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
			var addr = ''; // 주소 변수
			var extraAddr = ''; // 참고항목 변수

			//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
			if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
				addr = data.roadAddress;
			} else { // 사용자가 지번 주소를 선택했을 경우(J)
				addr = data.jibunAddress;
			}
			
			//table 속성을 추가한다.
			$(".tbl_addr>th").attr("rowspan", "3");
			if($(".tbl_addr1").length == 0){
				var html = '';
					html += '<tr class="tbl_addr1">';
					html += '<td><input type="text" value="" name="memberAddress"></td>';
					html += '</tr>';
					html += '<tr class="tbl_addr2">';
					html += '<td><input type="text" value="" placeholder="세부주소를 입력해주세요." maxlength="35" name="memberAddress2">';
					html += '<p>';
					html += '<span class="txt"></span>';
					html += '</p>';
					html += '</td>';
					html += '</tr>';
				$(".member_register").append(html);
			}
			
			//주소 정보를 해당 필드에 넣는다.
			$(".tbl_addr1 input").val(addr);
			
			// 커서를 상세주소 필드로 이동한다.
			$(".tbl_addr2 input").focus();
			
			$.ajax({
				url: "${pageContext.request.contextPath}/member/nearMarket.do",
				data : {address: $("[name=memberAddress]").val()},
				success: (data)=>{
					alert(data.msg);
				},
				error: (xhr, txtStatus, err)=>{
					console.log("ajax처리실패!", xhr, txtStatus, err);
				}
			});
		}
	}).open({
	    left: (window.screen.width/2) - (width/2),
	    top: (window.screen.height/2) - (height/2)
	});
}

//가까운 매장 거리 확인 후 배송 가능 리턴
function nearMarket(){
	$.ajax({
		url: "${pageContext.request.contextPath}/member/nearMarket.do",
		data: param,
		success: (data)=>{
			alert(data.msg);
		},
		error: (xhr, txtStatus, err)=>{
			console.log("ajax처리실패!", xhr, txtStatus, err);
		}
	});
}

</script>

<section> <!--배경색이 있는 경우만 sec_bg 넣으면 됩니다.-->
	<article class="subPage inner">
		<h3 class="sub_tit txt_center">회원가입</h3>
		<div class='register_form'>
			<p class="register_require">*필수입력사항</p>
			<form action="${pageContext.request.contextPath}/member/register.do" method="post" id="form_register">
				<table class="tbl tbl_view member_register">
					<tr>
						<th>아이디*</th>
						<td>
							<input type="text" name="memberId" placeholder="예: UrbanTable"><input type="button" id="checkId" class="btn" value="중복확인">
							<p class="txt_guide">
								<span class="txt txt_case1">6자 이상의 영문 혹은 영문과 숫자를 조합해주세요.</span>
								<span class="txt txt_case2">아이디 중복확인해주세요.</span>
							</p>
						</td>
						<td></td>
					</tr>
					<tr>
						<th>비밀번호</th>
						<td><input type="password" placeholder="비밀번호를 입력해주세요." maxlength="16" name="memberPassword">
							<p class="txt_guide" style="display: block;">
								<span class="txt txt_case1">10자 이상 입력해주세요.</span>
								<span class="txt txt_case2">영문/숫자/특수문자(!@#$*-)만 허용하며, 2개 이상 조합해 주세요.</span>
							</p>
						</td>
					</tr>
					<tr>
						<th>비밀번호확인*</th>
						<td colspan="2">
							<input type="password" name="password2" maxlength="16" placeholder="비밀번호를 한번 더 입력해주세요.">
							<p class="txt_guide">
								<span class="txt txt_case1">동일한 비밀번호를 입력해주세요.</span>
							</p>
						</td>
					</tr>
					<tr>
						<th>이름*</th>
						<td><input type="text" name="memberName" placeholder="예: 김어반"></td>
					</tr>
					<tr>
						<th rowspan="2">휴대폰*</th>
						<td><input type="text" name="memberPhone" maxlength="11" placeholder="'-'없이 숫자만 입력해주세요."><input type="button" class="btn" id="sendMsg" value="인증번호받기"></td>
					</tr>
					<tr>
						<td><div class="auth"><input type="text" name="auth_code" maxlength="6"><span class="auth" id="time"></span></div><input type="button" class="btn" id="checkMsg" value="인증번호확인"></td>
					</tr>
					<tr class="tbl_addr">
						<th>배송주소*</th>
						<td><input type="button" value="주소 검색" class="btn" onclick="sample6_execDaumPostcode()"></td>
					</tr>
				</table>
				<input type="button" class="btn" value="회원가입" id="register_btn">
			</form>
		</div>
	</article>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>