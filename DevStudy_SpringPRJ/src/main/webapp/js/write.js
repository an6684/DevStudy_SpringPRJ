/*
	작성자 : 강문호
	기능 : 게시판 작성 유효성 검사
	Git : https://github.com/whiteDwarff
*/
const submitTest = (selector, num) => selector.value.length < num;
const changeStyle = (selector, textColor, message = '') => {
	selector.style.border = `1px solid ${textColor}`;
	if (message != '') alert(message);
}

const tit = document.getElementById('tit'),
	cnt = document.getElementById('content');

document.getElementById('submitForm').addEventListener('submit', e => {

	if (submitTest(tit, 1)) {
		changeStyle(tit, '#73d09a', '제목을 입력하세요.');
		e.preventDefault();
	} else if (submitTest(tit, 5)) {
		changeStyle(tit, '#73d09a', '제목은 5글자 이상 입력하세요.');
		e.preventDefault();
	} else if (submitTest(cnt, 1)) {
		changeStyle(cnt, '#73d09a', '내용을 입력하세요.');
		e.preventDefault();
	} else if (submitTest(cnt, 10)) {
		changeStyle(cnt, '#73d09a', '내용은 10글자 이상 입력하세요.');
		e.preventDefault();
	}
})

tit.addEventListener('keydown', e => {
	if (e.target.value.length > 4) changeStyle(e.target, '#000');
})
cnt.addEventListener('keydown', e => {
	if (e.target.value.length > 9) changeStyle(e.target, '#000');
});
