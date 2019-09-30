function changeMarket() {
	$.ajax({
		url: "http://localhost:10090/urbanTable/food/selectFoodByDiv.do",
		data: $("#menuRecommendationFrm").serialize(),
		dataType: "json",
		type: "GET",
		success: (data)=>{
			console.log(data);
			var html = "<table class=table>";
	        html+="<tr><th>메뉴번호</th><th>음식점</th><th>메뉴</th><th>가격</th><th>타입</th><th>맛</th></tr>";
	        for(var i in data){
            	html += "<tr><td>"+data[i].foodNo+"</td>";
               	html += "<td>"+data[i].restaurant+"</td>";
               	html += "<td>"+data[i].foodName+"</td>";
               	html += "<td>"+data[i].price+"</td>";
               	html += "<td>"+data[i].foodType+"</td>";
               	html += "<td>"+data[i].taste+"</td></tr>";
           	}
           	html+="</table>";
           	$("#menuRecommendation-result").html(html);
		},
		error: (xhr, txtStatus, err)=>{
			console.log("ajax처리실패!", xhr, txtStatus, err);
		}
		
		
	});
};