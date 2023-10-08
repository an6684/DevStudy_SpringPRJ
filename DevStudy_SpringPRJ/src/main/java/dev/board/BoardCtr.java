package dev.board;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
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
import org.springframework.web.util.HtmlUtils;

import dev.main.IndexSvc;
import dev.main.MenuVO;


@Controller
public class BoardCtr {
	
	@Autowired
	ServletContext servletContext;
	
	@Autowired
	BoardSvc boardSvc;
	
	/**
	 * 게시판 list
	 */
	@RequestMapping(value = "board")
	public String boardList(HttpServletRequest request, ModelMap modelMap, HttpSession session, BoardVO bv, BSearchVO sv) {
		String userid = (String) session.getAttribute("userid");
		String userrank = (String) session.getAttribute("userrank");
		if (sv.getQ() == null) {
			sv.setQ("");
		}
		sv.setP2(1);
		
		if(sv.getP() != null && !sv.getP().equals("")) {
			sv.setP2(Integer.parseInt(sv.getP()));
		}
		//List<BoardVO> list=boardSvc.boardList(bv);
		List<BoardVO> list = boardSvc.boardList(sv);
		int count = boardSvc.getCount(sv);
		
		//삭제버튼 나오게 하기
        if("1".equals(userrank)){
        	request.setAttribute("userRank", "1");
            
        } else {
        	request.setAttribute("userRank", "2");
        }
    	
		modelMap.addAttribute("userid", userid);
		modelMap.addAttribute("userrank", userrank);
		modelMap.addAttribute("boardList", list);
		modelMap.addAttribute("count",count);
		
		return "board/board";
	}
	
	/**
	 * 게시글 작성 화면
	 */
	@RequestMapping(value = "writeBoard")
	public String insertBoard(HttpServletRequest request, ModelMap modelMap, HttpSession session) {
		String userid = (String) session.getAttribute("userid");
    	
		modelMap.addAttribute("userid", userid);
		
		return "board/board_write";
	}
	
	/**
	 * 게시글 작성 처리
	 */
	@RequestMapping(value = "regeditBoard")
	public String regeditBoard(HttpServletRequest request, ModelMap modelMap, HttpSession session, BoardVO bv,
			@RequestParam(value = "uploadFile", required = false) MultipartFile file) throws Exception {
		bv.setWritedid((String) session.getAttribute("userid"));
		
		if (file != null && !file.isEmpty()) {

			String fileName = file.getOriginalFilename();
			String realPath = servletContext.getRealPath("boardUpload");
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

			bv.setFilepath(fileName);
		}
		System.out.println("filepath: "+bv.getFilepath());
		boardSvc.regeditBoard(bv);
		
		return "redirect:board";
	}
	
	/**
	 * 게시글 detail
	 */
	@RequestMapping(value = "boardDetail")
	public String boardDetail(HttpServletRequest request, ModelMap modelMap, HttpSession session, BdCommentVO bcm) {
		String id2 = request.getParameter("boardId");
		int contentid = Integer.parseInt(id2);
		
		
		BoardVO bv = boardSvc.boardDetail(contentid);
		List<BdCommentVO> cmList=boardSvc.commentList(contentid);
		
		session.setAttribute("boardId", id2);		
		modelMap.addAttribute("bv", bv);
		modelMap.addAttribute("cmList", cmList);
		
		return "board/board_detail";
	}
	
	/**
	 * 게시글 삭제
	 */
	@RequestMapping(value = "boardDelete")
	public String delBoard(HttpServletRequest request, ModelMap modelMap, HttpSession session, BoardVO bv) {
		String id2 = request.getParameter("boardId");
		int contentid = Integer.parseInt(id2);
		
		boardSvc.delBoard(contentid);
		
		return "redirect:board";
	}
	
	/**
	 *  게시글 modify
	 */
	@RequestMapping(value = "boardModify")
	public String boardModify(HttpServletRequest request, ModelMap modelMap, HttpSession session){
		String id2 = request.getParameter("boardId");
		int contentid = Integer.parseInt(id2);
		
		BoardVO bv = boardSvc.boardDetail(contentid);
		
		modelMap.addAttribute("bd", bv);
		
		return "board/board_modify";
	}
	
