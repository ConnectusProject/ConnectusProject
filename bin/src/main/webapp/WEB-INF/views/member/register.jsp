<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JOIN</title>
<script src="js/jquery-3.6.0.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
$(document).ready(function(){

});
</script>
</head>
<body>
<div>
	<form name="form" action="register" method="post">
		<div>
			<input type=text name="id" id="id" placeholder="아이디를 입력하세요" required>
			<input type="button" id="id-btn" value="id체크" onclick="idcheck()" >
		</div>
		<div id="id_check"></div>
		
		<div>
		<input type=password name="pw" id="pw" placeholder="비밀번호를 입력하세요" required oninput="pwcheck()"><br>
		</div>
		<div id="pw_check"></div>
		
		<div>
		<input type=password name="pw2" id="pw2" placeholder="비밀번호를 한번 더 입력하세요" required oninput="pw2check()">
		</div>
		<div id="pw2_check"></div>
		
		<input type=text name="name" placeholder="이름을 입력하세요" required oninput="namecheck()"><br>
		
		<input type=text name="email" placeholder="이메일을 입력하세요" required oninput="emailcheck()"><br>

		<br>
		<input type="text" id="sample6_postcode" placeholder="우편번호">
		<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
		<input type="text" id="sample6_address" placeholder="주소"><br>
		<input type="text" id="sample6_detailAddress" placeholder="상세주소">
		<input type="text" id="sample6_extraAddress" placeholder="참고항목">
		<input type="hidden" id="address" name="address" value="">	
		<br><br>
	
		<div>
		<input type=text name="phone" id="phone" placeholder="전화번호를 (-)제외하고 입력하세요" required oninput="phonecheck()"><br>
		</div>
		<div id="phone_check"></div>
		<div>
			<input type="submit" id="btn" value="회원가입" onclick="check()" disabled><br>
		</div>
		
	</form>
	
	
</div>



<script>
let id = $('#id');
let pw = $('#pw');
let pw2 = $('#pw2');
let phone = $('#phone');
let email = $('#email');
let name = $('#name');
let btn = $('#btn');


let id_check=false;
let pw_check=false;
let pw2_check=false;
let phone_check=false;
let email_check=false;
let name_check=false;



function idcheck(){
	var id = $('#id').val();
	var regId = /^[A-Za-z0-9]{6,20}$/;
	if(id==''){
		$('#id_check').text("아이디를 입력해주세요");
		$('#id_check').css("color","red");
		id_check=false;		
		$('#btn').attr('disabled',true);
	}else{
		$.ajax({
			url:"idCheck",
			type:'post',
			data:{id:id},
			success:function(data){
				if(data=='true'){
					$('#id_check').text("이미 가입된 아이디입니다");
					$('#id_check').css("color","red");
					id_check=false;			
					$('#btn').attr('disabled',true);					
				}else{
					if(!regId.test(id)){
						$('#id_check').text("영문과 숫자 6~20자 이내로 입력하세요");
						$('#id_check').css("color","red");
						id_check=false;
						$('#btn').attr('disabled',true);
					}else{
						$('#id_check').text("사용 가능한 아이디입니다");
						$('#id_check').css("color","green");
						id_check=true;
						if(id_check==true&&pw_check==true&&pw2_check==true&&phone_check==true&&email_check==true&&name_check==true){
							$('#btn').attr('disabled',false);
						}
					}
				}
			}
		});
	}
}

function pwcheck(){
	var pw = $('#pw').val();
	
	if(pw==''){
		$('#pw_check').text("패스워드를 입력하세요");
		$('#pw_check').css("color","red");
		pw_check=false;
		$('#btn').attr('disabled',true);				
	}else if(pw.length < 8 || pw.length >17){
		$('#pw_check').text("패스워드 길이는 8자이상 16자이하 입니다");
		$('#pw_check').css("color","red");
		pw_check=false;
		$('#btn').attr('disabled',true);
	}else if(pw.search(/\s/)!=-1){
		$('#pw_check').text("패스워드는 공백을 포함할 수 없습니다");
		$('#pw_check').css("color","red");
		pw_check=false;
		$('#btn').attr('disabled',true);		
	}else {
		$('#pw_check').text("패스워드 사용가능");
			$('#pw_check').css("color","green");
			pw_check=true;
			if(id_check==true&&pw_check==true&&pw2_check==true&&phone_check==true&&email_check==true&&name_check==true){
			$('#btn').attr('disabled',false);
		}		
	}
}

