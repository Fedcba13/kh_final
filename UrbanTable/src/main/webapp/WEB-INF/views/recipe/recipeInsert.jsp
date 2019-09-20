<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/recipe.css">
<script>
var index = 2;
var material_i = 1;
$(()=> {
	
	$("#food_division").change(function() {
		var fr = this.value;
		var num = null;
		var vnum = null;
		var opt = $("#food_section option").length;
		var sel = $("#food_section");
		
		if(fr == "생수") {
			num = new Array("--소분류--", "생수");
			vnum = new Array("", "생수");
		} else if(fr == "탄산수") {
			num = new Array("--소분류--", "탄산수");
			vnum = new Array("", "탄산수");
		} else if(fr == "우유") {
			num = new Array("--소분류--", "일반우유");
			vnum = new Array("", "일반우유");
		} else if(fr == "두유") {
			num = new Array("--소분류--", "일반두유");
			vnum = new Array("", "일반두유");
		} else if(fr == "요구르트") {
			num = new Array("--소분류--", "요구르트");
			vnum = new Array("", "요구르트");
		} else if(fr == "쌀") {
			num = new Array("--소분류--", "쌀");
			vnum = new Array("", "쌀");
		} else if(fr == "잡곡/혼합곡") {
			num = new Array("--소분류--", "녹두", "보리", "수수", "율무", "찹쌀", "콩", "팥", "현미/발아현미",
					"귀리", "렌텔콩", "아마란스", "고대곡물", "찰현미", "기장", "참깨", "들깨", "혼합곡", "흑미");
			vnum = new Array("", "녹두", "보리", "수수", "율무", "찹쌀", "콩", "팥", "현미/발아현미",
					"귀리", "렌텔콩", "아마란스", "고대곡물", "찰현미", "기장", "참깨", "들깨", "혼합곡", "흑미");
		} else if(fr == "채소") {
			num = new Array("--소분류--", "무", "가지", "건고추", "깻잎", "당근", "대파", "두릅", "마늘", "상추", "샐러리", "생강",
					"알로에", "양파", "연근", "열무", "옥수수", "쪽파", "케일", "파프리카", "피망", "나물", "비트", "콜라비",
					"늙은호박", "도라지", "버섯", "산수유", "시금치", "야콘", "양상추", "오미자", "우엉", "콩나물", "호박", "쌈채소",
					"감자", "고구마", "배추", "더덕", "브로콜리", "양배추", "쑥갓", "오이");
			vnum = new Array("", "무", "가지", "건고추", "깻잎", "당근", "대파", "두릅", "마늘", "상추", "샐러리", "생강",
					"알로에", "양파", "연근", "열무", "옥수수", "쪽파", "케일", "파프리카", "피망", "나물", "비트", "콜라비",
					"늙은호박", "도라지", "버섯", "산수유", "시금치", "야콘", "양상추", "오미자", "우엉", "콩나물", "호박", "쌈채소",
					"감자", "고구마", "배추", "더덕", "브로콜리", "양배추", "쑥갓", "오이");
		} else if(fr == "과일") {
			num = new Array("--소분류--", "감귤", "단감", "딸기", "레몬", "망고", "매실", "멜론", "바나나", "방울토마토", "배", "복분자",
					"복숭아", "산딸기", "수박", "오디", "자두", "자몽", "키위/참다래", "참외", "천혜향", "체리", "토마토",
					"파인애플", "포도", "한라봉", "홍시", "오렌지", "사과", "대추", "블루베리", "아보카도", "아로니아", "석류", "무화과", "백향과");
			vnum = new Array("", "감귤", "단감", "딸기", "레몬", "망고", "매실", "멜론", "바나나", "방울토마토", "배", "복분자",
					"복숭아", "산딸기", "수박", "오디", "자두", "자몽", "키위/참다래", "참외", "천혜향", "체리", "토마토",
					"파인애플", "포도", "한라봉", "홍시", "오렌지", "사과", "대추", "블루베리", "아보카도", "아로니아", "석류", "무화과", "백향과");
		} else if(fr == "견과류") {
			num = new Array("--소분류--", "도토리", "땅콩", "마카다미아", "믹스너트", "밤", "시즈닝 견과", "아몬드", "은행", "잣", "캐슈넛", "피스타치오", "피칸", "한줌견과", "해바라기씨", "호두", "호박씨", "브라질너트", "카카오닙스");
			vnum = new Array("", "도토리", "땅콩", "마카다미아", "믹스너트", "밤", "시즈닝 견과", "아몬드", "은행", "잣", "캐슈넛", "피스타치오", "피칸", "한줌견과", "해바라기씨", "호두", "호박씨", "브라질너트", "카카오닙스");
		} else if(fr == "건과일/말랭이") {
			num = new Array("--소분류--", "감말랭이", "건망고", "건무화과", "건바나나", "건자두/푸룬", "건포도", "고구마말랭이", "곶감", "반건시", "편강", "건대추", "건크랜베리", "과일칩");
			vnum = new Array("", "감말랭이", "건망고", "건무화과", "건바나나", "건자두/푸룬", "건포도", "고구마말랭이", "곶감", "반건시", "편강", "건대추", "건크랜베리", "과일칩");
		} else if(fr == "건어물") {
			num = new Array("--소분류--", "건새우", "건오징어", "건조갯살", "노가리", "문어", "반건조오징어", "뱅어포/실치", "오다리/숏다리", "쥐포", "진미채", "한치", "황태/북어", "멸치");
			vnum = new Array("", "건새우", "건오징어", "건조갯살", "노가리", "문어", "반건조오징어", "뱅어포/실치", "오다리/숏다리", "쥐포", "진미채", "한치", "황태/북어", "멸치");
		} else if(fr == "생선류") {
			num = new Array("--소분류--", "가오리", "가자미", "갈치", "고등어", "굴비", "꽁치", "농어", "대구", "도루묵", "도미", "동태", "민물장어", "민어",
					"바다장어", "병어", "삼치", "열빙어", "아귀", "연어", "옥돔", "우럭", "이면수", "전어", "조기", "참치", "홍어", "명태코다리", "과메기");
			vnum = new Array("", "가오리", "가자미", "갈치", "고등어", "굴비", "꽁치", "농어", "대구", "도루묵", "도미", "동태", "민물장어", "민어",
					"바다장어", "병어", "삼치", "열빙어", "아귀", "연어", "옥돔", "우럭", "이면수", "전어", "조기", "참치", "홍어", "명태코다리", "과메기");
		} else if(fr == "해산물") {
			num = new Array("--소분류--", "가리비", "개불", "곤이", "골뱅이", "낙지", "날치알", "대게", "멍게", "문어", "바다가재", "새우", "굴", "성게",
					"소라", "미더덕", "오분자기", "오징어", "논우렁살", "전복", "바지락살", "쭈꾸미", "킹크랩", "한치", "해삼", "홍합");
			vnum = new Array("", "가리비", "개불", "곤이", "골뱅이", "낙지", "날치알", "대게", "멍게", "문어", "바다가재", "새우", "굴", "성게",
					"소라", "미더덕", "오분자기", "오징어", "논우렁살", "전복", "바지락살", "쭈꾸미", "킹크랩", "한치", "해삼", "홍합");
		} else if(fr == "해조류") {
			num = new Array("--소분류--", "김", "다시마", "매생이", "미역", "튀각/부각", "감태");
			vnum = new Array("", "김", "다시마", "매생이", "미역", "튀각/부각", "감태");
		} else if(fr == "쇠고기") {
			num = new Array("--소분류--", "구이/스테이크용", "LA갈비", "갈비찜/탕용", "불고기용", "국거리용", "양념육");
			vnum = new Array("", "구이/스테이크용", "LA갈비", "갈비찜/탕용", "불고기용", "국거리용", "양념육");
		} else if(fr == "돼지고기") {
			num = new Array("--소분류--", "삼겹살", "목살", "갈비/등갈비", "항정살/특수부위", "불고기용", "국/찌개거리", "보쌈용", "돈까스용", "양념육");
			vnum = new Array("", "삼겹살", "목살", "갈비/등갈비", "항정살/특수부위", "불고기용", "국/찌개거리", "보쌈용", "돈까스용", "양념육");
		} else if(fr == "닭고기") {
			num = new Array("--소분류--", "닭가슴살", "닭갈비", "달걀", "생닭", "다리살", "닭안심살", "양념살");
			vnum = new Array("", "닭가슴살", "닭갈비", "달걀", "생닭", "다리살", "닭안심살", "양념살");
		} else if(fr == "오리고기") {
			num = new Array("--소분류--", "훈제오리", "생오리고기");
			vnum = new Array("", "훈제오리", "생오리고기");
		} else if(fr == "양고기") {
			num = new Array("--소분류--", "양고기");
			vnum = new Array("", "양고기");
		} else if(fr == "축산가공식품") {
			num = new Array("--소분류--", "구운계란/훈제란", "곱창/막창", "순대", "족발", "돈까스", "떡갈비", "탕수육", "스테이크/폭립", "소시지", "베이컨", "햄/수제햄", "육포");
			vnum = new Array("", "구운계란/훈제란", "곱창/막창", "순대", "족발", "돈까스", "떡갈비", "탕수육", "스테이크/폭립", "소시지", "베이컨", "햄/수제햄", "육포");
		}
		
		for(var i=0; i<opt; i++) {
			$("#food_section")[0].options[i] = null;
		}
		
		for(var i=0; i<num.length; i++) {
			$("#food_section")[0].options[i] = new Option(num[i], vnum[i]);
		}
	});
	
	$("#tab_add").on("click", function() {
		var html = "";
		var tab = "";
		
		html += "<div id='recipe_content_div" + index + "'>";
		html += "<textarea name='recipe_content' id='recipe_content' cols='100' rows='5' style='border: 1px solid #e9e9e9; border-radius: 5px; color: #555; resize: none;'></textarea> <br /><br />";
		html += "<input type='text' style='width:560px;' disabled /> <button class='btn'>사진 가져오기</button> <br /><br />";
		html += "</div>";
		
		tab += "<li><button type='button' class='btn btn_content' value='"+ index +"'>"+ index +"</button></li>";
		
		//alert("html=" + html);
		
		$("#recipe_content_div").append(html);
		$(".tab").append(tab);
		$("#tab_remove").val(index);
		$("#tab_remove").css("display", "");
		
		for(var i=1; i<=$(".tab>li").length; i++) {
			$("#recipe_content_div" + i).css("display", "none");
		}
		
		$("#recipe_content_div" + index).css("display", "");
		$(".btn_content").css("background", "#374818");
		$(".btn_content").css("color", "#fff");
		$("ul>li>button[value='"+ index +"']").css("background", "#fff");
		$("ul>li>button[value='"+ index +"']").css("color", "#374818");
		
		index ++;
		
		tabEvent();
	});
	
	tabEvent();
	
	$("#tab_remove").on("click", function() {
		var i = this.value;
		$("#recipe_content_div" + i).remove();
		$("ul>li>button[value='"+ i +"']").remove();
		$(".btn_content:last").trigger("click");
		
		if(i-1 != 1) {			
			$("#tab_remove").css("display", "");
		}
		
		index --;
	});
	
	$(".btn_material").on("click", function() {
		if($("#food_division").val() == "") {
			alert("대분류를 선택하세요");
			return false;
		}
		
		if($("#food_section").val() == "") {
			alert("소분류를 선택하세요");
			return false;
		}
		
		var html = "";
		var section = $("#food_section").val();
		
		html += "<li class='mate_li' value='" + material_i + "'>" + $("#food_division").val() + ">" + section + "</li>"
		html += "<button type='button' class='mate_li_delete' value='" + material_i + "'>x</button>";
		
		$("#material_list").append(html);
		
		$(".mate_li_delete").on("click", function() {
			$(".mate_li[value='" + this.value + "']").remove();
			this.remove();
		});
		
		$.ajax({
			url: "${pageContext.request.contextPath}/recipe/materialInsert",
			data: {section: section},
			dataType: "json",
			type: "GET",
			success: (data)=> {
				console.log(data);
			},
			error: (xhr, txtStatus, err)=> {
				console.log("ajax 처리실패!", xhr, txtStatus, err);
			}
		});
		
		material_i++;
	});
});

