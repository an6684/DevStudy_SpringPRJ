package dev.board;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BoardSvc {
	
	@Autowired
	BoardMapper boardMapper;
	
	public int getCount(BSearchVO bv) {
		return boardMapper.getCount(bv);
	}
	
	public List<BoardVO> boardList(BSearchVO bv){
		return boardMapper.boardList(bv);
	}
	
	public int regeditBoard(BoardVO param) {
		return boardMapper.regeditBoard(param);
	}
	
	public int delBoard(int id) {
		return boardMapper.delBoard(id);
	}
	
	public BoardVO boardDetail(int no) {
		return boardMapper.boardDetail(no);
	}
	
	public int updateBoard(BoardVO param) {
		return boardMapper.updateBoard(param);
	}
	
	public int insertComment(BdCommentVO param) {
		return boardMapper.insertComment(param);
	}
	
	public List<BdCommentVO> commentList(int param){
		return boardMapper.commentList(param);
	}
	
	public int updateComment(BdCommentVO param) {
		return boardMapper.updateComment(param);
	}
	
	public int delComment(int id) {
		return boardMapper.delComment(id);
	}
	
}
