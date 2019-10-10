<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<script>
window.onload = function(){
	var type = '${type}';
	if(type == 2){
		document.getElementsByName("targetType")[0].value = 2;
	}
}

function goOpener() {
	opener.name = "insertBlame";
	document.blameFrm.target = opener.name;
	document.blameFrm.submit();
	self.close();
}
</script>
<form name="blameFrm" action="${pageContext.request.contextPath}/recipe/blameComment">
	<table>
		<tr>
			<td>신고 내용</td>
			<td><textarea name="blameContent" id="blameContent" cols="30" rows="10"></textarea></td>
		</tr>
	</table>
	<input type="hidden" name="memberId" value="${memberLoggedIn.memberId}" />
	<input type="hidden" name="targetType" value="3" />
	<input type="hidden" name="blameTargetId" value="${recipeNo}" />
	<input type="hidden" name="recipeNo" value="${recipeNo}" />
	<input type="hidden" name="foodNo" value="${foodNo}" />
	<input type="hidden" name="marketNo" value="${marketNo}" />
	<button class="btn" onclick="goOpener();">신고</button>
</form>