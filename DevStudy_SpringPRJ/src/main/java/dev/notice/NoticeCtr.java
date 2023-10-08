package dev.notice;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.io.OutputStream;
import java.net.URLEncoder;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import dev.main.IndexSvc;
import dev.main.MenuVO;

@Controller
public class NoticeCtr {
	
    @Autowired
    ServletContext servletContext;
    
	@Autowired
	NoticeSvc noticeSvc;
	
	/**
	 * 공지사항 list
	 */
	@RequestMapping(value = "notice")
	public String noticeList(HttpServletRequest request, ModelMap modelMap, HttpSession session, SearchVO sv) {
		String userid = (String) session.getAttribute("userid");
		String userrank = (String) session.getAttribute("userrank");
		if (sv.getQ() == null) {
			sv.setQ("");
		}
		sv.setP2(1);
		
		if(sv.getP() != null && !sv.getP().equals("")) {
			sv.setP2(Integer.parseInt(sv.getP()));
		}
		List<NoticeVO> list = noticeSvc.noticeList(sv);
		
		int count = noticeSvc.getCount(sv);
		
		//삭제버튼 나오게 하기
        if("1".equals(userrank)){
        	request.setAttribute("userRank", "1");
            
        } else {
        	request.setAttribute("userRank", "2");
        }
        
        modelMap.addAttribute("userid", userid);
        modelMap.addAttribute("userrank", userrank);
        modelMap.addAttribute("noticeList", list);
        modelMap.addAttribute("count",count);
        
		return "board/news";
	}
	
	/**
	 * 공지사항 삭제
	 */
	@RequestMapping(value = "delete")
	public String delNotice(HttpServletRequest request, ModelMap modelMap, HttpSession session, NoticeVO nv) {
		String id2 = request.getParameter("id");
		int id = Integer.parseInt(id2);
		
		noticeSvc.delNotice(id);
		return "redirect:notice";
	}
	
	/**
	 * 공지사항 작성화면
	 */
	@RequestMapping(value = "writeNews", method = RequestMethod.GET)
	public String writeNews(HttpServletRequest request, ModelMap modelMap, HttpSession session) {
		String userid = (String) session.getAttribute("userid");
		String userrank = (String) session.getAttribute("userrank");
		
		modelMap.addAttribute("userid", userid);
		modelMap.addAttribute("userrank", userrank);
		
		return "board/admin_write";
	}
	
	/**
	 * 공지사항 작성
	 */
	@RequestMapping(value = "regedit", method = RequestMethod.POST)
	public String regeditNotice(HttpServletRequest request, ModelMap modelMap, HttpSession session, NoticeVO nv, 
			@RequestParam(value = "uploadFile", required = false) MultipartFile file) throws Exception {
		nv.setWritedid((String) request.getSession().getAttribute("userid"));
		if (file != null && !file.isEmpty()) {

			String fileName = file.getOriginalFilename();
			String realPath = servletContext.getRealPath("upload");
			String filepath = realPath + File.separator + fileName;
	        String saveFolder = realPath + File.separator;

			File folder = new File(saveFolder);
			if(!folder.exists())
	            folder.mkdirs();

			System.out.println("a : " +fileName );
			System.out.println("b : " +realPath );
			System.out.println("c : " +filepath );
			
			InputStream ism = file.getInputStream();
			FileOutputStream fos = new FileOutputStream(filepath);
			
			byte[] buf = new byte[1024];
			int size = 0;
			while ((size = ism.read(buf)) != -1) {
				fos.write(buf, 0, size);
			}

			fos.close();
			ism.close();
			
			System.out.println("filename : " + fileName);
			System.out.println("getname : " + filepath);

			nv.setFilepath(fileName);
		}
		noticeSvc.regeditNotice(nv);
		
		return "redirect:notice";
	}
	
