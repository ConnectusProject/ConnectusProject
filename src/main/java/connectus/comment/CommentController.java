package connectus.comment;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
public class CommentController {
	@Autowired
	CommentDAO commentDAO;
	
	@ResponseBody
	@PostMapping("/boarddetail/{boardSeq}/getAllComment")
	public Object getAllComment(@PathVariable("boardSeq") int seq) {
		List<CommentDTO> commentList = commentDAO.getAllComment(seq);
		
		System.out.println(commentList.size());
		
		return commentList;
	}
	
	
	@ResponseBody
	@RequestMapping("/boarddetail/{boardSeq}/insertComment")

	public CommentDTO insertComment(@PathVariable("boardSeq") int seq, CommentDTO dto) throws Exception{
//		int commentseqInt = Integer.parseInt(dto.getComment_seq());
		
		commentDAO.insertComment(dto);
//		System.out.println(dto);
		//select	-- 여기에서 최신으로 insert.Comment를 해줬을때 조회해줄수 있는 DAO가 나와야한다.
//		return 
//		return null;
//		System.out.println(dto);
		System.out.println(commentDAO.getComment(dto.getComment_seq()));
		return commentDAO.getComment(dto.getComment_seq());
		
	}
	
	@ResponseBody
	@PostMapping("/boarddetail/{boardSeq}/updateComment")
	public CommentDTO updateComment(CommentDTO dto, String updateContents, int updateSecret, String commentSeq) {
		int commentSeqInt = Integer.parseInt(commentSeq);
//		System.out.println(commentSeqInt);
		dto.setContents(updateContents);
		dto.setSecret(updateSecret);
		dto.setComment_seq(commentSeqInt);
		System.out.println(dto.toString());
		commentDAO.updateComment(dto);
		return commentDAO.getComment(commentSeqInt);
		
	}
	
	@ResponseBody
	@PostMapping("/boarddetail/{boardSeq}/deleteComment")
	public void deleteComment(int commentSeq) {
		System.out.println(commentSeq);
		commentDAO.deleteComment(commentSeq);
	}
	
	
}
