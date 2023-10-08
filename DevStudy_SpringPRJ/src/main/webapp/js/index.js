
const scrollLeft = document.querySelectorAll('.left'),
	scrollRight = document.querySelectorAll('.right'),
	scrollBox = document.querySelectorAll('.scroll-box'),
	urlCards = document.querySelectorAll('.url-card');


// scoll event handler
for (let i = 0; i < scrollLeft.length; i++) {
	scrollLeft[i].addEventListener("click", e => {
		scrollBox[i].scrollLeft -= 40;

		if (scrollBox[i].scrollLeft == 0)
			e.target.classList.add('hidden');
		// left 버튼 handler
		else if (scrollBox[i].scrollLeft < (scrollBox[i].scrollWidth - scrollBox[i].clientWidth) - 40) {
			scrollRight[i].classList.remove('hidden');
		}
	});
}
for (let i = 0; i < scrollRight.length; i++) {
	scrollRight[i].addEventListener("click", (e) => {
		scrollBox[i].scrollLeft += 40;

		if (scrollBox[i].scrollLeft)
			scrollLeft[i].classList.remove('hidden');
		// right 버튼 handler
		if (scrollBox[i].scrollLeft == (scrollBox[i].scrollWidth - scrollBox[i].clientWidth))
			e.target.classList.add('hidden');
	});
}

