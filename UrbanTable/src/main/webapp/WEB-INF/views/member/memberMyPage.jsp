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
.myPage>div{
	display: inline-block;
	vertical-align: top;
}

.myPage .myPage-nav {
	width: 200px;
}

.myPage .good{
color: #0f851a;
}

.myPage .bad{
	color: #b3130b;
}

.member_mypage tr > td input:not([type="button"]){
	width: 300px;
	margin-right: 15px;
}

.myPage span{
	display: block;
	font-size: 12px;
	color: #514859;
	line-height: 20px;
}

.myPage tr th{
	vertical-align: top;
	padding-top: 20px;
}

.myPage .txt_guide{
	padding-top: 10px;
}

.myPage .disabled{
	border: 1px solid #dddfe1;
    background-color: #fff;
    color: #dddfe1;
    cursor: default;
}

.myPage input[type="text"].disabled{
	color: #555;
}

</style>

<script>
$(()=>{
	$('.txt_guide').hide();
	
	$("input").on('focus', e => {
		$(e.target).siblings(".txt_guide").show();
	});
	
	//비밀번호 유효성 검사
	function password_case1(){
		
		$("[name=reMemberPassword]").siblings(".txt_guide").children('.txt_case1').removeClass('good');
		$("[name=reMemberPassword]").siblings(".txt_guide").children('.txt_case1').addClass('bad');
		
		var password = $("[name=reMemberPassword]").val();
		var rep = /^[a-zA-Z0-9!@#$*-]{10,}$/;
		
		if(rep.test(password)){
			$("[name=reMemberPassword]").siblings(".txt_guide").children('.txt_case1').addClass('good');
			$("[name=reMemberPassword]").siblings(".txt_guide").children('.txt_case1').removeClass('bad');
		}
		
	}
	
	function password_case2(){
		$("[name=reMemberPassword]").siblings(".txt_guide").children('.txt_case2').removeClass('good');
		$("[name=reMemberPassword]").siblings(".txt_guide").children('.txt_case2').addClass('bad');
		
		var password = $("[name=reMemberPassword]").val();
		var rep1 = /^[a-zA-Z]*$/;
		var rep2 = /^[0-9]*$/;
		var rep3 = /^[!@#$*-]*$/;
		
		if(!(rep1.test(password) || rep2.test(password) || rep3.test(password))){
			$("[name=reMemberPassword]").siblings(".txt_guide").children('.txt_case2').addClass('good');
			$("[name=reMemberPassword]").siblings(".txt_guide").children('.txt_case2').removeClass('bad');
		}
		
	}
	
	$("[name=reMemberPassword]").keyup(()=>{
		password_case1();
		password_case2();
		rePassword_case1();
	})
	
	//비밀번호 확인 유효성 검사
	function rePassword_case1(){
		
		$("[name=password2]").siblings(".txt_guide").children('.txt_case1').removeClass('good');
		$("[name=password2]").siblings(".txt_guide").children('.txt_case1').addClass('bad');
		
		var password = $("[name=reMemberPassword]").val();
		var rePassword = $("[name=password2]").val();
		
		if(password == rePassword && password != ''){
			$("[name=password2]").siblings(".txt_guide").children('.txt_case1').addClass('good');
			$("[name=password2]").siblings(".txt_guide").children('.txt_case1').removeClass('bad');
		}
		
	}
	
	$("[name=password2]").keyup(()=>{
		rePassword_case1();
	});
	
	//수정하기 버튼
	$(".myPage .modify-btn").click(()=>{
		var $case = $(".txt_guide").children('.txt');

		if($("[name=reMemberPassword]").val().length != 0 
				&$ ("[name=memberPassword]").val().length == 0){
			alert('비밀번호를 입력해주세요.')
			$("[name=memberPassword]").focus();
			return;
		}
		
		for(var i=0; i<$case.length; i++){
			if($($case[i]).parent().siblings('input:not(.btn)').val().length != 0 
					&& !$($case[i]).hasClass('good')){
				alert($($case[i]).text());
				$($case[i]).parent().siblings('input:not(.btn)').focus();
				return;
			}
		}
		
		//주소
		if($("[name=memberAddress]").length == 0 || $("[name=memberAddress]").val() == ''){
			alert('주소를 입력해주세요.');
			return;
		}
		
		$("#form_myPage").submit();
		
		
	});
	
	//취소하기 버튼
	$(".myPage .cancel-btn").click(()=>{
		location.reload();
	});
	
	
});

</script>

<section>
	<article class="subPage inner myPage">
	    <div class="myPage-nav">
	    <h3 class="sub_tit">마이페이지</h3>
	    	<ul>
	    		<li>개인정보 수정</li>
	    		<li>주소지 관리</li>
	    		<li>쿠폰 관리</li>
	    		<li>주문내역 확인</li>
	    	</ul>
	    </div>
	    <div class="sec_bg">
	    	<h3 class="sub_tit" style="background-color: white;">개인정보수정</h3>
	    	<form action="${pageContext.request.contextPath}/member/myPage.do" method="post" id="form_myPage">
			    <table class="tbl tbl_view member_mypage">
					<tr>
						<th>아이디</th>
						<td>
							<input type="text" name="memberId" placeholder="예: UrbanTable" readonly="readonly" value="${memberLoggedIn.memberId }">
						</td>
					</tr>
					<tr>
						<th>현재 비밀번호</th>
						<td><input type="password" placeholder="현재 비밀번호를 입력해주세요." maxlength="16" name="memberPassword"></td>
					</tr>
					<tr>
						<th>변경하실 비밀번호</th>
						<td><input type="password" placeholder="변경하실 비밀번호를 입력해주세요." maxlength="16" name="reMemberPassword">
							<p class="txt_guide" style="display: block;">
								<span class="txt txt_case1">10자 이상 입력해주세요.</span>
								<span class="txt txt_case2">영문/숫자/특수문자(!@#$*-)만 허용하며, 2개 이상 조합해 주세요.</span>
							</p>
						</td>
					</tr>
					<tr>
						<th>비밀번호확인</th>
						<td>
							<input type="password" name="password2" maxlength="16" placeholder="비밀번호를 한번 더 입력해주세요.">
							<p class="txt_guide">
								<span class="txt txt_case1">동일한 비밀번호를 입력해주세요.</span>
							</p>
						</td>
					</tr>
					<tr>
						<th>이름</th>
						<td><input type="text" name="memberName" readonly="readonly" value="${memberLoggedIn.memberName }"></td>
					</tr>
					<tr>
						<th>휴대폰</th>
						<td><input type="text" name="memberPhone" maxlength="11" readonly="readonly" value="${memberLoggedIn.memberPhone }"></td>
					</tr>
					<tr class="tbl_addr">
						<th rowspan="3">배송주소</th>
						<td><input type="button" value="주소 변경" class="btn btn3" onclick="sample6_execDaumPostcode()"></td>
					</tr>
					<tr class="tbl_addr1">
						<td><input type="text" name="memberAddress" readonly="readonly" value="${memberLoggedIn.memberAddress }"></td>
					</tr>
					<tr class="tbl_addr2">
						<td><input type="text" placeholder="세부주소를 입력해주세요." maxlength="35" name="memberAddress2" value="${memberLoggedIn.memberAddress2 }"></td>
					</tr>
				</table>
			</form>
			<p style="text-align: center; margin: 30px 0 20px;">
				<input type="button" class="btn modify-btn" value="수정하기" style="margin-right: 50px;">
        		<input type="button" class="btn btn2 cancel-btn" value="취소하기">
        	</p>
        </div>
    </article>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>