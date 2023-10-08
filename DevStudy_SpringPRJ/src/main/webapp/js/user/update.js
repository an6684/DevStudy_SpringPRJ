//비밀번호 정규식
const regex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,15}$/;

function validateForm() {
    let id = document.getElementById('id').value;
    let password = document.getElementById('password').value;
    let newPwd = document.getElementById('newPwd').value;
    let newPwd2 = document.getElementById('newPwd2').value;

		if (password == "") {
            alert('비밀번호를 입력해주세요.');
            return false;
        }
        
		if (newPwd == "" && newPwd2 != "") {
            alert('새 비밀번호를 입력해주세요.');
            return false;
        }

		if (newPwd != "" && newPwd2 == "") {
            alert('새 비밀번호를 확인란에 입력해주세요.');
            return false;
        }
		
		if(!regex.test(newPwd) && newPwd != ""){
			alert("비밀번호는 8~15자 영문 대소문자, 숫자, 특수문자를 사용하세요.");
			return false;
		}
		
		 if (newPwd.includes(id)) {
	        alert("비밀번호에는 아이디가 포함될 수 없습니다.");
	        return false;
	    }
		
		if (newPwd == password) {
			alert('기존의 비밀번호와 다른 비밀번호를 사용해주세요.');
			return false;
		}

		if (newPwd !== newPwd2) {
			alert('새 비밀번호가 일치하지 않습니다.');
			return false;
		}
		alert('회원정보가 정상적으로 수정되었습니다.');
	}
//전화번호 자동 하이픈 정규식
$(document).on("keyup", ".phoneNumber", function() { 
	$(this).val( $(this).val().replace(/[^0-9]/g, "").replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/,"$1-$2-$3").replace("--", "-") );
});
