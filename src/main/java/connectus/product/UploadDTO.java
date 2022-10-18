package connectus.product;

import org.springframework.web.multipart.MultipartFile;

public class UploadDTO {
	
	String file1;
	String file2;
	String file3;
	String file4;
	String file5;
	String file6;
	String videoTitle;
	MultipartFile video1;
	
	
	
	
	
	
	public String getVideoTitle() {
		return videoTitle;
	}
	public void setVideoTitle(String videoTitle) {
		this.videoTitle = videoTitle;
	}
	public MultipartFile getVideo1() {
		return video1;
	}
	public void setVideo1(MultipartFile video1) {
		this.video1 = video1;
	}
	public String getFile1() {
		return file1;
	}
	public void setFile1(String file1) {
		this.file1 = file1;
	}
	public String getFile2() {
		return file2;
	}
	public void setFile2(String file2) {
		this.file2 = file2;
	}
	public String getFile3() {
		return file3;
	}
	public void setFile3(String file3) {
		this.file3 = file3;
	}
	public String getFile4() {
		return file4;
	}
	public void setFile4(String file4) {
		this.file4 = file4;
	}
	public String getFile5() {
		return file5;
	}
	public void setFile5(String file5) {
		this.file5 = file5;
	}
	public String getFile6() {
		return file6;
	}
	public void setFile6(String file6) {
		this.file6 = file6;
	}
	
	
	
	
	

	
	
}
