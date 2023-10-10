package dev.admin;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import dev.board.BSearchVO;
import dev.board.BoardSvc;
import dev.board.BoardVO;
import dev.member.MemberVO;
import dev.notice.NoticeSvc;
import dev.notice.NoticeVO;
import dev.notice.SearchVO;

@Controller
public class AdminCtr {
	
	@Autowired
	AdminSvc admSvc;
	
	@Autowired
	NoticeSvc noticeSvc;
	
	@Autowired
	BoardSvc boardSvc;
	
	/**
	 * 회원 관리 리스트
	 */
	@RequestMapping(value = "userList")
	public String userList(ModelMap modelMap, USearchVO uv) {
		
		if (uv.getQ() == null) {
			uv.setQ("");
		}
		uv.setP2(1);
		
		if(uv.getP() != null && !uv.getP().equals("")) {
			uv.setP2(Integer.parseInt(uv.getP()));
		}
		
		List<MemberVO> list=admSvc.userList(uv);
		int count = admSvc.getUserCount(uv);
		
		modelMap.addAttribute("count",count);
		modelMap.addAttribute("userList",list);
		
		return "admin/user_list";
	}
	
	/**
	 * 공지사항 관리 리스트
	 */
	@RequestMapping(value = "nList")
	public String BList(HttpServletRequest request, ModelMap modelMap, HttpSession session, SearchVO sv) {
		
		if (sv.getQ() == null) {
			sv.setQ("");
		}
		sv.setP2(1);
		
		if(sv.getP() != null && !sv.getP().equals("")) {
			sv.setP2(Integer.parseInt(sv.getP()));
		}
		
		List<NoticeVO> list=noticeSvc.noticeList(sv);
		int count = noticeSvc.getCount(sv);
		
		modelMap.addAttribute("count",count);
		modelMap.addAttribute("noticeList",list);
		
		return "admin/notice_list";
	}
	
	/**
	 * 공지사항 삭제
	 */
	@RequestMapping(value = "ndelete")
	public String delNotice(HttpServletRequest request, ModelMap modelMap, HttpSession session, NoticeVO nv) {
		String id2 = request.getParameter("id");
		int id = Integer.parseInt(id2);
		
		noticeSvc.delNotice(id);
		return "redirect:nList";
	}
	
	/**
	 * 게시판 관리 리스트
	 */
	@RequestMapping(value = "bList")
	public String BList(HttpServletRequest request, ModelMap modelMap, HttpSession session, BSearchVO bv) {
		
		if (bv.getQ() == null) {
			bv.setQ("");
		}
		bv.setP2(1);
		
		if(bv.getP() != null && !bv.getP().equals("")) {
			bv.setP2(Integer.parseInt(bv.getP()));
		}
		
		List<BoardVO> list=admSvc.adminBoardList(bv);
		int count = boardSvc.getCount(bv);
		
		modelMap.addAttribute("count",count);
		modelMap.addAttribute("boardeList",list);
		
		return "admin/board_list";
	}
	
	/**
	 * 게시글 삭제
	 */
	@RequestMapping(value = "bdelete")
	public String delBoard(HttpServletRequest request, ModelMap modelMap, HttpSession session, BoardVO bv) {
		String id2 = request.getParameter("id");
		int contentid = Integer.parseInt(id2);
		
		boardSvc.delBoard(contentid);
		
		return "redirect:bList";
	}
}
