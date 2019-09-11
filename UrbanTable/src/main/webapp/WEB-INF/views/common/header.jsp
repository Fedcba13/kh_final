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
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/main.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/slick.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/slick-theme.css"/>
    <script type="text/javascript" src="http://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/slick.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/common.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/main.js"></script>
</head>
<body>
    <header id="header">
        <div id="util_wrap">
            <ul>
                <li><a href="" class="dp_block point">회원가입</a></li>
                <li><a href="" class="dp_block">로그인</a></li>
                <li class="cs_center">
                    <a href="" class="dp_block">고객센터</a>
                    <ul>
                        <li><a href="" class="dp_block">공지사항</a></li>
                        <li><a href="" class="dp_block">자주하는 질문</a></li>
                        <li><a href="" class="dp_block">상품 제안</a></li>
                    </ul>
                </li>
                <li class="cs_center">
                    <a href="" class="dp_block">관리자</a>
                    <ul>
                        <li><a href="" class="dp_block">매장 리스트</a></li>
                        <li><a href="" class="dp_block">발주 리스트</a></li>
                        <li><a href="" class="dp_block">식자재 등록</a></li>
                        <li><a href="" class="dp_block">배송 관리</a></li>
                        <li><a href="" class="dp_block">재고 관리</a></li>
                    </ul>
                </li>
                <li><a href="" class="dp_block">배송지역 검색</a></li>
                <li><a href="" class="dp_block">창업 신청</a></li>
            </ul>
        </div>
        <h1 id="logo" class="txt_center point">urban table</h1>
        <div id="menu_container" class="inner">
            <div id="menu_wrap">
                <ul id="gnb" class="clearfix">
                    <li><a href="" class="dp_block gnb_menu1">전체 카테고리</a></li>
                    <li><a href="" class="dp_block">신상품</a></li>
                    <li><a href="" class="dp_block">베스트</a></li>
                    <li><a href="" class="dp_block">알뜰 쇼핑</a></li>
                    <li><a href="" class="dp_block">레시피</a></li>
                </ul>
                <div id="main_search">
                    <form action="" class="dp_block">
                        <input type="text" name="searchKeyword" id="searchKeyword" class="dp_block" placeholder="상품을 검색하세요!">
                        <input type="submit" value="검색">
                    </form>
                </div>
                <a href="${pageContext.request.contextPath}/cart/cartList.do" class="go_cart dp_block"><img src="${pageContext.request.contextPath }/resources/images/cart.png" alt="장바구니"></a>
            </div>
            <div id="gnb_menu_wrap">
                <ul class="gnb_menu"> <!--밑에 메뉴는 예시이고 관리자가 메뉴 관리를 통해 관리하게 해주세요.-->
                    <li>
                        <a href="" class="dp_block">채소</a>
                        <ul class="sub_menu">
                            <li><a href="" class="dp_block">기본채소</a></li>
                            <li><a href="" class="dp_block">쌈·샐러드·간편채소</a></li>
                            <li><a href="" class="dp_block">브로콜리·특수채소</a></li>
                        </ul>
                    </li>
                    <li><a href="" class="dp_block">과일·견과·쌀</a></li>
                    <li><a href="" class="dp_block">수산·해산·건어물</a></li>
                    <li><a href="" class="dp_block">정육·계란</a></li>
                </ul>
            </div>
        </div>
    </header>
    <div id="container">