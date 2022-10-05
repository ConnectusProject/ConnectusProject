package connectus.notice;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Mapper
@Repository("noticedao")
public interface  NoticeDAO {
	

	
	public List<NoticeDTO> selectNotice();
	
	public int insertNotice(NoticeDTO noticedto);

	public NoticeDTO getNoticeinfo(String noticeinfo);
}
