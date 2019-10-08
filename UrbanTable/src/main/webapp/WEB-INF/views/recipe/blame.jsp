<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<form action="${pageContext.request.contextPath}/recipe/blameComment">
	<table>
		<tr>
			<td>신고 내용</td>
			<td><textarea name="blameContent" id="blameContent" cols="30" rows="10"></textarea></td>
		</tr>
	</table>
	<input type="hidden" name="memberId" value="${memberLoggedIn.memberId}" />
	<input type="hidden" name="targetType" value="3" />
	<input type="hidden" name="blameTargetId" value="${recipeNo}" />
	<button class="btn">신고</button>
</form>