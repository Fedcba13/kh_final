<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	.myPage>div{
		display: inline-block;
		vertical-align: top;
		overflow: hidden;
	}
	
	.myPage .myPage-nav {
		width: 150px;
	}
	
	.myPage > div > div:nth-child(2n){
		float: left;
	}
	
	.myPage > div > div:nth-child(2n-1){
		float: right;
	}
</style>

 <div class="myPage-nav">
	<h3 class="sub_tit">마이페이지</h3>
	<ul>
		<li><a href="${pageContext.request.contextPath }/member/myPage">개인정보 수정</a></li>
		<li><a href="${pageContext.request.contextPath }/member/memberAddress">주소지 관리</a></li>
		<li><a href="${pageContext.request.contextPath }/member/myCoupon">쿠폰 관리</a></li>
		<li><a href="${pageContext.request.contextPath }/member/payList">주문내역 확인</a></li>
	</ul>
</div>