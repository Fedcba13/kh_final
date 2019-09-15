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

.member_register .good{
	color: #0f851a;
}

.member_register .bad{
	color: #b3130b;
}

.member_register .register_require{
	float:right;
	font-size: 10px;
}

.member_register span{
	display: block;
	font-size: 12px;
	color: #514859;
	line-height: 20px;
}

.member_register tr > td input:nth-child(2n+1):not([type="button"]){
	width: 300px;
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

</style>

<script>
$(()=>{

	$('.txt_guide').hide();
	
	$("input").on('focus', e => {
		$(e.target).siblings(".txt_guide").show();
	});
	
	$('[name=memberId]').on('keyup', function(){
		var $target = $(this).parent().find('.txt_guide');
	});
	
});

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
					html += '<td><input type="text" value=""></td>';
					html += '</tr>';
					html += '<tr class="tbl_addr2">';
					html += '<td><input type="text" value="" placeholder="세부주소를 입력해주세요." maxlength="35">';
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
		}
	}).open({
	    left: (window.screen.width/2) - (width/2),
	    top: (window.screen.height/2) - (height/2)
	});
}

</script>

<section> <!--배경색이 있는 경우만 sec_bg 넣으면 됩니다.-->
	<article class="subPage inner">
		<h3 class="sub_tit txt_center">회원가입</h3>
		<span class="register_require">*필수입력사항</span>
		<table class="tbl tbl_view member_register">
			<tr>
				<th>아이디*</th>
				<td>
					<input type="text" name="memberId" placeholder="예: UrbanTable"><input type="button" class="btn" value="중복확인">
					<p class="txt_guide">
						<span class="txt txt_case1">6자 이상의 영문 혹은 영문과 숫자를 조합</span>
						<span class="txt txt_case2">아이디 중복확인</span>
					</p>
				</td>
				<td></td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td><input type="password" placeholder="비밀번호를 입력해주세요." maxlength="16">
					<p class="txt_guide" style="display: block;">
						<span class="txt txt_case1">10자 이상 입력</span>
						<span class="txt txt_case2">영문/숫자/특수문자(!@#$*-_)만 허용하며, 2개 이상 조합</span>
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
				<td><input type="text" name="name" placeholder="예: 김어반"></td>
			</tr>
			<tr>
				<th rowspan="2">휴대폰*</th>
				<td><input type="text" maxlength="11" placeholder="'-'없이 숫자만 입력해주세요."><input type="button" class="btn" value="인증번호받기"></td>
			</tr>
			<tr>
				<td><input type="text" name="auth_code"><input type="button" class="btn" value="인증번호확인"></td>
			</tr>
			<tr class="tbl_addr">
				<th>배송주소*</th>
				<td><input type="button" value="주소 검색" class="btn" onclick="sample6_execDaumPostcode()"></td>
			</tr>
		</table>
	</article>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>