function pw2check(){
	var pw2 = $('#pw2').val();
	var pw = $('#pw').val();
	if(pw2==''){
		$('#pw2_check').text("패스워드확인을 입력하세요");
		$('#pw2_check').css("color","red");
		pw2_check=false;
		$('#btn').attr('disabled',true);
	}else if(pw2 == pw){
		$('#pw2_check').text("패스워드가 일치합니다.");
		$('#pw2_check').css("color","green");
		pw2_check=true;
		if(id_check==true&&pw_check==true&&pw2_check==true&&phone_check==true&&email_check==true&&name_check==true){
		$('#btn').attr('disabled',false);
		}
	}else{
		$('#pw2_check').text("패스워드를 확인해주세요.");
		$('#pw2_check').css("color","red");
		pw2_check=false;
		$('#btn').attr('disabled',true);
				
	}	
}

function phonecheck(){
	var phone = $('#phone').val();
	var regTel =  /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})[0-9]{3,4}[0-9]{4}$/;
	
	if(phone==''){
		$('#phone_check').text("전화번호를 입력하세요");
			$('#phone_check').css("color","red");
			phone_check=false;
			$('#btn').attr('disabled',true);
		}else if(!regTel.test(phone)){
			$('#phone_check').text("올바른 전화번호를 입력하세요. ex)01012345678, 021231234");
			$('#phone_check').css("color","red");
			phone_check=false;
			$('#btn').attr('disabled',true);
		}else{
			console.log("asd");
			$.ajax({
				url:"phoneCheck",
				type:'post',
				data:{phone:phone},
				success:function(data){
					if(data == 'true'){
						$('#phone_check').text("이미 사용중인 번호 입니다");
						$('#phone_check').css("color","red");
						phone_check=false;
						$('#btn').attr('disabled',true);
					}else{
						$('#phone_check').text("사용가능한 번호 입니다");
	    				$('#phone_check').css("color","green");
	    				phone_check=true;
	    				if(id_check==true&&pw_check==true&&pw2_check==true&&phone_check==true&&email_check==true&&name_check==true){
	    				$('#btn').attr('disabled',false);
	    					}
						}
					}				
			});			
		}
}

function emailcheck(){
	var email = $('#email').val();
	if(email==''){
		$('#email_check').text("이메일을 입력하세요");
		$('#email_check').css("color","red");
		phone_check=false;
		$('#btn').attr('disabled',true);		
	}else{
		email_check=true;
		if(id_check==true&&pw_check==true&&pw2_check==true&&phone_check==true&&email_check==true&&name_check==true){
		$('#btn').attr('disabled',false);
		}
	}
	
}

function namecheck(){
	var name = $('#name').val();
	if(name==''){
		$('#name_check').text("이름을 입력하세요");
		$('#name_check').css("color","red");
		name_check=false;
		$('#btn').attr('disabled',true);		
	}else{
		name_check=true;
		if(id_check==true&&pw_check==true&&pw2_check==true&&phone_check==true&&email_check==true&&name_check==true){
		$('#btn').attr('disabled',false);
		}
	}
	
}



function sample6_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
			console.log(data)
            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
          	var addr = ''; // 주소 변수
          	var detailAddr = ''; //상세주소
            var extraAddr = ''; // 참고항목 변수
            var add = addr + detailAddr;

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
                document.getElementById("sample6_extraAddress").value = extraAddr;
            
            } else {
                document.getElementById("sample6_extraAddress").value = '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('sample6_postcode').value = data.zonecode;
            document.getElementById("sample6_address").value = addr;
            
            // 커서를 상세주소 필드로 이동한다.
           
            document.getElementById("sample6_detailAddress").focus();
            document.getElementById("sample6_detailAddress").value = detailAddr;
  			$("#address").val(addr);           
        }
    }).open();

    
}



/*
function check(){
	var fm = document.form;
	
	if(fm.id.value == ""){
		alert("아이디를 입력하세요");
		document.form.id.focus();
		return;
	}
	if(fm.pw.value == ""){
		alert("비밀번호를 입력하세요");
		document.form.pw.focus();
		return;
	}	
	if(fm.pw2.value == ""){
		alert("비밀번호를 입력하세요");
		document.form.pw.focus();
		return;
	}
	if(fm.name.value == ""){
		alert("이름을 입력하세요");
		document.form.name.focus();
		return;
	}
	if(fm.phone.value == ""){
		alert("전화번호를 입력하세요 ('-'는 제외)");
		document.form.phone.focus();
		return;
	}
	if(fm.email.value == ""){
		alert("이메일을 입력하세요");
		document.form.email.focus();
		return;
	}
	if(fm.address.value == ""){
		alert("주소를 입력하세요");
		document.form.address.focus();
		return;
	}
	alert("성공적으로 가입되셨습니다.")
}
*/

</script>
</body>
</html>