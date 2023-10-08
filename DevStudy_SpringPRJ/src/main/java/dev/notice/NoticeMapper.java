package dev.notice;

import java.util.List;

public interface NoticeMapper {
	int getCount(SearchVO sv);
	
	List<NoticeVO> noticeList(SearchVO sv);
	
	int delNotice(int id);
	
	int regeditNotice(NoticeVO param);
	
	NoticeVO noticeDetail(int param);
	
	int updateNotice(NoticeVO param);
	
	int insertComment(NtCommentVO param);
	
	List<NtCommentVO> commentList(int param);
	
	int updateComment(NtCommentVO param);
	
	int delComment(int id);
}
