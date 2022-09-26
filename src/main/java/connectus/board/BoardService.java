package connectus.board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("service")
public class BoardService {
	@Autowired
	BoardDAO boarddao;
	
	public int registerBoard(BoardDTO dto) {
		return boarddao.insertBoard(dto);
			
	}
	
	public int getTotalBoard() {
		return boarddao.boardcount();
	}
	
	public List<BoardDTO> paginglist(int[] limit) {
		return boarddao.pagingList(limit);
	}
	

	
	  public int updateSeq(int seq) { return boarddao.updateSeq(seq); }
	  
	  public BoardDTO getBoardSeqLst(int seq) { return boarddao.getBoardSeqLst(seq); }
	  
	  
	  public int deleteBoard(int seq) { return boarddao.deleteBoard(seq); }
	  
	  public int updateBoard(BoardDTO dto) { return boarddao.updateBoard(dto); }
	  
	  public int getTotalTitleBoard() { return boarddao.getTitleCount(); }
	  
	  public List<BoardDTO> pagingTitlelist(int[] limit) { 
		  return boarddao.pagingTitleList(limit); }
	  
	  public int getTotalWriterBoard() { return boarddao.getWriterCount(); }
	  
	  
	  public List<BoardDTO> pagingWriterlist(int[] limit) { 
		  return boarddao.pagingWriterList(limit); }
	  
	  
	  public List<BoardDTO> paginglist2(int[] limit, String searchVal) {
		  Map paramMap = new HashMap<>(); 
		  paramMap.put("param1", limit);
	  paramMap.put("param2", searchVal); 
		  
		  return boarddao.pagingList2(paramMap); }
	  
	  
	  public int getTotalBoard2(String searchVal) { 
		  return boarddao.getTotalBoard2(searchVal); }
	  
	  public List<BoardDTO> pagingTitlelist2(int[] is, String searchVal) {
		  Map paramMap = new HashMap(); 
		  paramMap.put("param1", is); 
		  paramMap.put("param2", searchVal); 
		  
		  return boarddao.pagingTitleList2(paramMap); }
	  
	  
	  public int getTotalTitleBoard2(String searchVal) { 
		  return boarddao.getTotalTitleBoard2(searchVal); }
	  
	  
	  public List<BoardDTO> pagingWriterlist2(int[] is, String searchVal) {
		  Map paramMap = new HashMap(); 
		  paramMap.put("param1", is); 
		  paramMap.put("param2", searchVal); 
		  
		  return boarddao.pagingWriterlist2(paramMap); }
	  
	  
	  public int getTotalWriterBoard2(String searchVal) { 
		  return boarddao.getTotalWriterBoard2(searchVal); }

	
	 
}
