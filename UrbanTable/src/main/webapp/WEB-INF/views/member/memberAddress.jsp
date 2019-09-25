<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
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
    <style>
    
    	.address_content{
    		border-top: 2px solid #374818;
    		border-bottom: 2px solid #374818;
    		width: 600px;
    	}
    
    	.address-card .btn{
    		width: 60px;
    	}
    	
    	.address-card{
    		padding: 10px;
    		border: 1px solid #e9e9e9;
    		
    	}
    	
    	.address-card .address-card-foot{
    		text-align: right;
    	}
    </style>
</head>
<body>
	<section class="popup"> <!--배경색이 있는 경우만 sec_bg 넣으면 됩니다.-->
		<article class="subPage inner">
		    <h3 class="sub_tit">주소지 관리</h3>
		    <div class="address_content">
		    	<c:forEach items="${addressList }" var="address" varStatus="vs">
		    		<div class="address-card">
		    			<div class="address-title">
		    				<c:if test="${vs.count == 1 }">
		    					기본 주소
		    				</c:if>
		    				<c:if test="${empty address.ADDRESS_NAME && vs.count != 1}">
		    					주소${vs.count }
		    				</c:if>
		    				<c:if test="${not empty address.ADDRESS_NAME}">
		    					${address.ADDRESS_NAME }
		    				</c:if>
		    			</div>
		    			<div class="address-card-body">
		    				${address.MEMBER_ADDRESS }<c:if test="${not empty address.MEMBER_ADDRESS2 }">, ${address.MEMBER_ADDRESS2 }</c:if>
		    				
		    			</div>
						<div class="address-card-foot">
							<input type="button" class="btn" value="수정">
							<input type="button" class="btn btn2" value="삭제">
						</div>
		    		</div>
		    	</c:forEach>
		    </div>
	    </article>
	</section>
</body>
</html>