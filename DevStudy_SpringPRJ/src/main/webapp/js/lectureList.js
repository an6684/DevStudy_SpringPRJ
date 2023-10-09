function deleteVideo() {
	const deleteButton = document.getElementsByClassName('delete-button');arguments
	
	for(let item of deleteButton) {
		item.addEventListener('click', e => {
			if(!confirm('동영상을 삭제하시겠습니까?')) e.preventDefault();
		})
	}
}

export {
	deleteVideo,
}