function tabEvent() {
	$(".tab>li>button").on("click", function() {
		for(var i=1; i<=$(".tab>li").length; i++) {
			$("#recipe_content_div" + i).css("display", "none");
		}
		
		$(".btn_content").css("background", "#374818");
		$(".btn_content").css("color", "#fff");
		
		if(this.value == index-1) {
			$("#tab_remove").css("display", "");
		} else {
			$("#tab_remove").css("display", "none");
		}
		
		$("#recipe_content_div" + this.value).css("display", "");
		$("ul>li>button[value='"+ this.value +"']").css("background", "#fff");
		$("ul>li>button[value='"+ this.value +"']").css("color", "#374818");
		
		$("#tab_remove").val(this.value);
	});
}
</script>
<section class=""> <!--배경색이 있는 경우만 sec_bg 넣으면 됩니다.-->
	<article class="subPage inner">
	    <h3 class="sub_tit">레시피 만들기</h3>
	    <form action="">
		    <table class="tbl tbl_view recipe_insert_tbl"> <!--가운데 정렬 아니면 txt_center 빼셔도 됩니다.
		                                    width 값은 th에 width="150" 이런식으로 써주시면 됩니다.-->
	            <tr>
	                <th style="width:200px">제목</th>
	                <td><input type="text" style="width:720px;" /></td>
	            </tr>
	            <tr>
	            	<th>재료</th>
	                <td>
	                	<select name="food_division" id="food_division">
	                		<option value="">--대분류--</option>
	                		<option value="생수">생수</option>
	                		<option value="탄산수">탄산수</option>
	                		<option value="우유">우유</option>
	                		<option value="요구르트">요구르트</option>
	                		<option value="쌀">쌀</option>
	                		<option value="잡곡/혼합곡">잡곡/혼합곡</option>
	                		<option value="채소">채소</option>
	                		<option value="과일">과일</option>
	                		<option value="견과류">견과류</option>
	                		<option value="건과일/말랭이">건과일/말랭이</option>
	                		<option value="건어물">건어물</option>
	                		<option value="생선류">생선류</option>
	                		<option value="해산물">해산물</option>
	                		<option value="해조류">해조류</option>
	                		<option value="쇠고기">쇠고기</option>
	                		<option value="돼지고기">돼지고기</option>
	                		<option value="닭고기">닭고기</option>
	                		<option value="오리고기">오리고기</option>
	                		<option value="양고기">양고기</option>
	                		<option value="축산가공식품">축산가공식품</option>
	                	</select>
	                	<select name="food_section" id="food_section">
	                		<option value="">--소분류--</option>
	                	</select>
	                	<button type="button" class="btn btn_material">추가</button>
	                	<br />
	                	<ol id="material_list"></ol>
	                </td>
	            </tr>
	            <tr>
	            	<th>레시피</th>
	                <td>
	                	<div id="recipe_content_div">
	                		<ul class="tab">
			                	<li><button type="button" class="btn btn_content" value="1">1</button></li>
	                		</ul>
		                	<div id="recipe_content_div1">
			                	<textarea name="recipe_content" id="recipe_content" cols="100" rows="5" style="border: 1px solid #e9e9e9; border-radius: 5px; color: #555; resize: none;"></textarea> <br /><br />
			                	<input type="text" style="width:560px;" disabled /> <button class="btn" type="button">사진 가져오기</button> <br /><br />
		                	</div>	                	
	                	</div>
	                	<div class="btn_add">
		                	<button type="button" class="btn btn_content_ar" id="tab_add">+</button>
		                	<button type="button" class="btn btn_content_ar" id="tab_remove" style="display:none;">-</button>		                	
	                	</div>
	                </td>
	            </tr>
	        </table>
        </form>
    </article>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>