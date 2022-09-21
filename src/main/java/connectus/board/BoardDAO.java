package connectus.board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
//import org.apache.commons.collections.map.HashedMap;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Repository;


@Mapper
@Repository("boarddao")
public interface BoardDAO {
	
	public int insertBoard(BoardDTO dto);

	public int boardcount();

	  public List<BoardDTO> pagingList(int[] limit);
	  
	  public int updateSeq(int seq);
	  
	  public BoardDTO getBoardSeqLst(int seq);
	  
	  public int deleteBoard(int seq);
	  
	  public int updateBoard(BoardDTO dto);
	  
	  public int getTitleCount();
	  
	  public List<BoardDTO> pagingTitleList(int[] limit);
	  
	  public int getWriterCount();
	  
	  public List<BoardDTO> pagingWriterList(int[] limit);
	  
	  public int getTotalBoard2(String searchVal);
	  
	  public int getTotalTitleBoard2(String searchVal);
	  
	  public int getTotalWriterBoard2(String searchVal);
	  
	  
	  public List<BoardDTO> pagingList2(Map map); 
	  
	  public List<BoardDTO> pagingTitleList2(Map map); 
		  
	  
	  public List<BoardDTO> pagingWriterlist2(Map map); 
		  
	 	
}
