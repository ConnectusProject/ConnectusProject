package connectus.board;

public class BoardDTO {
   int seq;
   String title, contents, writer;
   String pw;
   int viewcount;
   String writingtime;
   String img;
   
public String getImg() {
	return img;
}
public void setImg(String img) {
	this.img = img;
}
public int getSeq() {
	return seq;
}
public void setSeq(int seq) {
	this.seq = seq;
}
public String getTitle() {
	return title;
}
public void setTitle(String title) {
	this.title = title;
}
public String getContents() {
	return contents;
}
public void setContents(String contents) {
	this.contents = contents;
}
public String getWriter() {
	return writer;
}
public void setWriter(String writer) {
	this.writer = writer;
}
public String getPw() {
	return pw;
}
public void setPw(String pw) {
	this.pw = pw;
}
public int getViewcount() {
	return viewcount;
}
public void setViewcount(int viewcount) {
	this.viewcount = viewcount;
}
public String getWritingtime() {
	return writingtime;
}
public void setWritingtime(String writingtime) {
	this.writingtime = writingtime;
}
   
   
   
	

	
	
}
