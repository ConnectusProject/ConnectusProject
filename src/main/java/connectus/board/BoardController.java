package connectus.board;


import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;



@Controller
public class BoardController {
	@Autowired
	@Qualifier("boardservice")
	BoardService service;


	
	@RequestMapping("/boardstart")
	public ModelAndView start(@RequestParam(value="page", required = false, defaultValue = "1") int page) {
		int totalboard = service.getTotalBoard();
	
	
		List<BoardDTO> boardlst = service.paginglist(new int[] {(page-1)*3, 3});
		ModelAndView mv = new ModelAndView();
		mv.addObject("boardlst", boardlst);
		mv.addObject("boardUrl", "boardlist");
		mv.addObject("totalboard",totalboard);
		mv.setViewName("board/list");
		return mv;
	}
		
	@GetMapping("/boardwrite")
	public String writingform() {
		return "board/writingform2";
	}
	
	@PostMapping("/boardwrite")
	public ModelAndView writingprocess(@RequestParam
			(value="page", required = false, defaultValue = "1") int page, BoardDTO dto, MultipartFile file1) throws IOException {
		String savePath = "/Users/youngban/boardupload/";
		String newname = null;
		System.out.println(file1);
		if(!file1.isEmpty()) {
			
			String originalname1 = file1.getOriginalFilename(); //a.txt
			String onlyfilename = originalname1.substring(0, originalname1.indexOf("."));
			String extname = originalname1.substring(originalname1.indexOf(".")); // .txt
			newname = onlyfilename +"("+UUID.randomUUID().toString()+")"+extname;
			File servefile1 = new File(savePath+newname); // a(012334434).txt
			file1.transferTo(servefile1);
			dto.setImg(newname);
		}else {
			dto.setImg("1.png");
		}
		
		int totalboard = service.getTotalBoard();
		
		List<BoardDTO> boardlst = service.paginglist(new int[] {(page-1)*3, 3});
		int insertcount = service.registerBoard(dto);
		ModelAndView mv = new ModelAndView();
		mv.addObject("insertcount", insertcount);
		mv.addObject("boardlst", boardlst);
		mv.addObject("boardUrl", "boardlist");
		mv.addObject("totalboard", totalboard);
		mv.addObject("seqList", newname);
		mv.setViewName("board/detail2");
		return mv;
	}
	
//	@GetMapping("/boardupload")
//	public String boarduploadform() {
//		return "board/writingform2";
//	}
//	
//	@PostMapping("/boardupload")
//	String uploadprocess(BoardDTO dto, MultipartFile file1) 
//	throws Exception{
//		
//		String savePath = "/Users/youngban/boardupload";
//		
//	
//		if(!file1.isEmpty()) {
//			String originalname1 = file1.getOriginalFilename(); //a.txt
//			String onlyfilename = originalname1.substring(0, originalname1.indexOf("."));
//			String extname = originalname1.substring(originalname1.indexOf(".")); // .txt
//			String newname = onlyfilename +"("+UUID.randomUUID().toString()+")"+extname;
//			File servefile1 = new File(savePath+newname); // a(012334434).txt
//			file1.transferTo(servefile1);
//			dto.setImg(newname);
//		}else {
//			dto.setImg("1.png");
//		}
//		
//		return "board/detail2";
//	}
	
	@RequestMapping("/boardlist")
	public ModelAndView boardlist(@RequestParam(value="page",required=false, defaultValue="1") int page,String contents) {
		int totalboard = service.getTotalBoard();
		
		List<BoardDTO> boardlst = service.paginglist(new int[]{(page -1)*3, 3});//  1->0 , 2->3
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("boardlst", boardlst);
		mv.addObject("boardUrl", "boardlist");
		mv.addObject("totalboard", totalboard );
		mv.setViewName("board/list");
		return mv;
		
	}
	
	@GetMapping("/boardtitle")
	public ModelAndView boardlistTitle(@RequestParam(value="page", required = false, defaultValue = "1") int page,String contents) {
		int totalboardTitle = service.getTotalTitleBoard();
		
		//3개만 조회
		List<BoardDTO> boardlst = service.pagingTitlelist(new int[] {(page-1)*3, 3});
		ModelAndView mv = new ModelAndView();
		mv.addObject("boardlst", boardlst);
		mv.addObject("boardUrl","boardtitle");
		mv.addObject("totalboard",totalboardTitle);
		mv.setViewName("board/list");
		return mv;
	}
	
