package connectus.boardupload;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("boarduploadservice")
public class BoardUploadService {

	@Autowired(required=false)
	BoardUploadDAO dao;
	
	public int register(BoardUploadDTO dto) {
		return dao.insertUpload(dto);
	}
	
	public List<BoardUploadDTO>get(String name){
		return dao.selectUpload(name);
	}
}
