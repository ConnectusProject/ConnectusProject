package connectus.comment;

public class CommentDTO {
	
	int seq, secret, comment_seq;
	String contents, writer, writingtime;
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public int getSecret() {
		return secret;
	}
	public void setSecret(int secret) {
		this.secret = secret;
	}
	public int getComment_seq() {
		return comment_seq;
	}
	public void setComment_seq(int comment_seq) {
		this.comment_seq = comment_seq;
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
	public String getWritingtime() {
		return writingtime;
	}
	public void setWritingtime(String writingtime) {
		this.writingtime = writingtime;
	}
	@Override
	public String toString() {
		return "CommentDTO [seq=" + seq + ", secret=" + secret + ", comment_seq=" + comment_seq + ", contents="
				+ contents + ", writer=" + writer + ", writingtime=" + writingtime + "]";
	}
	
	
	
	
}
