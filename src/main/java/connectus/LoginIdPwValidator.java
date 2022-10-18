package connectus;

import java.io.Console;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.security.acls.domain.ConsoleAuditLogger;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import connectus.member.MemberDAO;
import connectus.member.MemberDTO;

@Service
public class LoginIdPwValidator implements UserDetailsService {
    @Bean
    public PasswordEncoder passwordEncoder() {
        return PasswordEncoderFactories.createDelegatingPasswordEncoder();
    }

    @Autowired
    private MemberDAO dao;
    
    @Autowired
	HttpSession session;

    @Override
    public UserDetails loadUserByUsername(String insertedId) throws UsernameNotFoundException {
        MemberDTO user = dao.getUserInfo(insertedId);
        
        if (user == null) {
            return null;
        }

        String pw = user.getPw();
        String role = user.getRole();
        System.out.println(insertedId);
        System.out.println(pw);
        System.out.println(role);
        
        session.setAttribute("sessionid", insertedId);
        System.out.println(session.getAttribute("sessionid"));

        return User.builder()
                .username(insertedId)
                .password(pw)
                .roles(role)
                .build();
    }
}