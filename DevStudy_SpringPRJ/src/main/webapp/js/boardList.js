// pageNation handeler
function currentPaging(num) {
	const pageNumber = document.getElementsByClassName('page-num');
	for(let item of pageNumber) 
		if(num == item.textContent) item.classList.add('currentPage');
}

function hiddenPrevButton(num) {
	const prev = document.getElementById('prev');
	return !num || num <= 1 ? prev.classList.add('hidden') : '';
}
function hiddenNextButton(currentNum, lastNum) {
	const next = document.getElementById('next');
	return currentNum == lastNum ? next.classList.add('hidden') : '';
}
// select option을 선택하면 selected 옵션 설정
function selectOptionHandelr(option) {
	const alignOption = document.getElementsByClassName('align-option');
	for(let item of alignOption) 
		if(typeof item.value == 'number' && parseInt(item.value) == parseInt(option)) {
			item.selected = true;
		} else {
			if(item.value == option) item.selected = true;
		}
}
// submit handler
function searchBoardList() {
	let submitForm = document.getElementById('search-form');
	submitForm.addEventListener('submit', e => {
		let input = document.getElementById('form-value');
		if(input.value === '') {
			e.preventDefault();
			alert('검색어를 입력해주세요');
			input.focus();
		}
	})
}

export {
	currentPaging,
	hiddenPrevButton,
	searchBoardList,
	hiddenNextButton,
	selectOptionHandelr,
}