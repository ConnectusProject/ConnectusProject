package connectus.boardupload;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Mapper
@Repository("boarduploaddao")
public interface BoardUploadDAO {
	public int insertUpload(BoardUploadDTO dto);
	public List<BoardUploadDTO> selectUpload(String name);

}
