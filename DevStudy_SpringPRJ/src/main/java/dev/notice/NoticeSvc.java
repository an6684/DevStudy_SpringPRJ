package dev.notice;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class NoticeSvc {
	
	@Autowired
	NoticeMapper noticeMapper;
	
	public int getCount(SearchVO sv) {
		return noticeMapper.getCount(sv);
	}
	
	public List<NoticeVO> noticeList(SearchVO sv){
		return noticeMapper.noticeList(sv);
	}
	
	public int delNotice(int id) {
		return noticeMapper.delNotice(id);
	}
	
	public int regeditNotice(NoticeVO param) {
		return noticeMapper.regeditNotice(param);
	}
	
	public NoticeVO noticeDetail(int no) {
		return noticeMapper.noticeDetail(no);
	}
	
	public int updateNotice(NoticeVO param) {
		return noticeMapper.updateNotice(param);
	}
	
	public int insertComment(NtCommentVO cm) {
		return noticeMapper.insertComment(cm);
	}
	
	public List<NtCommentVO> commentList(int no){
		return noticeMapper.commentList(no);
	}
	
	public int updateComment(NtCommentVO param) {
		return noticeMapper.updateComment(param);
	}
	
	public int delComment(int id) {
		return noticeMapper.delComment(id);
	}
}
