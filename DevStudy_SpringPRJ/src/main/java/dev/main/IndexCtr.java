package dev.main;


import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
public class IndexCtr {
	
	@Autowired
	IndexSvc indexSvc;
	
	@Autowired
	ServletContext servletContext;
	
	/**
     * main page. 
     */
    @RequestMapping(value = "/devstudy")
    public String index(HttpServletRequest request, ModelMap modelMap, MenuVO mv, VideoVO vv) {

    	//category
    	List<MenuVO> mvList = indexSvc.menuList(mv);
    	//video list
    	List<VideoVO> vvList = indexSvc.videoList(vv);
    	
    	modelMap.addAttribute("videos", vvList);
    	servletContext.setAttribute("subject", mvList);
    	
        return "main/index";
    }
    
    @RequestMapping(value = "logout")
    public String logout(HttpServletRequest request, ModelMap modelMap) {
    	HttpSession session = request.getSession();
    	session.invalidate();
    	
    	return "redirect:/devstudy";
    }
    
    /**
     * education page. 
     */
    @RequestMapping(value = "education")
    public String educationPage(HttpServletRequest request, ModelMap modelMap) {
    	String id2 = request.getParameter("id");
		int contentid = Integer.parseInt(id2);

		String gid2 = request.getParameter("group");
		int categoryid = Integer.parseInt(gid2);
		
		VideoVO vv = indexSvc.getVideo(contentid);
		
    	//video list
    	List<VideoVO> smallList = indexSvc.smallList(categoryid);
    	
    	
    	modelMap.addAttribute("video", vv);
    	modelMap.addAttribute("subMenu", smallList);
    	
        return "main/education";
    }
    
    /**
     * category page. 
     */
    @RequestMapping(value = "category")
    public String categoryPage(HttpServletRequest request, ModelMap modelMap, VideoVO vv) {
    	String id2 = request.getParameter("id");
		int contentid = Integer.parseInt(id2);
		
    	//video list
    	List<VideoVO> smallList = indexSvc.smallList(contentid);
    	
    	modelMap.addAttribute("videos", smallList);
    	
        return "main/search";
    }
    
    /**
     * category page. 
     */
    @RequestMapping(value = "category", method = RequestMethod.POST)
    public String searchPage(HttpServletRequest request, ModelMap modelMap, VideoVO vv) {
    	String search = request.getParameter("search");
		
    	//search list
    	List<VideoVO> searchList = indexSvc.searchList(search);
    	
    	modelMap.addAttribute("videos", searchList);
    	
        return "main/search";
    }
    
    /**
     * 관심목록 토글 버튼 기능
     */
    @PostMapping("/toggleCart")
    @ResponseBody
    public String toggleCart(@RequestParam("videoId") int videoId) {
        // 클라이언트에서 전달한 videoId를 사용
        // VideoVO 객체를 생성하고 id 필드를 설정
        VideoVO videoVO = new VideoVO();
        videoVO.setId(videoId);
        
        // videoService를 통해 비디오 토글 작업 수행
        String newCartValue = indexSvc.toggleCartValue(videoId);
        
        return newCartValue;
    }
    
}
