package connectus.report;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ReportController {

	
	@Autowired
	ReportDAO ReportDAO;
	
	
	
	@PostMapping("/reportselect")
	public List<ReportDTO> getAllSeq(HttpSession session,Model model, String reportcontents, ReportDTO dto, int reportSeq) throws Exception {
		String sessionid = (String)session.getAttribute("sessionid");
//		model.addAttribute("report" ,reportcontents);
		System.out.println(sessionid);
		List<ReportDTO> reportList = ReportDAO.getAllSeq(reportSeq);
		System.out.println(reportList.size());
		return reportList;
		
	}

	@GetMapping("/reportregister")
	public String insertReportform() {
		return "report/allreport";
	}
	
	
	@PostMapping("/reportregister")
	public String  insertReport(HttpSession session, ReportDTO dto) {
		
		String sessionid = (String)session.getAttribute("sessionid");
		 ReportDAO.insertReport(dto);
		 
		 System.out.println(sessionid);
//		 System.out.println(dto.toString());
		return "redirect:/reportregister";
		
		
	}
	

	

	@PostMapping("/reportdelete")
	public void deleteReport(int reportSeq) {
		ReportDAO.deleteReport(reportSeq);
	}
	
	

	@PostMapping("/reportupdate")
	public ReportDTO changeReport(ReportDTO dto, String updatecontents, String updatekind, String reportSeq) {
		
		int reportSeqInt = Integer.parseInt(reportSeq);
		dto.setReportcontents(updatecontents);
		dto.setReportkind(updatekind);
		ReportDAO.changeReport(dto);
		
		return ReportDAO.getReport(reportSeqInt);
	}
	
	@RequestMapping(value = "/customer")
	public String customer() {
		return "report/customer";
	}
	
	@RequestMapping(value = "/story")
	public String story() {
		return "report/story";
	}
	
}
