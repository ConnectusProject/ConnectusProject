package connectus.board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("boardservice")
public class BoardService {
	@Autowired
	BoardDAO dao;
	
	public int registerBoard(BoardDTO dto) {
		return dao.insertBoard(dto);
			
	}
	
	public int getTotalBoard() {
		return dao.boardcount();
	}
	
	public List<BoardDTO> paginglist(int[] limit) {
		return dao.pagingList(limit);
	}
	
	
	  public int updateSeq(int seq) { return dao.updateSeq(seq); }
	  
	  public BoardDTO getBoardSeqLst(int seq) { return dao.getBoardSeqLst(seq); }
	  
	  
	  public int deleteBoard(int seq) { return dao.deleteBoard(seq); }
	  
	  public int updateBoard(BoardDTO dto) { return dao.updateBoard(dto); }
	  
	  public int getTotalTitleBoard() { return dao.getTitleCount(); }
	  
	  public List<BoardDTO> pagingTitlelist(int[] limit) { 
		  return dao.pagingTitleList(limit); }
	  
	  public int getTotalWriterBoard() { return dao.getWriterCount(); }
	  
	  
	  public List<BoardDTO> pagingWriterlist(int[] limit) { 
		  return dao.pagingWriterList(limit); }
	  
	  
	  public List<BoardDTO> paginglist2(int[] limit, String searchVal) {
		  Map paramMap = new HashMap<>(); 
		  paramMap.put("param1", limit);
	  paramMap.put("param2", searchVal); 
		  
		  return dao.pagingList2(paramMap); }
	  
	  
	  public int getTotalBoard2(String searchVal) { 
		  return dao.getTotalBoard2(searchVal); }
	  
	  public List<BoardDTO> pagingTitlelist2(int[] is, String searchVal) {
		  Map paramMap = new HashMap(); 
		  paramMap.put("param1", is); 
		  paramMap.put("param2", searchVal); 
		  
		  return dao.pagingTitleList2(paramMap); }
	  
	  
	  public int getTotalTitleBoard2(String searchVal) { 
		  return dao.getTotalTitleBoard2(searchVal); }
	  
	  
	  public List<BoardDTO> pagingWriterlist2(int[] is, String searchVal) {
		  Map paramMap = new HashMap(); 
		  paramMap.put("param1", is); 
		  paramMap.put("param2", searchVal); 
		  
		  return dao.pagingWriterlist2(paramMap); }
	  
	  
	  public int getTotalWriterBoard2(String searchVal) { 
		  return dao.getTotalWriterBoard2(searchVal); }
	 
}
