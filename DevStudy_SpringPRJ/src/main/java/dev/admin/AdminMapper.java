package dev.admin;

import java.util.List;

import dev.board.BSearchVO;
import dev.board.BoardVO;
import dev.member.MemberVO;

public interface AdminMapper {
	int getUserCount(USearchVO uv);
	
	List<MemberVO> userList(USearchVO uv);
	
	List<BoardVO> adminBoardList(BSearchVO bv);
}
