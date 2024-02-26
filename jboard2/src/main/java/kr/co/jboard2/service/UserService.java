package kr.co.jboard2.service;

import java.util.Properties;
import java.util.concurrent.ThreadLocalRandom;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import kr.co.jboard2.dao.UserDAO;
import kr.co.jboard2.dto.UserDTO;

public class UserService {
	
	private static UserService instance = new UserService();
	
	public static UserService getInstance () {
		return instance;
	}
	
	private UserService() {}
	
	UserDAO dao = UserDAO.getInstance();
	
	public void insertUser(UserDTO userDTO) {
		dao.insertUser(userDTO);
	}
	public UserDTO selectUser(String uid, String pass) {
		return dao.selectUser(uid, pass);
	}
	public void deleteUser() {}
	public void updateUser() {}	
	
	public int selectCountUser(String type, String value) {
		return dao.selectCountUser(type, value);
	}
	
	public void sendEmailCode(HttpSession session, String receiver) {
		
		// 인증코드 생성(6자리 숫자)
		int code = ThreadLocalRandom.current().nextInt(100000,1000000);
		
		session.setAttribute("code", String.valueOf(code));
		
		// 기본 정보
		String sender = "y01044285848@gmail.com";
		String password = "pkwm nsgd pccs qbsb"; // 앱 비밀번호
		String title = "jboard2 인증코드 입니다.";
		String content = "<h1>인증코드는 " + code + "입니다.</h1>";
		
		
		
		// Gmail SMTP 서버 설정
		Properties props = new Properties();		//문자열 구조체(key:value)
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "465");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.ssl.enable", "true");
		props.put("mail.smtp.ssl.trust", "smtp.gmail.com");
		
		try{
			// Gmail STMP 세션 생성
			Session gmailSession = Session.getInstance(props, new Authenticator(){
				
				@Override
				protected PasswordAuthentication getPasswordAuthentication(){
					return new PasswordAuthentication(sender, password);
				}
			});
			
			// 메일 발송
			Message message = new MimeMessage(gmailSession);
			
			message.setFrom(new InternetAddress(sender, "보내는 사람", "UTF-8"));
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(receiver));
			message.setSubject(title);
			message.setContent(content, "text/html;charset=UTF-8");
			
			// 메일 전송
			Transport.send(message);
		}catch(Exception e){
			e.printStackTrace();
		}
		
	}
	
	public int confirmEmailCode(HttpSession session, String code) {
		String sessCode = (String) session.getAttribute("code");
		if(sessCode.equals(code)) {
			return 1;
		}else {
			return 0;
		}
		
	}
	
}
