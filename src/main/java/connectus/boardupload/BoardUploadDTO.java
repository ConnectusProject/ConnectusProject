package connectus.boardupload;

import org.springframework.web.multipart.MultipartFile;

public class BoardUploadDTO {
	String name;
	String description;
	MultipartFile file1;
	String uploadtime;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public MultipartFile getFile1() {
		return file1;
	}
	public void setFile1(MultipartFile file1) {
		this.file1 = file1;
	}
	public String getUploadtime() {
		return uploadtime;
	}
	public void setUploadtime(String uploadtime) {
		this.uploadtime = uploadtime;
	}
	public void setImg(String newname) {
		// TODO Auto-generated method stub
		
	}
	
	
}

	
