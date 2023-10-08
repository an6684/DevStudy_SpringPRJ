/*
	작성자 : 강문호
	기능 : 현재 메뉴와 서브 메뉴의 동영상이 같으면 백그라운드 색상 변경
	Git : https://github.com/whiteDwarff
*/
const mainUrl = document.getElementsByClassName('url-title')[0],
	subUrls = document.getElementsByClassName('sub-url-title'),
	li = document.querySelectorAll('.list li');


for (let i = 0; i < subUrls.length; i++) {
	if (mainUrl.innerText == subUrls[i].innerText) {
		li[i].style.background = 'rgb(244, 244, 244)';
		// li[i].style.border = '1px solid #f00';
	} else {
		li[i].style.backgroundColor = '#fff';
	}
} 
