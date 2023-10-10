package dev.lecture;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dev.main.VideoVO;

@Service
public class LectureSvc {

	@Autowired
	LectureMapper lectureMapper;
	
	public int getVideoCount(LSearchVO param) {
		return lectureMapper.getVideoCount(param);
	}
	
	public List<VideoVO> getVideoList(LSearchVO param){
		return lectureMapper.getVideoList(param);
	}

	public int lectureInsert(VideoVO param) {
		return lectureMapper.lectureInsert(param);
	}
}
