<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0/dist/Chart.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/marketOwner.css">
<section>
	<article class="subPage inner">
	    <h3 class="sub_tit">지점 매출 현황</h3>
	    <div class="txt_right">
	    	<select id="chartType" class="txt_left" style="width:150px; margin-bottom:20px;">
	    		<option value="week" rel="wm" selected>최근 7일이내</option>
	    		<option value="month" rel="wm">월별</option>
	    		<option value="category" rel="cate">카테고리별</option>
	    	</select>
	    </div>
	    <div id="chartWrap">
	    	<div id="wm" class="ch"><canvas id="barChart"></canvas></div>
	    	<div id="cate" class="ch"><canvas id="pieChart"></canvas></div>
	    </div>
    </article>
</section>
<script>
var marketNo = "${marketNo}";
var chartLabels = [];
var barChartDataArr = [];
var lineChartDataArr = [];
var pieChartDataArr = [];
var chartPieLabels = [];
var myLineChart;
var chartData = {
    datasets: [{
        label: '주문 건수',
        yAxisID: 'A',
        backgroundColor: [
			'rgba(255,99,132,0.5)',
			'rgba(54,162,235,0.5)',
			'rgba(255,206,86,0.5)',
			'rgba(75,192,192,0.5)',
			'rgba(153,102,255,0.5)',
			'rgba(255,159,65,0.5)'
		],
        borderColor: [
        	'rgba(255,99,132,1)',
			'rgba(54,162,235,1)',
			'rgba(255,206,86,1)',
			'rgba(75,192,192,1)',
			'rgba(153,102,255,1)',
			'rgba(255,159,65,1)'
        ],
        data: barChartDataArr
    }, {
        label: '평균 매출',
        yAxisID: 'B',
        data: lineChartDataArr,
        type: 'line',
        fill: false,
        backgroundColor: [
			'rgba(255,99,132,0.5)',
			'rgba(54,162,235,0.5)',
			'rgba(255,206,86,0.5)',
			'rgba(75,192,192,0.5)',
			'rgba(153,102,255,0.5)',
			'rgba(255,159,65,0.5)'
		],
        borderColor: [
        	'rgba(255,99,132,1)',
			'rgba(54,162,235,1)',
			'rgba(255,206,86,1)',
			'rgba(75,192,192,1)',
			'rgba(153,102,255,1)',
			'rgba(255,159,65,1)'
        ]
    }],
    labels: chartLabels
}

var dataPie = {
	datasets: [{
        label: '주문 건수',
        yAxisID: 'A',
        backgroundColor: [
			'rgba(255,99,132,0.5)',
			'rgba(54,162,235,0.5)',
			'rgba(255,206,86,0.5)',
			'rgba(75,192,192,0.5)',
			'rgba(153,102,255,0.5)',
			'rgba(255,159,65,0.5)',
			'rgba(255,99,132,0.5)',
			'rgba(54,162,235,0.5)',
			'rgba(255,206,86,0.5)',
			'rgba(75,192,192,0.5)',
			'rgba(153,102,255,0.5)',
			'rgba(255,159,65,0.5)'
		],
        borderColor: [
        	'rgba(255,99,132,1)',
			'rgba(54,162,235,1)',
			'rgba(255,206,86,1)',
			'rgba(75,192,192,1)',
			'rgba(153,102,255,1)',
			'rgba(255,159,65,1)',
			'rgba(255,99,132,1)',
			'rgba(54,162,235,1)',
			'rgba(255,206,86,1)',
			'rgba(75,192,192,1)',
			'rgba(153,102,255,1)',
			'rgba(255,159,65,1)'
        ],
        data: pieChartDataArr
    }, ],
    labels: chartPieLabels	
}

var config = {
	type : 'bar',
	data : chartData,
	options :{
		animation: {
            duration: 0
        }, 
		scales: { 
		     yAxes: [
		    	 { 
				     id: 'A', 
				     type: 'linear', 
				     position: 'left', 
				     ticks: { 
				    	 beginAtZero : true
				     } 
			     }, 
			     { 
				     id: 'B', 
				     type: 'linear', 
				     position: 'right',
				     ticks: { 
				    	 min : 10000
				     } 
			     }] 
		}
	}
}

function createChart(){
	var ctx = document.getElementById("barChart").getContext("2d");
	myLineChart = new Chart(ctx, config);
}

function createPieChart(){
	var ctxPie = document.getElementById("pieChart").getContext("2d");
	myPieChart = new Chart(ctxPie, {
		type: 'pie',
		data: dataPie,
		options:{}
	});
}

function selectChartWeek(){
	$.ajax({
		url: "${pageContext.request.contextPath}/market/selectChartWeek.do",
		data: {marketNo:marketNo},
		dataType: "json",
		type: "get",
		success: function(data){
			for(var i in data){
				chartLabels[i]=data[i].PAYDATE;
				barChartDataArr[i]=data[i].CNT;
				lineChartDataArr[i]=data[i].AVG_PRICE;
			}
			createChart();
		},
		error: function(xhr, txtStatus, err){
			console.log("ajax 처리 실패", xhr, txtStatus, err);
		}
	});
}

function selectChartMonth(){
	$.ajax({
		url: "${pageContext.request.contextPath}/market/selectChartMonth.do",
		data: {marketNo:marketNo},
		dataType: "json",
		type: "get",
		success: function(list){
			console.log(list);
			var datasets = myLineChart.config.data.datasets;
			for(var i in list){
				myLineChart.config.data.labels[i]=list[i].PAYDATE;
				datasets[0].data[i]=list[i].CNT;
				if(datasets.length<2){
					lineChartDataArr[i]=list[i].AVG_PRICE;
				} else {
					datasets[1].data[i]=list[i].AVG_PRICE;
				}
			}
			myLineChart.update(config);
		},
		error: function(xhr, txtStatus, err){
			console.log("ajax 처리 실패", xhr, txtStatus, err);
		}
	});
}

function selectChartCategory(){
	$.ajax({
		url: "${pageContext.request.contextPath}/market/selectChartCategory.do",
		data: {marketNo:marketNo},
		dataType: "json",
		type: "get",
		success: function(list){
			var cate = list.chartCategory;
			var datasets = myLineChart.config.data.datasets;
			for(var i in cate){
				chartPieLabels[i]=cate[i].FOOD_DIVISION_NAME;
				pieChartDataArr[i]=cate[i].AMOUNT;
			}
			createPieChart();
		},
		error: function(xhr, txtStatus, err){
			console.log("ajax 처리 실패", xhr, txtStatus, err);
		}
	});
}

function refreshChart(){
	myLineChart.clear();
	myLineChart.data.labels.splice(0, myLineChart.data.labels.length);
	myLineChart.data.datasets.forEach((dataset) => {
        dataset.data.splice(0, dataset.data.length);
    });
}

$(()=>{
	selectChartWeek();
	$("#chartWrap .ch").hide();
	$("#chartWrap .ch:first").show();
	$("#chartType").on('change', function(){
		var type = $(this).children("option:selected").val();
		var ref = $(this).children("option:selected").attr("rel");
		$("#chartWrap .ch").hide();
		$("#chartWrap #"+ref).show();
		if(type=='week'){
			refreshChart();
			selectChartWeek();
		} else if(type=='month'){
			refreshChart();
			selectChartMonth();
		} else if(type=='category'){
			selectChartCategory();
		}
	});
	
});
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>