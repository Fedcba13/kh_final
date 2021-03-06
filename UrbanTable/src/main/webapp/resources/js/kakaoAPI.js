//카카오 주소찾기 api
function execDaumPostcode(onClose) {
	
	console.log(onClose);
	
	var width = 500; //팝업의 너비
	var height = 600; //팝업의 높이
	
	new daum.Postcode({
		oncomplete: function(data) {
			// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

			// 각 주소의 노출 규칙에 따라 주소를 조합한다.
			// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
			var addr = ''; // 주소 변수
			var extraAddr = ''; // 참고항목 변수

			//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
			if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
				addr = data.roadAddress;
			} else { // 사용자가 지번 주소를 선택했을 경우(J)
				addr = data.jibunAddress;
			}
			
			if(onClose == 'on'){
				
			}else{
				//table 속성을 추가한다.
				$(".tbl_addr>th").attr("rowspan", "3");
				if($(".tbl_addr1").length == 0){
					var html = '';
						html += '<tr class="tbl_addr1">';
						html += '<td><input type="text" value="" name="memberAddress"></td>';
						html += '</tr>';
						html += '<tr class="tbl_addr2">';
						html += '<td><input type="text" value="" placeholder="세부주소를 입력해주세요." maxlength="35" name="memberAddress2">';
						html += '<p>';
						html += '<span class="txt"></span>';
						html += '</p>';
						html += '</td>';
						html += '</tr>';
					$(".member_register").append(html);
				}
				
				//주소 정보를 해당 필드에 넣는다.
				$(".tbl_addr1 input[type='text']").val(addr);
				
				// 커서를 상세주소 필드로 이동한다.
				$(".tbl_addr2 input[type='text']").val('');
				$(".tbl_addr2 input[type='text']").focus();
			}
			$.ajax({
				url: contextPath+"/member/nearMarket.do",
				data : {address: addr},
				success: (data)=>{
					alert(data.msg);
				},
				error: (xhr, txtStatus, err)=>{
					console.log("ajax처리실패!", xhr, txtStatus, err);
				}
			});
		}
	}).open({
	    left: (window.screen.width/2) - (width/2),
	    top: (window.screen.height/2) - (height/2)
	});
}