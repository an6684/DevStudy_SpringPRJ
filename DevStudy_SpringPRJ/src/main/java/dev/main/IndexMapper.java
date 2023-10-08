package dev.main;

import java.util.List;

public interface IndexMapper {
	List<MenuVO> menuList(MenuVO param);
	
	List<VideoVO> videoList(VideoVO param);
	
	VideoVO getVideo(int param);

	List<VideoVO> smallList(int param);
	
	List<VideoVO> searchList(String param);
	
	String selectCartValue(int param);
	
	int toggleCartValue(int param);
}
