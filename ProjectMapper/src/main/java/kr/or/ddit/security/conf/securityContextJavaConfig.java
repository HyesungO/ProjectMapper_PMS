package kr.or.ddit.security.conf;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityCustomizer;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import kr.or.ddit.users.user.service.UserService;
import kr.or.ddit.users.vo.UsersVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Configuration
@EnableWebSecurity
public class securityContextJavaConfig {
	@Autowired
    private UserService usersService;
	@Autowired
	private AuthenticationManagerBuilder authenticationManagerBuilder;
	@PostConstruct
	public void init() {
	authenticationManagerBuilder.eraseCredentials(true);
	}
	
	
	@Bean
	public PasswordEncoder passwordEncoder() {
		
//		return PasswordEncoderFactories.createDelegatingPasswordEncoder();
		return new PasswordEncoder() {
			
			//암호화 안된 프로젝트를위해 그냥있는 패스워드를 쓰는 커스텀
			@Override
			public boolean matches(CharSequence rawPassword, String encodedPassword) {
				// TODO Auto-generated method stub
				return encodedPassword.equals(rawPassword);
			}
			
			@Override
			public String encode(CharSequence rawPassword) {
				// TODO Auto-generated method stub
				return rawPassword.toString();
			}
		};
	}
	
//	@Bean
//	public UserDetailsService userDetailService(PasswordEncoder encoder) {
//		
//		InMemoryUserDetailsManager manager = new InMemoryUserDetailsManager();
//		manager.createUser(User.withUsername("a001").password(encoder.encode("java")).roles("USER").build());
//		manager.createUser(User.withUsername("ADMIN").password(encoder.encode("java")).roles("ADMIN").build());
//		return manager;
//}
//	

	// 역할을 결정하는 메서드
	public String[] getRolesForUser(String username) {
	    if (username.startsWith("ADMIN")) {
	        return new String[] { "ADMIN" };  // "ADMIN"으로 시작하는 사용자에게 ADMIN 역할 부여
	    }
	    return new String[] { "USER" };  // 그 외 사용자는 USER 역할 부여
	}
	
	
	@Bean
	public WebSecurityCustomizer webSecurityCustomizer() {
		return (web) -> web.ignoring()
		.antMatchers("/resources/**");
}
	
	@Bean
	public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
		
		
		http.anonymous().authorities("ROLE_ANONYMOUS")
				.and()
				.authorizeHttpRequests(authorize->
					authorize
						.antMatchers("/public/**").permitAll()
						.antMatchers("/project").authenticated()
						.antMatchers("/p").authenticated()
						.anyRequest().permitAll()
				).formLogin((formLogin) ->
				//login을 커스텀하는 코드 (userid 인풋태그 userPassword 인풋태그 loginform 안에 )
 				formLogin
					.usernameParameter("userId")
					.passwordParameter("userPassword")
					.loginPage("/users/user/login")
					.loginProcessingUrl("/users/user/loginprocess")
					.defaultSuccessUrl("/PM/projects/project/mylist")
					.successHandler(customAuthenticationSuccessHandler())  
					
				).logout(logout -> 
						logout
						.logoutUrl("/users/user/logout") // 로그아웃 URL
	                    .logoutSuccessUrl("/users/user/login") // 로그아웃 후 리다이렉트 URL
	                    .invalidateHttpSession(true) // 세션 무효화
	                    .deleteCookies("JSESSIONID") // 쿠키 삭제
						)
				.csrf().disable()
				.sessionManagement()
                .maximumSessions(1) // 동시 세션 제한
                .and()
                .invalidSessionUrl("/users/user/login") // 세션 만료 시 리다이렉트
				;
		return http.build();
	}
	
//	 @Bean
//	    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
//	        http.csrf().disable() // CSRF 비활성화 (폼에서 비정상적인 요청을 막느)
//	            .authorizeHttpRequests(authorize -> 
//	                authorize
//	                    .anyRequest().permitAll() // 모든 요청 허용
//	            )
//	            .formLogin().disable() // 기본 로그인 폼 비활성화
//	            .httpBasic().disable(); // HTTP Basic 인증 비활성화
//
//	        return http.build();
//	    }
	@Bean
	public AuthenticationSuccessHandler customAuthenticationSuccessHandler() {
	    return (request, response, authentication) -> {
	        UsersVO userVO = usersService.retrieveUser(authentication.getName());
	
	        request.getSession().setAttribute("userVO", userVO);
	        response.sendRedirect("/PM/projects/project/mylist"); // /PM 경로 포함
	    };
	}

}
