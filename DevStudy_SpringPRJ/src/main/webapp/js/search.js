const sectionWrap = document.getElementById('card-box'),
	contentBox = document.querySelector('#card-box article'),
	guideText = document.createElement('span');

if (contentBox.innerText == '') {
	sectionWrap.style.backgroundColor = "#fff";
	sectionWrap.style.height = '500px'
	guideText.innerHTML = '검색된 결과가 없습니다.';
	sectionWrap.append(guideText);
	guideText.style.textAlign = 'center';
} 