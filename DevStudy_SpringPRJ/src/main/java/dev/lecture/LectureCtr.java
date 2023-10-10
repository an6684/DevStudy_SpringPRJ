package dev.lecture;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import dev.board.BSearchVO;
import dev.main.VideoVO;


@Controller
public class LectureCtr {
	
	@Autowired
	LectureSvc lecSvc;
	
	/**
     * lecture page. 
     */
    @RequestMapping(value = "lecture")
    public String lecture(HttpServletRequest request, HttpSession session, ModelMap modelMap, LSearchVO lv) {
    	String userid = (String) session.getAttribute("userid");
    	lv.setUploader_id(userid);
    	
    	if (lv.getQ() == null) {
    		lv.setQ("");
		}
    	lv.setP2(1);
		
		if(lv.getP() != null && !lv.getP().equals("")) {
			lv.setP2(Integer.parseInt(lv.getP()));
		}
		
		List<VideoVO> list=lecSvc.getVideoList(lv);
		int count = lecSvc.getVideoCount(lv);
		
		modelMap.addAttribute("count",count);
		modelMap.addAttribute("videos", list);
    	
        return "lecture/lecture_list";
    }
    
    /**
     * lecture regedit page. 
     */
    @RequestMapping(value = "lectureInsert")
    public String lectureInsert() {
    	
        return "lecture/lecture_insert";
    }
    
    /**
     * 강의 등록 처리
     */
    @RequestMapping(value = "lectureInsert", method = RequestMethod.POST)
    public String insertLecture(HttpServletRequest request, HttpSession session, @RequestParam String title,
    		@RequestParam String description, @RequestParam String link,
    		@RequestParam String url) {
    	String userid = (String) session.getAttribute("userid");
    	int url_num = Integer.parseInt(url);
    	VideoVO vv = new VideoVO();
    	vv.setUploader_id(userid);
    	vv.setTitle(title);
    	vv.setDescription(description);
    	vv.setUrl(link);
    	vv.setCategory_id(url_num);
    	
    	lecSvc.lectureInsert(vv);
    	
        return "redirect:lecture";
    }
}
