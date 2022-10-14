package connectus.product;

public class SmartSearchDTO {
	
	private String smartTitle; 
	private String smartStartDate;
	private String smartEndDate;
	private String smartRegion;
	private String smartPriceMin;
	private String smartPriceMax;
	
	
	public SmartSearchDTO() {}
	public SmartSearchDTO(String smartTitle, String smartStartDate, String smartEndDate, String smartRegion, String smartPriceMin, String smartPriceMax) {
		super();
		this.smartTitle = smartTitle;
		this.smartStartDate = smartStartDate;
		this.smartEndDate = smartEndDate;
		this.smartRegion = smartRegion;
		this.smartPriceMin = smartPriceMin; 
		this.smartPriceMax = smartPriceMax;
	}
	
	
	
	
	
	@Override
	public String toString() {
		return "SmartSearchDTO [smartTitle=" + smartTitle + ", smartStartDate=" + smartStartDate + ", smartEndDate="
				+ smartEndDate + ", smartRegion=" + smartRegion + "]";
	}
	
	
	
	
	
	
	
	
	
	
	public String getSmartPriceMin() {
		return smartPriceMin;
	}
	public void setSmartPriceMin(String smartPriceMin) {
		this.smartPriceMin = smartPriceMin;
	}
	public String getSmartPriceMax() {
		return smartPriceMax;
	}
	public void setSmartPriceMax(String smartPriceMax) {
		this.smartPriceMax = smartPriceMax;
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