	/**
	 * 공지사항 detail 화면
	 */
	@RequestMapping(value = "noticeDetail")
	public String noticeDetail(HttpServletRequest request, ModelMap modelMap, HttpSession session) {
		String userid = (String) session.getAttribute("userid");
		String id2 = request.getParameter("id");
		int contentid = Integer.parseInt(id2);
		
		NoticeVO nt = noticeSvc.noticeDetail(contentid);
		List<NtCommentVO> cmList = noticeSvc.commentList(contentid);
		
		//게시글 id 세션
		session.setAttribute("contentId", id2);
		
		modelMap.addAttribute("userid", userid);
		modelMap.addAttribute("nt", nt);
		modelMap.addAttribute("cmList", cmList);
		
		return "board/notice_detail";
	}
	
	/**
	 * 공지사항 댓글 작성
	 */
	@RequestMapping(value = "comment", method = RequestMethod.POST)
	public String insertComment(HttpServletRequest request, @RequestParam String content) {
		NtCommentVO cm = new NtCommentVO();
		
		String id = request.getParameter("id");
		System.out.println("comment id: "+id);
		
		cm.setContent(content);
		cm.setContent_id(Integer.parseInt(id));
		cm.setWritedid((String) request.getSession().getAttribute("userid"));
		noticeSvc.insertComment(cm);
		return "redirect:noticeDetail"+"?id="+id;
	}
	
	/**
	 * 공지사항 댓글 수정
	 */
	@RequestMapping(value = "updateComment", method = RequestMethod.POST)
	public String updateComment(HttpServletRequest request, ModelMap modelMap, HttpSession session, NtCommentVO cm, @RequestParam String content) {
		String id2 = request.getParameter("comment_id");
		int id = Integer.parseInt(id2);
		
		String contentId = (String) request.getSession().getAttribute("contentId");
		int contentid = Integer.parseInt(contentId);
		
		cm.setContent_id(contentid);
		cm.setComment_id(id);
		cm.setContent(content);
		noticeSvc.updateComment(cm);
		
		return "redirect:noticeDetail"+"?id="+contentId;
	}
	
	/**
	 * 공지사항 댓글 삭제
	 */
	@RequestMapping(value = "deleteComment")
	public String deleteComment(HttpServletRequest request, ModelMap modelMap, HttpSession session) {
		String id2 = request.getParameter("id");
		int id = Integer.parseInt(id2);
		
		String contentId = (String) request.getSession().getAttribute("contentId");
		
		noticeSvc.delComment(id);
		return "redirect:noticeDetail"+"?id="+contentId;
	}
	
	@RequestMapping(value = "/notice/download/{filename:.+}", method = RequestMethod.GET)
	public void downloadFile(HttpServletRequest request, HttpServletResponse response, @PathVariable("filename") String filename) throws IOException {
	    // 서버의 파일 실제 경로 가져오기
	    String realPath = servletContext.getRealPath("upload");
	    String filepath = realPath + File.separator + filename;

	    String encodedFilename = URLEncoder.encode(filename, "UTF-8");
	    // 응답을 위한 콘텐츠 유형과 헤더 속성을 설정
	    response.setContentType("application/octet-stream");
	    response.setHeader("Content-Disposition", "attachment; filename=\"" + encodedFilename + "\"");

	    // 파일을 읽고 응답 출력 스트림에 쓰기 위해 try-with-resources를 사용
	    try (InputStream is = new FileInputStream(filepath); OutputStream os = response.getOutputStream()) {
	        byte[] buffer = new byte[1024];
	        int bytesRead;
	        while ((bytesRead = is.read(buffer)) != -1) {
	            os.write(buffer, 0, bytesRead);
	        }
	    }
	}
	
	/**
	 * 공지사항 modify 화면
	 */
	@RequestMapping(value = "noticeModify")
	public String noticeModify(HttpServletRequest request, ModelMap modelMap, HttpSession session){
		String id2 = request.getParameter("id");
		int contentid = Integer.parseInt(id2);
		
		NoticeVO nt = noticeSvc.noticeDetail(contentid);
		
		modelMap.addAttribute("nt", nt);
		
		return "board/notice_modify";
	}

