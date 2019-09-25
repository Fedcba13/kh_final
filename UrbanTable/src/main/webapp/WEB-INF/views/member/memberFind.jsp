<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<style>
	.memberFind nav{
		border-bottom: 2px solid #0185da;
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
	    border-color: #0185da;
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
	
</style>

<script>
	$(()=>{		
		<c:if test='${type == "id"}'>
			$(".memberFind .tab .id").addClass('active');
			$(".memberFind .tab .pw").addClass('inactive');
		</c:if>
		<c:if test='${type == "pw"}'>
			$(".memberFind .tab .id").addClass('inactive');
			$(".memberFind .tab .pw").addClass('active');
		</c:if>
	});
</script>

<section> <!--배경색이 있는 경우만 sec_bg 넣으면 됩니다.-->
	<article class="subPage inner memberFind">
		<nav>
			<ul>
				<li class='tab'><a class='id'>아이디찾기</a></li>
				<li class='tab'><a class='pw'>비밀번호찾기</a></li>
			</ul>
		</nav>
		<c:if test="${empty type || type == 'id' }">
			<div>
		    <h3 class="sub_tit">아이디 찾기</h3>
				
			</div>
		</c:if>
		<c:if test="${not empty type && type == 'pw' }">
			<div>
		    <h3 class="sub_tit">비밀번호 찾기</h3>
			
			</div>
		</c:if>
    </article>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>