package dev.board;

import java.util.List;

public interface BoardMapper {
	int getCount(BSearchVO bv);
	
	List<BoardVO> boardList(BSearchVO bv);
	
	int regeditBoard(BoardVO param);
	
	int delBoard(int id);
	
	BoardVO boardDetail(int param);
	
	int updateBoard(BoardVO param);
	
	int insertComment(BdCommentVO param);
	
	List<BdCommentVO> commentList(int param);
	
	int updateComment(BdCommentVO param);
	
	int delComment(int id);
}
