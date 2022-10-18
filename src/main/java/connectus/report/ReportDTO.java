package connectus.report;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Mapper
@Repository("reportdao")
public class ReportDTO {
	
	private int report_seq;
	private String senderreport, receivereport, reporttime;
	private String reportkind, reportcontents, img1, img2, img3;
	
	
	public int getReport_seq() {
		return report_seq;
	}
	public void setReport_seq(int report_seq) {
		this.report_seq = report_seq;
	}
	public String getSenderreport() {
		return senderreport;
	}
	public void setSenderreport(String senderreport) {
		this.senderreport = senderreport;
	}
	public String getReceivereport() {
		return receivereport;
	}
	public void setReceivereport(String receivereport) {
		this.receivereport = receivereport;
	}
	public String getReporttime() {
		return reporttime;
	}
	public void setReporttime(String reporttime) {
		this.reporttime = reporttime;
	}
	public String getReportkind() {
		return reportkind;
	}
	public void setReportkind(String reportkind) {
		this.reportkind = reportkind;
	}
	public String getReportcontents() {
		return reportcontents;
	}
	public void setReportcontents(String reportcontents) {
		this.reportcontents = reportcontents;
	}
	public String getImg1() {
		return img1;
	}
	public void setImg1(String img1) {
		this.img1 = img1;
	}
	public String getImg2() {
		return img2;
	}
	public void setImg2(String img2) {
		this.img2 = img2;
	}
	public String getImg3() {
		return img3;
	}
	public void setImg3(String img3) {
		this.img3 = img3;
	}
	
	
	
	@Override
	public String toString() {
		return "ReportDTO [report_seq=" + report_seq + ", senderreport=" + senderreport + ", receivereport="
				+ receivereport + ", reporttime=" + reporttime + ", reportkind=" + reportkind + ", reportcontents="
				+ reportcontents + ", img1=" + img1 + ", img2=" + img2 + ", img3=" + img3 + "]";
	}
	public ReportDTO(int report_seq, String senderreport, String receivereport, String reporttime, String reportkind,
			String reportcontents, String img1, String img2, String img3) {
		super();
		this.report_seq = report_seq;
		this.senderreport = senderreport;
		this.receivereport = receivereport;
		this.reporttime = reporttime;
		this.reportkind = reportkind;
		this.reportcontents = reportcontents;
		this.img1 = img1;
		this.img2 = img2;
		this.img3 = img3;
	}
	
	public ReportDTO() {}
	
	
	
	
}
