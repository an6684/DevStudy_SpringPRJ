package dev.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dev.board.BSearchVO;
import dev.board.BoardVO;
import dev.lecture.LSearchVO;
import dev.main.VideoVO;
import dev.member.MemberVO;

@Service
public class AdminSvc {
	
	@Autowired
	AdminMapper adminMapper;
	
	public int getUserCount(USearchVO uv) {
		return adminMapper.getUserCount(uv);
	}
	
	public List<MemberVO> userList(USearchVO uv){
		return adminMapper.userList(uv);
	}
	
	public List<BoardVO> adminBoardList(BSearchVO bv){
		return adminMapper.adminBoardList(bv);
	}
	
	public int adminVideoCount(LSearchVO param) {
		return adminMapper.adminVideoCount(param);
	}
	
	public List<VideoVO> adminVideoList(LSearchVO param){
		return adminMapper.adminVideoList(param);
	}
}
