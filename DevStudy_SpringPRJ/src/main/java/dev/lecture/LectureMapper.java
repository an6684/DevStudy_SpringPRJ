package dev.lecture;

import java.util.List;

import dev.main.VideoVO;

public interface LectureMapper {
	int getVideoCount(LSearchVO param);
	
	List<VideoVO> getVideoList(LSearchVO param);
	
	int lectureInsert(VideoVO param);
	
	int lectureUpdate(VideoVO param);
}
