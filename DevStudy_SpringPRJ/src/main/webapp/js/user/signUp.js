//아이디 정규식
const pattern = new RegExp("^[a-zA-Z][0-9a-zA-Z]{5,13}$")

//비밀번호 정규식
const regex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,15}$/;

//전화번호 자동 하이픈 정규식
$(document).on("keyup", ".phoneNumber", function() { 
	$(this).val( $(this).val().replace(/[^0-9]/g, "").replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/,"$1-$2-$3").replace("--", "-") );
});

$("#account-pwd","#account-pwd-chk").keyup(function(){
    let mem_pw = $("#account-pwd").val();
    let pw_confirm = $("#account-pwd-chk").val();

    if(mem_pw=='' && pw_confirm==''){
        $("#confirmMsg").text("");
        return;
    }

    if(mem_pw.length >= 8 && pw_confirm.length >= 8){
        if(mem_pw == pw_confirm){
            $("#confirmMsg").text("비밀번호 일치").css('color','#000');
            return;
        }
        if(mem_pw != pw_confirm){
            $("#confirmMsg").text("비밀번호 불일치").css('color','#fba082');
            return;					
        }
    }
});

function createFrom(obj){
	if(obj.id.value ==""){
		alert("아이디를 반드시 입력하세요.");
		obj.id.focus();
		return false;
	}
	
	if(!pattern.test(obj.id.value)){
		alert("아이디는 6자 이상 12자 이하의 영문, 혹은 영문+숫자의 조합입니다.");
		obj.id.focus();
		return false;
	}
	
	if(obj.pass.value ==""){
		alert("비밀번호를 반드시 입력하세요.");
		obj.pass.focus();
		return false;
	}
	
	if(!regex.test(obj.pass.value)){
		alert("비밀번호는 8~15자 영문(대소문자), 숫자, 특수문자를 사용하세요.");
		obj.pass.focus();
		return false;
	}
	
	if(obj.pass.value.search(obj.id.value) > -1){
		alert("비밀번호에는 아이디가 포함될 수 없습니다.");
		return false;
	}
	
	if(obj.passwordCheck.value ==""){
		alert("비밀번호 확인란에 입력해주세요.");
		obj.passwordCheck.focus();
		return false;
	}
	
	if(obj.pass.value != obj.passwordCheck.value){
		alert("입력하신 비밀번호가 같지 않습니다.");
		obj.passwordCheck.focus();
		return false;
	}
	
	if(obj.name.value ==""){
		alert("이름을 반드시 입력하세요.");
		obj.name.focus();
		return false;
	}
	
	if(obj.email.value ==""){
		alert("이메일을 입력하세요.");
		obj.email.focus();
		return false;
	}
	alert("회원가입이 완료되었습니다. 로그인 후 이용해주세요.")
}

function idCheck(){
	let inputid = document.getElementById("checkid").value;
	console.log(inputid);
	
	if(inputid ==""){
		alert("아이디를 반드시 입력하세요.");
		inputid.focus();
		return false;
	}else{
		$.ajax({
		type:"POST",
		url:"idcheck",
		data:{pid:inputid},
		success:function(resp){
			console.log("서버 응답:", resp);
			if(resp>0){
				alert("이미 사용중인 ID 입니다.");
				let url = "idCheck";
				window.open(url, "", "width=400, height=200");
			}else{
				if(!pattern.test(inputid)){
					alert("아이디는 6자 이상 12자 이하의 영문, 혹은 영문+숫자의 조합입니다.");
					inputid.focus();
					return false;
				}else{
					alert("사용 가능한 ID 입니다.");
				}
			}
		}
		})
	}
}

function idCheck2(){
	let inputid = document.getElementById("inputid").value;
	console.log("idcheck2: "+inputid);
	
	if(inputid ==""){
		$("#resultmessage").html("아이디를 반드시 입력하세요.");
		return false;
	}else{
		$.ajax({
			type:"POST",
			url:"idCheck",
			data:{pid:inputid},
			success:function(resp){
				console.log("서버 응답2:", resp);  
				if(resp>0){
					$("#resultmessage").html("이미 사용중인 ID 입니다.")
					$("#resultmessage").css("color", "red");
				}else{
					if(!pattern.test(inputid)){
						$("#resultmessage").html("아이디는 6자 이상 12자 이하의 영문, 혹은 영문+숫자의 조합입니다.");
						return false;
					}else{
						$("#resultmessage").html("사용 가능한 ID 입니다.")
						$("#close-btn").text("사용하기");
						$("#resultmessage").css("color", "blue");
						if (opener && opener.joinForm) {
						  opener.joinForm.checkid.value = inputid;//부모 창으로 되돌아갔을 때 inputid값을 checkid에 저장
						}
					}
				}
			}
		})
	}
}