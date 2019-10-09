<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>

	.myPage{
		overflow: hiddden;
	}

	.myPage > div{
		display: inline-block;
		vertical-align: top;
		overflow: hidden;
	}
	
	.myPage-nav ul{
		border-top: 2px solid #374818;
	}
	
	.myPage-nav ul li{
		border-bottom: 1px solid #e9e9e9;
		font-size: 14px;
	}
	
	.myPage-nav ul li a{
		padding: 15px 0 15px 15px;
		display: block;
	}
	
	.myPage-nav ul li:hover{
		background-color: #f4f4f0;
	}
	
	.myPage .myPage-nav {
		width: 180px;
		margin-right: 60px;
		float: left;
	}
	
	.myPage .myPage-nav + div{
      width: calc(100% - 240px);
   }
	
	.myPage > div > div:nth-child(2n-1){
		float: left;
	}
	
	.myPage > div > div:nth-child(2n){
		float: right;
	}
</style>

<script>
$(()=>{
	var url = $(location).attr('href').split('/');
	url = url[url.length-1]
	
	if($(".myPage-nav ul li[rel='"+url+"']").length != 0){
		$(".myPage-nav ul li[rel='"+url+"']").css("background", "#f4f4f0");		
	}else{
		$(".myPage-nav ul li[rel=payList]").css("background", "#f4f4f0");
	}
	
	
})
</script>

 <div class="myPage-nav">
	<h3 class="sub_tit">마이페이지</h3>
	<ul>
		<li rel="myPage"><a href="${pageContext.request.contextPath }/member/myPage">개인정보 수정</a></li>
		<li rel="memberAddress"><a href="${pageContext.request.contextPath }/member/memberAddress">주소지 관리</a></li>
		<li rel="myCoupon"><a href="${pageContext.request.contextPath }/member/myCoupon">쿠폰 관리</a></li>
		<li rel="payList"><a href="${pageContext.request.contextPath }/member/payList">주문내역 확인</a></li>
	</ul>
</div>