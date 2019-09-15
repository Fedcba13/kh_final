<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<style>
.login-modal {
	display: none; /* Hidden by default */
	position: fixed; /* Stay in place */
	z-index: 1; /* Sit on top */
	left: 0;
	top: 0;
	width: 100%; /* Full width */
	height: 100%; /* Full height */
	overflow: auto; /* Enable scroll if needed */
	background-color: rgb(0, 0, 0); /* Fallback color */
	background-color: rgba(0, 0, 0, 0.4); /* Black w/ opacity */
	padding-top: 60px;
}
.login-modal .modal-content{
	width: 500px;
	background-color: #fefefe;
	border: 1px solid #888;
	margin: 5% auto 15% auto; /* 5% from the top, 15% from the bottom and centered */
}

.login-modal .container{
	padding: 16px;
	overflow: hidden;
}


/* Full-width input fields */
.login-modal input[type=text], .login-modal input[type=password] {
  width: 100%;
  padding: 12px 20px;
  margin: 8px 0;
  display: inline-block;
  border: 1px solid #ccc;
  box-sizing: border-box;
}

/* 닫기버튼 */
.login-modal .close {
  position: absolute;
  right: 25px;
  top: 0;
  color: #000;
  font-size: 35px;
  font-weight: bold;
}

.login-modal .animate {
  -webkit-animation: animatezoom 0.6s;
  animation: animatezoom 0.6s
}

/* 로그인 버튼 */
.login-modal button.login {
  width: 100%;
  margin: 10px 0px;
}

.login-modal .cancelbtn {
  width: auto;
  padding: 0px 18px;
  background-color: #f44336;
  float: left;
}

.login-modal span.psw {
  float: right;
  padding-top: 16px;
}

.login-modal input[type=checkbox]{
	height:20px;
	vertical-align:text-top;
}

.login-modal input[type=checkbox]+label{
	height:20px;
	vertical-align:-1px;
}

</style>

<script>
	$(()=>{
		
		var modal = $(".login-modal");
		
		$(".login-btn").click(()=>{
			modal.css("display", "block");
		});
		
		//modal창이 열려 있을 경우, 바탕 클릭시 모달 닫기
		$(window).click(function(e){
			if (e.target == modal[0]) {
				modal.css("display", "none");
		    }
		});
		
		//로그인 ajax
		$(".login-modal .login").click(()=>{
			console.log("로그인 클릭");
			var param = {
					memberId : $("input[type=text][name=memberId]").val(),
					password : $("input[type=password][name=password]").val()
			}
			
			$.ajax({
				url: "${pageContext.request.contextPath}/member/memberLogin.do",
				data: param,
				type: "POST",
				success: (data)=>{
					alert(data.msg);
				},
				error: (xhr, txtStatus, err)=>{
					console.log("ajax처리실패!", xhr, txtStatus, err);
				}
			});
		});
		
	});
</script>

<section class="sec_bg">
	<!--배경색이 있는 경우만 sec_bg 넣으면 됩니다.-->
	<article class="subPage inner">
		<h3 class="sub_tit txt_center">로그인 임시</h3>
		<c:if test="${empty memberLoggedIn }">
			<button class="btn login-btn">로그인</button>
		</c:if>

		<c:if test="${not empty memberLoggedIn }">
			<button class="btn logout-btn">로그아웃</button>
		</c:if>
	</article>
</section>

<!-- 로그인 modal용 div -->
<div class="login-modal txt_center">
	<form class="modal-content animate">
		<div class="container txt_center">
			<label for="uname"><b>Username</b></label>
			<input type="text" placeholder="Enter Username" name="memberId" required>
			<label for="psw"><b>Password</b></label>
			<input type="password" placeholder="Enter Password" name="password" required>
			<button type="button" class="btn login">Login</button>
			<input type="checkbox" checked="checked" name="remember" id="saveID">
			<label for="saveID">Remember me</label>
		</div>
		<div class="container txt_center" style="background-color:#f4f4f0">
	      <button type="button" class="btn cancelbtn">Cancel</button>
	      <span class="psw">Forgot <a href="#">password?</a></span>
	    </div>
	</form>
</div>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>