	/**
	 * 공지사항 modify 처리
	 */
	@RequestMapping(value = "noticeModify", method = RequestMethod.POST)
    public String modifyNotice(HttpServletRequest request, ModelMap modelMap, HttpSession session, NoticeVO nv,
            @RequestParam(value = "uploadFile", required = false) MultipartFile file,
            @RequestParam(value = "filepath", required = false) String deleteFile) throws Exception {
		
		String id2 = request.getParameter("content_id");
		int contentid = Integer.parseInt(id2);
		nv.setContent_id(contentid);
        System.out.println("content_id: "+nv.getContent_id());
        System.out.println("deleteFile: "+deleteFile);
        
        //파일을 삭제하고 제목과 컨텐츠를 수정할 경우
        if((file == null) && ((deleteFile == null) || (deleteFile == ""))){
        	nv.setFilepath("");
        }
        
        //제목과 컨텐츠만 수정할 경우
        if ((deleteFile != null && !deleteFile.isEmpty())&&(file==null)) {
            nv.setFilepath(deleteFile);
        }
        
        // 새 파일 업로드
        if (file != null && !file.isEmpty()) {
        	// 기존 파일 삭제
            if (deleteFile != null && !deleteFile.isEmpty()) {
                String realPath = servletContext.getRealPath("upload");
                String filePath = realPath + File.separator + deleteFile;
                File existingFile = new File(filePath);
                if (existingFile.exists() && existingFile.isFile()) {
                    existingFile.delete();
                }
                nv.setFilepath("");
            }
        	
        	String fileName = file.getOriginalFilename();
			String realPath = servletContext.getRealPath("upload");
			String filepath = realPath + File.separator + fileName;
	        String saveFolder = realPath + File.separator;

			File folder = new File(saveFolder);
			if(!folder.exists())
	            folder.mkdirs();

			System.out.println("a : " +fileName );
			System.out.println("b : " +realPath );
			System.out.println("c : " +filepath );
			
			InputStream ism = file.getInputStream();
			FileOutputStream fos = new FileOutputStream(filepath);
			
			byte[] buf = new byte[1024];
			int size = 0;
			while ((size = ism.read(buf)) != -1) {
				fos.write(buf, 0, size);
			}

			fos.close();
			ism.close();

            nv.setFilepath(fileName);
        }
        // 공지사항 수정
        noticeSvc.updateNotice(nv);

        return "redirect:noticeDetail?id="+id2;
    }
	
	@RequestMapping(value = "deleteFile", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<String> deleteFile(HttpServletRequest request,
	        @RequestParam("filename") String filename, 
	        @RequestParam("PContId") String PContId,
	        @RequestParam("PTitle") String PTitle,
	        @RequestParam("PContent") String PContent) {
	    String realPath = servletContext.getRealPath("upload");
	    String filePath = realPath + File.separator + filename;
	    System.out.println("conId: "+PContId);
	    
	    File existingFile = new File(filePath);
	    if (existingFile.exists() && existingFile.isFile()) {
	        existingFile.delete();
	        
	        NoticeVO nv = new NoticeVO();
		    nv.setContent_id(Integer.parseInt(PContId));
		    nv.setTitle(PTitle);
		    nv.setContent(PContent);
		    nv.setFilepath("");
		    noticeSvc.updateNotice(nv);
		    System.out.println("pconid: "+nv.getContent_id());
		    System.out.println("delfilepath: " + nv.getFilepath());
	        return new ResponseEntity<>("File deleted successfully.", HttpStatus.OK);
	    } else {
	        return new ResponseEntity<>("File not found.", HttpStatus.NOT_FOUND);
	    }
	}

	
}
