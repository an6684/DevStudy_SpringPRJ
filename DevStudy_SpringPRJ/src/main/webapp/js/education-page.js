function currentVideo() {
	const mainTitle = document.getElementsByClassName('url-title')[0];
	const subTitle = document.getElementsByClassName('sub-url-title');

	for (let i = 0; i < subTitle.length; i++) {
		let subList = document.getElementsByClassName('sub-list');
		if (subTitle[i].innerText == mainTitle.innerText) {
			subList[i].style.backgroundColor = 'rgb(235 235 235)';
			break;
		}
	}
}
