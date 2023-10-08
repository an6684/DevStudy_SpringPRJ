const headerImage = document.getElementsByClassName('header-image'),
			headerWrap = document.getElementsByClassName('header-slide-wrap'),
			section = document.getElementsByTagName('section'),
			headerSerachFrom = document.getElementById('header-search-form'),
			header = document.getElementsByTagName('header')[0],
			headerSearchInput = document.getElementById('header-search-input');
let isHeaderState = true;



for(let i=0; i<headerImage.length; i++) {
	headerImage[i].addEventListener('click', () => {
		
		for(let item of headerWrap) item.classList.remove('block')
		
		if(isHeaderState) {
			headerWrap[i].classList.add('block');
			for(let item of section) item.style.filter = 'blur(7px)';
			header.style.backgroundColor = '#fff';
		} else {
			headerWrap[i].classList.remove('block');
			isHeaderState = false;
			for(let item of section) item.style.filter = 'none';
			header.style.backgroundColor = 'rgb(244, 244, 244, 0.5)';
		}
		isHeaderState = !isHeaderState;
		console.log(isHeaderState);
		
	})
}

let subToggle=true;
$(".menu").click(()=>{
  if(subToggle){
    $(".sub").slideDown(1000);
  }else{
    $(".sub").slideUp(1000);
  }
  subToggle=!subToggle;
});

$(document).ready(function() {
    // 스크롤 탑 버튼 클릭 이벤트 처리
    $("#swipe-btn").click(function() {
        $("html, body").animate({ scrollTop: 0 }, "slow");
    });

    // 스크롤 위치에 따라 버튼 표시/숨김
    $(window).scroll(function() {
        if ($(this).scrollTop() > 100) {
            $("#swipe-btn").fadeIn();
        } else {
            $("#swipe-btn").fadeOut();
        }
    });
});