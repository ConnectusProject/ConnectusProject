package connectus;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class uploadConfig implements WebMvcConfigurer{

	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
//		registry.addResourceHandler("/upload/**").addResourceLocations("file:/Users/youngban/upload/");
		registry.addResourceHandler("/upload/**").addResourceLocations("file:///c:/upload/");
		
	}
	
	
	
	
	

}
