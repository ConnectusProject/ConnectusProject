package connectus.boardupload;

import java.io.File;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class BoardUploadController {

	@Autowired
	@Qualifier("boarduploadservice")
	BoardUploadService service;
	
	@GetMapping("/boardupload1")
	public String boarduploadform() {
		return "board/writingform";
	}
	
	@PostMapping("/boardupload1")
	String uploadprocess(BoardUploadDTO dto, MultipartFile file1) 
	throws Exception{
		
		String savePath = "/Users/youngban/boardupload";
		
	
		if(!file1.isEmpty()) {
			String originalname1 = file1.getOriginalFilename(); //a.txt
			String onlyfilename = originalname1.substring(0, originalname1.indexOf("."));
			String extname = originalname1.substring(originalname1.indexOf(".")); // .txt
			String newname = onlyfilename +"("+UUID.randomUUID().toString()+")"+extname;
			File servefile1 = new File(savePath+newname); // a(012334434).txt
			file1.transferTo(servefile1);
			dto.setImg(newname);
		}else {
			dto.setImg("1.png");
		}
		
		return "redirect/detail";
	}
}

	

