package dev.main;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class IndexSvc {
	
	@Autowired
	IndexMapper indexMapper;
	
	public List<MenuVO> menuList(MenuVO param){
		return indexMapper.menuList(param);
	}
	
	public List<VideoVO> videoList(VideoVO param){
		return indexMapper.videoList(param);
	}
	
	public VideoVO getVideo(int param) {
		return indexMapper.getVideo(param);
	}
	
	public List<VideoVO> smallList(int param){
		return indexMapper.smallList(param);
	}
	
	public List<VideoVO> searchList(String param){
		return indexMapper.searchList(param);
	}
	
	public String toggleCartValue(int param) {
        String currentCartValue = indexMapper.selectCartValue(param);
        String newCartValue = (currentCartValue.equals("Y")) ? "N" : "Y";
        indexMapper.toggleCartValue(param);
        return newCartValue;
    }
}
