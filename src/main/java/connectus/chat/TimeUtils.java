package connectus.chat;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class TimeUtils {
	
	private static final String timeFormat = "HH:mm:ss";
	
	public static String getCurrentTimeStamp() {
		
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern(timeFormat);
		return LocalDateTime.now().format(formatter);
	}

}