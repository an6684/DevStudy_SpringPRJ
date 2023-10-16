package dev.admin;

import java.util.List;

import dev.board.BSearchVO;
import dev.board.BoardVO;
import dev.lecture.LSearchVO;
import dev.main.VideoVO;
import dev.member.MemberVO;

public interface AdminMapper {
	int getUserCount(USearchVO uv);
	
	List<MemberVO> userList(USearchVO uv);
	
	List<BoardVO> adminBoardList(BSearchVO bv);
	
	int adminVideoCount(LSearchVO param);
	
	List<VideoVO> adminVideoList(LSearchVO param);
}
