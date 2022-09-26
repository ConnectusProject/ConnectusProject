package connectus.board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;




@Service("service")

public class BoardService {
	
	@Autowired

	BoardDAO boardDAO;
	
	public int registerBoard(BoardDTO dto) {
		return boardDAO.insertBoard(dto);


			
	}
	
	public int getTotalBoard() {

		return boardDAO.boardcount();
	}
	
	public List<BoardDTO> paginglist(int[] limit) {
		return boardDAO.pagingList(limit);


	}
	

	  public int updateSeq(int seq) { return boardDAO.updateSeq(seq); }
	  
	  public BoardDTO getBoardSeqLst(int seq) { return boardDAO.getBoardSeqLst(seq); }
	  
	  
	  public int deleteBoard(int seq) { return boardDAO.deleteBoard(seq); }
	  
	  public int updateBoard(BoardDTO dto) { return boardDAO.updateBoard(dto); }
	  
	  public int getTotalTitleBoard() { return boardDAO.getTitleCount(); }
	  
	  public List<BoardDTO> pagingTitlelist(int[] limit) { 
		  return boardDAO.pagingTitleList(limit); }
	  
	  public int getTotalWriterBoard() { return boardDAO.getWriterCount(); }
	  
	  
	  public List<BoardDTO> pagingWriterlist(int[] limit) { 
		  return boardDAO.pagingWriterList(limit); }




	


	  
	  
	  public List<BoardDTO> paginglist2(int[] limit, String searchVal) {
		  Map paramMap = new HashMap<>(); 
		  paramMap.put("param1", limit);
	  paramMap.put("param2", searchVal); 
		  

		  return boardDAO.pagingList2(paramMap); }
	  
	  
	  public int getTotalBoard2(String searchVal) { 
		  return boardDAO.getTotalBoard2(searchVal); }

	
	
	 
	  
	  public List<BoardDTO> pagingTitlelist2(int[] is, String searchVal) {
		  Map paramMap = new HashMap(); 
		  paramMap.put("param1", is); 
		  paramMap.put("param2", searchVal); 
		  

		  return boardDAO.pagingTitleList2(paramMap); }
	  
	  
	  public int getTotalTitleBoard2(String searchVal) { 
		  return boardDAO.getTotalTitleBoard2(searchVal); }

	  

	  

	  
	  public List<BoardDTO> pagingWriterlist2(int[] is, String searchVal) {
		  Map paramMap = new HashMap(); 
		  paramMap.put("param1", is); 
		  paramMap.put("param2", searchVal); 
		  


		  return boardDAO.pagingWriterlist2(paramMap); }
	  
	  
	  public int getTotalWriterBoard2(String searchVal) { 
		  return boardDAO.getTotalWriterBoard2(searchVal); }

	  


	
	 
}
