package com.spring.common.mail;

import java.io.UnsupportedEncodingException;
import java.util.Random;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class MailService {

	@Autowired
	private JavaMailSender javaMailSender;
	
	private String key;
	private String pwd;
	
	
	public MimeMessage createMessage(String to) throws MessagingException, UnsupportedEncodingException {
		log.info("보내는 대상 : " + to);
		log.info("인증 번호 : " + key);
		
		MimeMessage message = javaMailSender.createMimeMessage();

		message.addRecipients(RecipientType.TO, to);// 보내는 대상
		message.setSubject("QUICKet 이메일 본인 인증");// 제목

		String msgg = "";
		msgg += "<div style='margin:100px;'>";
		msgg += "<h1>QUICKET 이메일 인증 번호</h1>";
		msgg += "<h2>안녕하세요. QUICKet입니다.</h2>";
		msgg += "<br>";
		msgg += "<h4>인증키 입력창에 다음 6자리 인증키를 입력해주세요.</h4>";
		msgg += "<br>";
		msgg += "<div align='center' style='border:1px solid black; font-family:verdana';>";
		msgg += "<h3 style='color:blue;'>이메일 본인 인증 키입니다.</h3>";
		msgg += "<div style='font-size:130%'>";
		msgg += "CODE : <strong>";
		msgg += key + "</strong><div><br/> "; // 메일에 인증번호 넣기
		msgg += "</div>";
		message.setText(msgg, "utf-8", "html");// 내용, charset 타입, subtype
		// 보내는 사람의 이메일 주소, 보내는 사람 이름
		message.setFrom(new InternetAddress("yubinn2@naver.com", "QUICKet 관리자"));// 보내는 사람

		return message;
	}
	
	/**
	 * 탈퇴 처리 안내 메시지 작성
	 */
	public MimeMessage createDeleteMail(String to) throws MessagingException, UnsupportedEncodingException {
		log.info("보내는 대상 : " + to);
		
		MimeMessage message = javaMailSender.createMimeMessage();

		message.addRecipients(RecipientType.TO, to);// 보내는 대상
		message.setSubject("QUICKet 회원 탈퇴 처리 안내");// 제목

		String msgg = "";
		msgg += "<div style='margin:100px;'>";
		msgg += "<h1>QUICKet 회원 탈퇴 처리 안내</h1>";
		msgg += "<h2>안녕하세요. QUICKet입니다.</h2>";
		msgg += "<br>";
		msgg += "<div align='center' style='border:1px solid black; font-family:verdana';>";
		msgg += "<h3>관리자에 의해 QUICKet 탈퇴 처리가 되었음을 알려드립니다. 감사합니다.</h3>";
		message.setText(msgg, "utf-8", "html");// 내용, charset 타입, subtype
		// 보내는 사람의 이메일 주소, 보내는 사람 이름
		message.setFrom(new InternetAddress("yubinn2@naver.com", "QUICKet 관리자"));// 보내는 사람

		return message;
	}
	
	public String createKey() {
		StringBuffer key = new StringBuffer();
		Random rnd = new Random();

		for (int i = 0; i < 6; i++) { // 인증코드 6자리
			int index = rnd.nextInt(3); // 0~2 까지 랜덤, rnd 값에 따라서 아래 switch 문이 실행됨

			switch (index) {
			case 0:
				key.append((char) ((int) (rnd.nextInt(26)) + 97));
				// a~z (ex. 1+97=98 => (char)98 = 'b')
				break;
			case 1:
				key.append((char) ((int) (rnd.nextInt(26)) + 65));
				// A~Z
				break;
			case 2:
				key.append((rnd.nextInt(10)));
				// 0~9
				break;
			}
		}

		return key.toString();
	}

	
	public String sendMessage(String to) throws Exception {
		key = createKey(); // 랜덤 인증번호 생성

		// TODO Auto-generated method stub
		MimeMessage message = createMessage(to); // 메일 발송
		try {// 예외처리
			javaMailSender.send(message);
		} catch (MailException es) {
			es.printStackTrace();
			//throw new IllegalArgumentException();
		}


		return key; // 메일로 보냈던 인증 코드를 서버로 반환
	}
	
	public String mailDelete(String to) throws Exception {
		String result = "";
		MimeMessage message = createDeleteMail(to);
		try {
			javaMailSender.send(message);
			result = "전송 완료";
			
		} catch (MailException es) {
			es.printStackTrace();
			result = "전송 실패";
		}
		
		return result;
	}
	
	
	  public MimeMessage createMailAndChangePassword(String to) throws MessagingException, UnsupportedEncodingException{
		  
		  log.info("보내는 대상 : " + to);
			log.info("임시 비밀 번호 : " + pwd);
			
			MimeMessage message = javaMailSender.createMimeMessage();

			message.addRecipients(RecipientType.TO, to);// 보내는 대상
			message.setSubject("QUICKet 임시 비밀번호");// 제목

			String msgg = "";
			msgg += "<div style='margin:100px;'>";
			msgg += "<h1>QUICKET 임시 비밀번호</h1>";
			msgg += "<h2>안녕하세요. QUICKet입니다.</h2>";
			msgg += "<br>";
			msgg += "<h4>임시 비밀번호 안내 이메일입니다.</h4>";
			msgg += "<br>";
			msgg += "<div align='center' style='border:1px solid black; font-family:verdana';>";
			msgg += "<h3 style='color:blue;'>변경된 임시 비밀번호입니다.<br>임시 비밀번호로 로그인을 하신 후, 비밀번호를 수정하시길 바랍니다.</h3>";
			msgg += "<div style='font-size:130%'>";
			msgg += "CODE : <strong>";
			msgg += pwd + "</strong><div><br/> "; // 메일에 인증번호 넣기
			msgg += "</div>";
			message.setText(msgg, "utf-8", "html");// 내용, charset 타입, subtype
			// 보내는 사람의 이메일 주소, 보내는 사람 이름
			message.setFrom(new InternetAddress("yubinn2@naver.com", "QUICKet 관리자"));// 보내는 사람

			return message;

	    }

	   /* public void updatePassword(String str,String userEmail){
	        String pw = EncryptionUtils.encryptMD5(str);
	        int id = userRepository.findUserByUserId(userEmail).getId();
	        userRepository.updateUserPassword(id,pw);
	    } */
	  
		public String sendTempPwd(String to) throws Exception {
			pwd = getTempPassword(); // 랜덤 인증번호 생성

			// TODO Auto-generated method stub
			MimeMessage message = createMailAndChangePassword(to); // 메일 발송
			try {// 예외처리
				javaMailSender.send(message);
			} catch (MailException es) {
				es.printStackTrace();
				//throw new IllegalArgumentException();
			}


			return pwd; // 메일로 보냈던 인증 코드를 서버로 반환
		}


	    public String getTempPassword(){
	        char[] charSet = new char[] { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F',
	                'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z' };

	        String str = "";

	        int idx = 0;
	        for (int i = 0; i < 10; i++) {
	            idx = (int) (charSet.length * Math.random());
	            str += charSet[idx];
	        }
	        return str;
	    }
}
