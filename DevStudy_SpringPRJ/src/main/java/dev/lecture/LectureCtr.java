package dev.lecture;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class LectureCtr {
	/**
     * lecture page. 
     */
    @RequestMapping(value = "lecture")
    public String lecture(HttpServletRequest request, ModelMap modelMap) {

    	
        return "lecture/lecture_list";
    }
    
    /**
     * lecture regedit page. 
     */
    @RequestMapping(value = "lectureInsert")
    public String insertLecture(HttpServletRequest request, ModelMap modelMap) {

    	
        return "lecture/lecture_insert";
    }
}
