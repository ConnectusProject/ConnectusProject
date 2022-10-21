package connectus;

import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;

//JASYPT(Java Simplified Encryption)-자스입트
public class JasyptDB {
	public static void main(String[] args) {
		StandardPBEStringEncryptor jasypt = new StandardPBEStringEncryptor();
		jasypt.setPassword("1234");
		
		String driver = jasypt.encrypt("com.mysql.cj.jdbc.Driver");
		String url = jasypt.encrypt("jdbc:mysql://101.101.208.234:3306/naverdb");
		String account = jasypt.encrypt("naveruser");
		String password = jasypt.encrypt("Naveruser_1234");
		
		System.out.println(driver);
		System.out.println(url);
		System.out.println(account);
		System.out.println(password);
//application.properties 파일의 해당 항목 - ENC() 내부에 암호화된 코드를 넣는다
//실행시마다 암호화문자열은 달라지는데 복호화해보면 원본문자열임을 알 수 있다.

//0. pom.xml 파일에 
/*		<!-- db연결정보 암호화 위한 라이브러리 -->	
		<!-- https://mvnrepository.com/artifact/com.github.ulisesbocchio/jasypt-spring-boot-starter -->
		<dependency>
		    <groupId>com.github.ulisesbocchio</groupId>
		    <artifactId>jasypt-spring-boot-starter</artifactId>
		    <version>2.1.2</version>
		</dependency>*/
//추가하기		
// 1.  JasyptDB 작성,실행
// 2. application.properties 파일에 ENC() 내부 붙여넣기
// 3. JasyptConfig 작성,실행
// 4. application.properties 파일에 jasypt.encryptor.bean=jasyptEncryptor	추가하기
// 5. 암호화하는 암호가 JasyptConfig.java에 노출되므로 
//run as - run configurations - 		
		
	}
}
