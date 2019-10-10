<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html style="width:100%;">
<head>
<meta charset="UTF-8">
<title>추천 상품</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/default.css">
<script type="text/javascript" src="http://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>
<style>
h2 {
	text-align: center;
	margin-top: 50px;
}

#search {
	height: 100px;
	text-align: center;
	margin-top: 30px;
	background: #f4f4f0;
	padding-top: 30px;
}

#searchName {
	height: 40px;
	width: 400px;
}

.foodName {
	width: 300px;
}

table {
	margin-top: 50px;
	margin: auto;
}

table>tr {
	height: 200px;
	cursor: pointer;
	cursor: hand;
}

.searchFoodImg {
	width: 200px;
}

.foodTable {
	margin-top: 50px;
}

.image {
	width: 250px;
	height: 250px;
}
</style>
<script>
$(()=> {
	
	$(".btn").on("click", function() {
		var searchName = $("#searchName").val();
		
		$.ajax({
			url: "${pageContext.request.contextPath}/recipe/foodSearchList",
			data: {searchName: searchName},
			dataType: "json",
			type: "GET",
			success: (data)=>{
				console.log(data);
				$("table").empty();
				var html = "";
				if(data.length == 0) {
					html += "<tr>";
					html += "<td>검색 결과가 없습니다.</td>";
					html += "</tr>";
				} else {
					for(var i=0; i<data.length; i++) {
						html += "<tr foodName='" + data[i].foodName + "' foodNo='" + data[i].foodNo + "'>";
						html += "<td class='image'><img class='searchFoodImg' src='" + data[i].foodImg + "' alt='' /></td>";
						html += "<td class='foodName'>" + data[i].foodName + "</td>";
						html += "</tr>";
					}
				}
				$("table").append(html);
				
				$("tr").click(function() {
					$(opener.location).attr("href", "javascript:setChildValue('" + $(this).attr("foodName") + "');");
					$(opener.location).attr("href", "javascript:setChildNoValue('" + $(this).attr("foodNo") + "');");
					window.close();
				});
			},
			error: (xhr, txtStatus, err)=> {
				console.log("ajax 처리실패!", xhr, txtStatus, err);
			}
		});
	});
});
</script>
<body>
	<h2>추천 상품 검색</h2>
	<div id="search">
		<input type="text" id="searchName" />
		<button class="btn">검색</button>	
	</div>
		<table class="foodTable"></table>
</body>
</html>