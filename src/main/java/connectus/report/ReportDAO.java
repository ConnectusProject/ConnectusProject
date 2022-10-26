package connectus.report;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;



@Mapper
@Repository
public interface ReportDAO {

	
	public int insertReport(ReportDTO dto);
	
	public List<ReportDTO> getAll();
	
	public List<ReportDTO> getAllSeq(int reportSeq);
	
	public ReportDTO getReport(int reportSeq);
	
	public ReportDTO changeReport(ReportDTO dto);
	
	
	public int deleteReport(int reportSeq);
	
}
