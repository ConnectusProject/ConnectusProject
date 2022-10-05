package connectus.product;

public class SmartSearchDTO {
	
	private String smartTitle; 
	private String smartStartDate;
	private String smartEndDate;
	private String smartRegion;
	
	
	public SmartSearchDTO() {}
	public SmartSearchDTO(String smartTitle, String smartStartDate, String smartEndDate, String smartRegion) {
		super();
		this.smartTitle = smartTitle;
		this.smartStartDate = smartStartDate;
		this.smartEndDate = smartEndDate;
		this.smartRegion = smartRegion;
	}
	
	
	
	
	
	@Override
	public String toString() {
		return "SmartSearchDTO [smartTitle=" + smartTitle + ", smartStartDate=" + smartStartDate + ", smartEndDate="
				+ smartEndDate + ", smartRegion=" + smartRegion + "]";
	}
	public String getSmartTitle() {
		return smartTitle;
	}
	public void setSmartTitle(String smartTitle) {
		this.smartTitle = smartTitle;
	}
	public String getSmartStartDate() {
		return smartStartDate;
	}
	public void setSmartStartDate(String smartStartDate) {
		this.smartStartDate = smartStartDate;
	}
	public String getSmartEndDate() {
		return smartEndDate;
	}
	public void setSmartEndDate(String smartEndDate) {
		this.smartEndDate = smartEndDate;
	}
	public String getSmartRegion() {
		return smartRegion;
	}
	public void setSmartRegion(String smartRegion) {
		this.smartRegion = smartRegion;
	} 
	
	
	
	

	
	
	
	
	
	
	

}