	@GetMapping("/boardwriter")
	public ModelAndView boardlistWriter(@RequestParam(value="page", required = false, defaultValue = "1") int page,String contents) {
		int totalboardWriter = service.getTotalWriterBoard();
		
		//3개만 조회
		List<BoardDTO> boardlst = service.pagingWriterlist(new int[] {(page-1)*3, 3});
		ModelAndView mv = new ModelAndView();
		mv.addObject("boardlst", boardlst);
		mv.addObject("boardUrl","boardwriter");
		mv.addObject("totalboard",totalboardWriter);
		mv.setViewName("board/list");
		return mv;
	}
	
	@GetMapping("/boardContent")
	public ModelAndView boardContent(@RequestParam(value="page", required = false, defaultValue = "1") int page,HttpServletRequest request) {
		String selectVal = request.getParameter("selectOption");
		String searchVal = request.getParameter("boardsearch");
		List<BoardDTO> boardlst = new ArrayList<BoardDTO>();
		ModelAndView mv = new ModelAndView();
		int totalboardCnt = 0;
		if("전체".equals(selectVal)) { // 내용 검색
			boardlst = service.paginglist2(new int[] {(page-1)*3, 3},searchVal);
			totalboardCnt = service.getTotalBoard2(searchVal);
		}
		else if("제목".equals(selectVal)) { // 제목 검색
			boardlst = service.pagingTitlelist2(new int[] {(page-1)*3, 3},searchVal);
			totalboardCnt = service.getTotalTitleBoard2(searchVal);
		}
		else if("작성자".equals(selectVal)) { // 작성자 검색
			boardlst = service.pagingWriterlist2(new int[] {(page-1)*3, 3},searchVal);
			totalboardCnt = service.getTotalWriterBoard2(searchVal);
			System.out.println(boardlst+"!!!!!!");
		}
		//3개만 조회
		mv.addObject("boardlst", boardlst);
		mv.addObject("boardUrl","boardContent");
		mv.addObject("totalboard",totalboardCnt);
		mv.addObject("SelectedValue",selectVal);
		mv.addObject("SearchedValue",searchVal);
		mv.setViewName("board/list");
		return mv;
	}
	
	@GetMapping("/boarddetail")
	public ModelAndView boarddetail(int seq, HttpServletRequest request, HttpServletResponse response,String Clicked) {

		HttpSession session = request.getSession();
		String sessionId = (String)session.getAttribute("sessionid");
		
		int updateCount = service.updateSeq(seq);
		//조회 리턴
		BoardDTO dto = service.getBoardSeqLst(seq);
		ModelAndView mv = new ModelAndView();
		mv.addObject("updateSeq",updateCount);
		mv.addObject("seqList",dto);
		mv.addObject("sId",sessionId);
		mv.setViewName("board/detail2");
		return mv;
	}
	
	@GetMapping("/boarddelete")
	public ModelAndView boardDelete(@RequestParam(value="page", required = false, defaultValue = "1") int page,int seq) {
		ModelAndView mv = new ModelAndView();
		int deleteCount = service.deleteBoard(seq);
		if(deleteCount == 1) {
			int totalboard = service.getTotalBoard();
			List<BoardDTO> boardlst = service.paginglist(new int[] {(page-1)*3, 3});
			mv.addObject("boardlst", boardlst);
			mv.addObject("boardUrl","boardlist");
			mv.addObject("totalboard",totalboard);
			mv.setViewName("redirect:/boardlist");
		}
		return mv;
	}
	
	@GetMapping("/boardupdate")
	ModelAndView updateBoard(int seq) {
		//seq 글 조회 (BoardDTO)
		BoardDTO dto = service.getBoardSeqLst(seq);
		ModelAndView mv = new ModelAndView();
		mv.addObject("updated_board",dto);
		mv.setViewName("board/updateform");
		return mv;
	}

	@PostMapping("/boardupdate")
	String updateBoard(BoardDTO dto) {
		service.updateBoard(dto);
		return "redirect:/boardlist";

	}
}
