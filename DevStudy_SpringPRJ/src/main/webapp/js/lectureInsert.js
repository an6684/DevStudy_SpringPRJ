// 아이콘 클릭 시 비디오 썸네일 변경
function addVideoLink() {
		const link = document.getElementById('link');
		const video = document.getElementById('video');
		const addBtn = document.getElementById('add-button');
		addBtn.addEventListener('click', () => {
			video.src = "https://img.youtube.com/vi/"+link.value+"/maxresdefault.jpg";
		})
}		
// title, description 입력 시 글자 수 길이 변경
function charControl(content, length, msg) {
	if(content.value.trim().length > length) {
		content.value = content.value.slice(0, -1);
		alert(msg)
	}
}
// title, description
const input = document.getElementsByClassName('content-input');
const count = document.getElementsByClassName('content-count');		
const length = [30, 50];
// DB의 최대 길이 수에 맞춰서 길이 수 제한
function inputLengthHandler(){
	for(let i=0; i<input.length; i++) {
		input[i].addEventListener('keydown', e => {
			if(!i)
				charControl(input[0], length[i], '최대 30글자까지 입력할 수 있습니다.')
			else 
				charControl(input[i], length[i], '최대 50글자까지 입력할 수 있습니다.')
					
			count[i].innerText = '';
			count[i].innerText = `${e.target.value.length} / ${length[i]}`
			})
		}
}
// 수정기능으로 접근 시 글자 수, 옵션 셋팅
function updateInputHandler(value) {
	for(let i=0; i<input.length; i++) 
		count[i].textContent = `${input[i].value.length} / ${length[i]}`;
		
	const select = document.getElementsByTagName('select')[0];
	for(let i=0; i<select.options.length; i++) {
		if(select.options[i].value === value) select.options[i].selected = true;
	}
}

function submit() {
	const updateForm = document.getElementById('update-form');
	const content = document.getElementsByClassName('input');
	// 빈 값이 있을 경우 alert를 사용하기 위한 상태변수 
	let isEmptyContent = false; 
		
	updateForm.addEventListener('submit', e => {		
		for(let i=0; i<content.length; i++) {
			if(!content[i].value) {
				e.preventDefault();
				content[i].focus();
				isEmptyContent = false
				} else isEmptyContent = true;
		}
		if(!isEmptyContent) {
			alert('빈칸을 모두 입력해주세요.');
			isEmptyContent = false
			}	
		})
}
export {
	addVideoLink,
	inputLengthHandler,
	submit,
	updateInputHandler,
}