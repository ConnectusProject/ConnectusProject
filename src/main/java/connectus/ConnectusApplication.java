package connectus;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication

@ComponentScan
@ComponentScan(basePackages = "connectus.report")
@ComponentScan(basePackages = "connectus.member")
@ComponentScan(basePackages = "connectus.board")
@ComponentScan(basePackages = "connectus.product")
@ComponentScan(basePackages = "connectus.reservation")
@ComponentScan(basePackages = "connectus.comment")
@ComponentScan(basePackages = "connectus.mypage")
@ComponentScan(basePackages = "connectus.chat")
@ComponentScan(basePackages = "connectus.notice")
@ComponentScan(basePackages = "connectus.location")
@ComponentScan(basePackages = "connectus.admin")
@ComponentScan(basePackages = "connectus")
@ComponentScan(basePackages = "test")
@ComponentScan(basePackages = "connectus.order")

@ComponentScan(basePackages = "connectus.location")

@MapperScan(basePackages = "connectus.order")
@MapperScan(basePackages = "connectus.report")
@MapperScan(basePackages = "connectus.comment")
@MapperScan(basePackages = "connectus.member")
@MapperScan(basePackages = "connectus.board")
@MapperScan(basePackages = "connectus.product")
@MapperScan(basePackages = "connectus.reservation")
@MapperScan(basePackages = "connectus.mypage")
@MapperScan(basePackages = "connectus.chat")
@MapperScan(basePackages = "connectus.notice")
@MapperScan(basePackages = "connectus.admin")
@MapperScan(basePackages = "connectus")

public class ConnectusApplication {

	public static void main(String[] args) {
		SpringApplication.run(ConnectusApplication.class, args);
	}

}
