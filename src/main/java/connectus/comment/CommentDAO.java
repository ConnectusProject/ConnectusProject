package connectus.comment;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Mapper
@Repository("commentdao")
public interface CommentDAO {
	
	public int insertComment(CommentDTO dto); 
	
	public CommentDTO getComment(int commentSeq);
	
	public CommentDTO getCommentseq();
	
	public List<CommentDTO> getAllComment(int seq);
	
	public void updateComment(CommentDTO dto);
	
	public void deleteComment(int commentSeq);
	
	
}