	/**
	 * 게시글 modify 처리
	 */
	@RequestMapping(value = "boardModify", method = RequestMethod.POST)
	public String modifyBoard(HttpServletRequest request, ModelMap modelMap, HttpSession session, BoardVO bv,
			@RequestParam(value = "uploadFile", required = false) MultipartFile file,
            @RequestParam(value = "filepath", required = false) String deleteFile) throws Exception{
		String contentId = (String) request.getSession().getAttribute("boardId");
		int boardid = Integer.parseInt(contentId);
		
		bv.setContent_id(boardid);
		System.out.println("content_id: "+bv.getContent_id());
		System.out.println("deleteFile: "+deleteFile);
		
		//파일을 삭제하고 제목과 컨텐츠를 수정할 경우
        if((file == null) && ((deleteFile == null) || (deleteFile == ""))){
        	bv.setFilepath("");
        }
        
        //제목과 컨텐츠만 수정할 경우
        if ((deleteFile != null && !deleteFile.isEmpty())&&(file==null)) {
        	bv.setFilepath(deleteFile);
        }
        
        // 새 파일 업로드
        if (file != null && !file.isEmpty()) {
        	// 기존 파일 삭제
            if (deleteFile != null && !deleteFile.isEmpty()) {
                String realPath = servletContext.getRealPath("boardUpload");
                String filePath = realPath + File.separator + deleteFile;
                File existingFile = new File(filePath);
                if (existingFile.exists() && existingFile.isFile()) {
                    existingFile.delete();
                }
                bv.setFilepath("");
            }
        	
        	String fileName = file.getOriginalFilename();
			String realPath = servletContext.getRealPath("boardUpload");
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

			bv.setFilepath(fileName);
        }
		boardSvc.updateBoard(bv);
		return "redirect:boardDetail?boardId="+contentId;
	}
	
	/**
	 * 게시글 댓글 작성
	 */
	@RequestMapping(value = "bdComment", method = RequestMethod.POST)
	public String insertComment(HttpServletRequest request, @RequestParam String content){
		BdCommentVO bcm = new BdCommentVO();
		
		String contentId = (String) request.getSession().getAttribute("boardId");
		int boardid = Integer.parseInt(contentId);
		
		bcm.setContent(content);
		bcm.setContent_id(boardid);
		bcm.setWritedid((String) request.getSession().getAttribute("userid"));
		
		boardSvc.insertComment(bcm);
		
		return "redirect:boardDetail"+"?boardId="+contentId;
	}
	
	/**
	 * 게시글 댓글 수정
	 */
	@RequestMapping(value = "bdUpdateComment", method = RequestMethod.POST)
	public String updateComment(HttpServletRequest request, @RequestParam String content, BdCommentVO bcm){
		String id2 = request.getParameter("comment_id");
		int id = Integer.parseInt(id2);
		
		String contentId = (String) request.getSession().getAttribute("boardId");
		int boardid = Integer.parseInt(contentId);
		
		bcm.setContent_id(boardid);
		bcm.setComment_id(id);
		bcm.setContent(content);
		
		boardSvc.updateComment(bcm);
		
		return "redirect:boardDetail"+"?boardId="+contentId;
	}
	/**
	 * 게시글 댓글 삭제
	 */
	@RequestMapping(value = "deleteBdComment")
	public String deleteComment(HttpServletRequest request){
		String id2 = request.getParameter("id");
		int id = Integer.parseInt(id2);
		
		String contentId = (String) request.getSession().getAttribute("boardId");
		
		boardSvc.delComment(id);
		return "redirect:boardDetail"+"?boardId="+contentId;
	}
	
	
	
	/*
	 * -------------------------------------------------------------------------
	 */
	
	//게시글 수정 화면 파일 삭제 메서드
	@RequestMapping(value = "bDeleteFile", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<String> deleteFile(HttpServletRequest request,
	        @RequestParam("filename") String filename, 
	        @RequestParam("PContId") String PContId,
	        @RequestParam("PTitle") String PTitle,
	        @RequestParam("PContent") String PContent) {
	    String realPath = servletContext.getRealPath("boardUpload");
	    String filePath = realPath + File.separator + filename;
	    System.out.println("conId: "+PContId);
	    
	    File existingFile = new File(filePath);
	    if (existingFile.exists() && existingFile.isFile()) {
	        existingFile.delete();
	        
	        BoardVO bv = new BoardVO();
	        bv.setContent_id(Integer.parseInt(PContId));
	        bv.setTitle(PTitle);
	        bv.setContent(PContent);
	        bv.setFilepath("");
		    boardSvc.updateBoard(bv);
		    System.out.println("pconid: "+bv.getContent_id());
		    System.out.println("delfilepath: " + bv.getFilepath());
	        return new ResponseEntity<>("File deleted successfully.", HttpStatus.OK);
	    } else {
	        return new ResponseEntity<>("File not found.", HttpStatus.NOT_FOUND);
	    }
	}
	
	//파일 다운로드 메서드
	@RequestMapping(value = "/board/download/{filename:.+}", method = RequestMethod.GET)
	public void downloadFile(HttpServletRequest request, HttpServletResponse response, @PathVariable("filename") String filename) throws IOException {
	    // 서버의 파일 실제 경로 가져오기
	    String realPath = servletContext.getRealPath("boardUpload");
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
	
}
