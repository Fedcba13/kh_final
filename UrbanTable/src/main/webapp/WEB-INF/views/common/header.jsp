<%@page import="com.kh.urbantable.food.model.vo.FoodUpper"%>
<%@page import="com.kh.urbantable.food.model.vo.FoodSection"%>
<%@page import="com.kh.urbantable.food.model.service.FoodServiceImpl"%>
<%@page import="com.kh.urbantable.food.model.vo.FoodDivision"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Urban Table</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/default.css">
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/gh/moonspam/NanumBarunGothic@1.0/nanumbarungothicsubset.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/slick.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/slick-theme.css"/>
    <script>
    	var contextPath = "${pageContext.request.contextPath}";
    </script>
    <script type="text/javascript" src="http://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/slick.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/common.js" charset="UTF-8"></script>
</head>
<body>
    <header id="header">
        <div id="util_wrap">
            <ul>
                <c:if test="${empty memberLoggedIn }">                
                	<li><a href="#" class="dp_block login-btn">로그인</a></li>
                	<li><a href="${pageContext.request.contextPath }/member/register" class="dp_block point">회원가입</a></li>
                </c:if>
                <c:if test="${not empty memberLoggedIn }">
                	<li><a href="${pageContext.request.contextPath }/member/memberLogout.do" class="dp_block">로그아웃</a></li>
                	<li><a href="${pageContext.request.contextPath }/member/myPage" class="dp_block">내 정보보기</a></li>
                </c:if>
                <li class="cs_center">
                    <a href="" class="dp_block">고객센터</a>
                    <ul>
                        <li><a href="${pageContext.request.contextPath }/notice/noticeList.do" class="dp_block">공지사항</a></li>
                        <li><a href="${pageContext.request.contextPath }/event/eventList.do" class="dp_block">이벤트</a></li>
                        <li><a href="" class="dp_block">자주하는 질문</a></li>
                        <li><a href="" class="dp_block">상품 제안</a></li>
                    </ul>
                </li>
                
                <li class="cs_center">
                    <a href="" class="dp_block">관리자</a>
                    <ul>
                    	<li><a href="${pageContext.request.contextPath}/admin/foundationList.do" class="dp_block">창업 신청 리스트</a></li>
                        <li><a href="${pageContext.request.contextPath}/market/marketList.do" class="dp_block">매장 리스트</a></li>
                        <li><a href="" class="dp_block">발주 리스트</a></li>
                        <li><a href="${pageContext.request.contextPath}/food/admin/goInsertFoodView.do" class="dp_block">식자재 등록</a></li>
                        <li><a href="${pageContext.request.contextPath}/banner/bannerList.do" class="dp_block">배너 등록</a></li>
                        <li><a href="${pageContext.request.contextPath}/event/eventList.do" class="dp_block">이벤트 등록</a></li>
                    </ul>
                </li>
                <c:if test="${memberLoggedIn.memberCheck eq 3 }">
	                <li class="cs_center">
	                    <a href="" class="dp_block">점주</a>
	                    <ul>
	                        <li><a href="${pageContext.request.contextPath}/market/myMarket.do?memberId=${memberLoggedIn.memberId}" class="dp_block">내 지점 관리</a></li>
	                        <li><a href="${pageContext.request.contextPath}/market/marketOrder.do?memberId=${memberLoggedIn.memberId}" class="dp_block">지점 주문 내역</a></li>
	                        <li><a href="${pageContext.request.contextPath}/market/marketStock.do?memberId=${memberLoggedIn.memberId}" class="dp_block">재고·발주 요청</a></li>
	                        <li><a href="${pageContext.request.contextPath}/foodOrder/foodOrderRequest.do?memberId=${memberLoggedIn.memberId}" class="dp_block">발주 요청 내역</a></li>
	                        <li><a href="${pageContext.request.contextPath}/market/marketChart.do?memberId=${memberLoggedIn.memberId}" class="dp_block">지점 매출 현황</a></li>
	                        <li><a href="${pageContext.request.contextPath}/event/eventList.do" class="dp_block">이벤트 관리</a></li>
	                    </ul>
	                </li>
                </c:if>
                <li><a href="${pageContext.request.contextPath}/market/marketList.do" class="dp_block">매장 찾기</a></li>
                <li><a href="" class="dp_block">배송지역 검색</a></li>
                <c:if test="${memberLoggedIn.memberCheck eq 1 }">
                	<li><a href="${pageContext.request.contextPath}/market/founded.do?memberId=${memberLoggedIn.memberId}" class="dp_block">창업 신청</a></li>
                </c:if>
                <c:if test="${memberLoggedIn.memberCheck eq 2 }">
                	<li><a href="${pageContext.request.contextPath}/market/foundedEndView.do?memberId=${memberLoggedIn.memberId}" class="dp_block">창업 신청 내역</a></li>
                </c:if>
            </ul>
        </div>
        <h1 id="logo" class="txt_center point"><a href="${pageContext.request.contextPath}" class="dp_ib">urban table</a></h1>
        <div id="menu_container" class="inner">
            <div id="menu_wrap">
                <ul id="gnb" class="clearfix">
                    <li><a href="" class="dp_block gnb_menu1">전체 카테고리</a></li>
                    <li><a href="" class="dp_block">신상품</a></li>
                    <li><a href="" class="dp_block">베스트</a></li>
                    <li><a href="" class="dp_block">알뜰 쇼핑</a></li>
                    <li><a href="${pageContext.request.contextPath }/recipe/recipe" class="dp_block">레시피</a></li>
                </ul>
                <div id="main_search">
                    <form action="" class="dp_block">
                        <input type="text" name="searchKeyword" id="searchKeyword" class="dp_block" placeholder="상품을 검색하세요!">
                        <input type="submit" value="검색">
                    </form>
                </div>
                <%-- <c:if test="${not empty memberLoggedIn}"> --%>
                	<a href="${pageContext.request.contextPath}/cart/cartList.do?memberId=${memberLoggedIn.memberId}&memberCheck=${memberLoggedIn.memberCheck}" class="go_cart dp_block"><img src="${pageContext.request.contextPath }/resources/images/cart.png" alt="장바구니"></a>
                <%-- </c:if> --%>
            </div>
        	<!-- FOOD 카테고리 가져오기 by 김기현 -->
          <div id="gnb_menu_wrap">
                <ul class="gnb_menu">
					<%
						for (FoodDivision foodDivision : new FoodServiceImpl().foodDivisionList) {
					%>
					<li><a href="${pageContext.request.contextPath }/food/selectFoodByCat.do?searchNo=<%=foodDivision.getFoodDivisionNo() %>&searchKeyword=<%=foodDivision.getFoodDivisionName() %>" class="dp_block"><%=foodDivision.getFoodDivisionName()%></a>
						<ul class="sub_menu">
							<%
							for (FoodUpper foodUpper : new FoodServiceImpl().foodUpperList) {
										if (foodDivision.getFoodDivisionNo().equals(foodUpper.getFoodDivisionNo()) && !"그 외".equals(foodUpper.getFoodUpperName())) {
							%>
							<li><a href="${pageContext.request.contextPath }/food/selectFoodByCat.do?searchNo=<%=foodUpper.getFoodUpperNo() %>&searchKeyword=<%=foodUpper.getFoodUpperName()%>" class="dp_block"><%=foodUpper.getFoodUpperName() %></a></li>

							<%
								}
									}
							%>
							<%
							for (FoodUpper foodUpper : new FoodServiceImpl().foodUpperList) {
										if (foodDivision.getFoodDivisionNo().equals(foodUpper.getFoodDivisionNo()) &&  "그 외".equals(foodUpper.getFoodUpperName()) ) {
							%>
							<li><a href="${pageContext.request.contextPath }/food/selectFoodByCat.do?searchNo=<%=foodUpper.getFoodUpperNo() %>&searchKeyword=<%=foodUpper.getFoodUpperName()%>" class="dp_block"><%=foodUpper.getFoodUpperName() %></a></li>

							<%
								}
									}
							%>
						</ul></li>
					<%
						}
					%>
                </ul>
            </div> 
        </div>
    </header>
	<div class="modal login-modal txt_center">
		<form class="modal-content animate">
			<div class="container txt_center">
				<label for="uname"><b>아이디</b></label>
				<input type="text" placeholder="아이디를 입력해주세요" name="memberId" required>
				<label for="psw"><b>비밀번호</b></label>
				<input type="password" placeholder="비밀번호를 입력해주세요" name="password" required>
				<button type="button" class="btn login">로그인</button>
				<div>
					<div class="chk_option">
						<input type="checkbox" name="saveId" id="saveId">
						<label for="saveId">아이디저장</label>
					</div>
					<div class="chk_option">
						<input type="checkbox" name="autoLogin" id="autoLogin">
						<label for="autoLogin">자동로그인</label>
					</div>
				</div>
			</div>
			<div class="container txt_center" style="background-color:#f4f4f0">
				<button type="button" class="btn btn2 cancelbtn">취소</button>
				<span class="find"><a href="${pageContext.request.contextPath }/member/memberFind/id">아이디찾기</a> / <a href="${pageContext.request.contextPath }/member/memberFind/pw">비밀번호찾기</a></span>
		    </div>
		</form>
	</div>
    <div id="container">