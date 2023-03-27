package com.spring.common.file;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;

import org.imgscalr.Scalr;
import org.springframework.web.multipart.MultipartFile;

import com.spring.client.show.vo.ImgVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class ImgUploadUtil {
	
	/****************************
	* 파일 업로드할 폴더 자동 생성      
	****************************/
	public static void makeDir(String docRoot) {
		File fileDir = new File(docRoot);
		
		if(fileDir.exists()) {
			return;
		}
		fileDir.mkdirs();
	}
	
	/************************************************************************
	 * 파일 업로드 메서드      
	 * 파일명이 중복될 경우 해결 방법
	 * System.currentTimeMillis()를 사용하거나 UUID는 128비트의 수이다.
	 * 표준 형식에서 UUID는 32개의 16진수로 표현되며, 32개 문자와 4개의 하이픈(-)로
	 * 된 8-4-4-4-12라는 5개의 그룹을 하이픈으로 구분한다. (총 36문자)
	 * 예) 50e8400-e29b-41d4-a716-446655440000
	 * 이때 UUID는 UUID.randomUUID().toString()을 통해서 얻는다.
	 * 매개변수 : file(파일) img_purpose(이미지 용도), s_num(이미지를 사용하는 공연번호)
	************************************************************************/
	public static ImgVO imgUpload(MultipartFile file, String img_purpose, int s_num) throws IOException {
		log.info("fileUpload 호출 성공");
		
		//ImgVO 객체 생성
		ImgVO imgData = new ImgVO();
		
		//이미지 파일 용량을 구함 (바이트 단위, 소수점은 버림)
		int img_size = (int) file.getSize();
		
		String real_name=null;
		//MultipartFile 클래스의 getFile() 매서드로 클라이언트가 업로드한 파일
		String org_name = file.getOriginalFilename();
		log.info("업로드 파일명 : "+org_name);
		
		//파일의 경로 자동생성 규칙 : "/show/공연번호/이미지용도(poster 혹은 detail)
		String img_dir =  "/show/"+s_num+"/"+img_purpose;
		
		//파일명 변경(중복시)
		if(org_name!=null && (!org_name.equals(""))) {
			real_name = System.currentTimeMillis()+"_"+s_num+"_"+org_name; 
			//저장할 파일명 : 1658205347977_1_001p.jpg
			
			//확장자를 제외한 파일명 구하기
			String img_name = real_name.substring(0, real_name.lastIndexOf("."));
			//확장자 구하기
			String img_type = real_name.substring(real_name.lastIndexOf(".")+1);
			
			String real_dir = "C://uploadStorage//"+img_dir;
			makeDir(real_dir);
			
			File fileAdd = new File(real_dir+"/"+real_name);
			log.info("업로드할 파일(fileAdd) :" + fileAdd);
			
			//이 메서드를 통해 저장경로에 실제로 file이 생성됨
			file.transferTo(fileAdd);
			
			//imgData에 값을 넣기
			imgData.setS_num(s_num);
			imgData.setImg_name(img_name);
			imgData.setImg_dir(img_dir);
			imgData.setImg_type(img_type);
			imgData.setImg_size(img_size);	
		}
		//서버에 실제로 저장된 파일명 반환 (/show/1/poster/1658205347977_1_001p.jpg)
		return imgData;
	}
	
	/************************************************************************
	 * 파일 삭제 메서드      
	 * 경로 및 파일명: show/1/poster/1658205347977_1_001p.jpg
	************************************************************************/
	public static void imgDelete(ImgVO vo) throws IOException{
		log.info("fileDelete 호출 성공");
		boolean result = false;
		
		// fileName = 1658205347977_1_001p.jpg
		String fileName = vo.getImg_name()+"."+vo.getImg_type();
		log.info("삭제 대상 파일명 : " + fileName);
		String img_dir = vo.getImg_dir();		
		// docRoot = C://uploadStorage//show/1/poster
		String docRoot = "C://uploadStorage//" + img_dir;
		
		File fileDelete = new File(docRoot+"/"+fileName);
		
		if(fileDelete.exists() && fileDelete.isFile()) {
			result = fileDelete.delete();
		}
		log.info("파일 삭제 여부(true/false) : " + result);
	}
}
