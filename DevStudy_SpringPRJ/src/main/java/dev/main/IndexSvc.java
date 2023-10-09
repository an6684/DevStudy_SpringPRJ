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
	
	public String toggleCartValue(CartVO cv) {
        String user_id = cv.getUser_id(); 
        int video_id = cv.getId(); 

        CartVO existingCart = indexMapper.selectCart(cv);

        if (existingCart == null) {
            // 관심목록에 없으면 추가
            indexMapper.insertToCart(cv);
            return "Y";
        } else {
            // 이미 관심목록에 있으면 삭제
            indexMapper.deleteFromCart(cv);
            return "N";
        }
    }
	
	public List<VideoVO> cartList(String param){
		return indexMapper.cartList(param);
	}
	
	public String selectCart(CartVO cv) {
		String user_id = cv.getUser_id(); 
        int video_id = cv.getId(); 

        CartVO existingCart = indexMapper.selectCart(cv);

        if (existingCart == null) {
            return "Y";
        } else {
            return "N";
        }
	}
}
