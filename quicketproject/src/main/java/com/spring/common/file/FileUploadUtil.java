package com.spring.common.file;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;

import org.imgscalr.Scalr;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class FileUploadUtil { 

	/***********************************************************
	 * 파일 업로드할 폴더 생성
	 **********************************************************/
	public static void makeDir(String docRoot) {
		File fileDir = new File(docRoot);
		if(fileDir.exists()) 
			return;
		fileDir.mkdirs();
	}
	
	/***********************************************************
	 * 파일 업로드 메서드
	 * 파일명 중복시 해결방법
	 * 1. System.currentTimeMillis()를 사용하거나(연월일시분초 사용) 2. UUID 사용
	 * UUID는 128비트의 수
	 * 표준 형식에서 UUID는 32개의 16진수로 표현되며 총 36개 문자(32개 문자와 4개의 하이픈)로 된
	 * 8-4-4-4-12라는 5개 그룹을 하이픈으로 구분한다. 이를 테면 다음과 같다.
	 * 이 때 UUID.randomUUID().toString()를 이용해서 얻는다.
	 * 50e8400-e29b-41d4-a716-446655440000 (replace로 하이픈 제거 가능)
	 **********************************************************/
	public static String fileUpload(MultipartFile file, String fileName) throws IOException {
		// MultipartFile -> 파일 자체 전달받음 fileName -> 어느 쪽 사진인지(board..) 명시해서 파일 이름 저장
		
		log.info("fileUpload 호출 성공");
		
		String real_name = null;
		// MultipartFile 클래스의 getFile() 메서드로 클라이언트가 업로드한 파일
		String org_name = file.getOriginalFilename(); // ex) a.gif
		log.info("업로드 파일명 :" + org_name);
		
		// 파일명 변경(중복되지 않게)
		if(org_name != null && (!org_name.equals(""))) {
			real_name = fileName +"_"+ System.currentTimeMillis()+"_"+ org_name; // 저장할 파일 이름 ex) board_000000_a.gif
			String docRoot = "C://uploadStorage//"+fileName; // C://uploadStorage//board
			makeDir(docRoot); // 폴더 생김
			
			File fileAdd = new File(docRoot + "/" + real_name); // C://uploadStorage//board/board_000000_a.gif
			log.info("업로드할 파일(fileAdd) : " + fileAdd);
			
			file.transferTo(fileAdd); // 이 메서드에 의해 저장 경로에 실질적으로 File이 생성됨
		}
		return real_name; // 서버에 저장된 파일명 반환(board_1658205347977_cat.jpg)
	}
	
	/***********************************************************
	 * 파일 삭제 메서드 - 게시글 삭제하면 파일도 같이 삭제 되게 해야 함
	 * 경로 및 파일명: board/board_1658205347977_cat.jpg
	 * Thumbnail 경로 및 파일명: board/thumbnail/thumbnail_board_1658205347977_cat.jpg
	 **********************************************************/
	public static void fileDelete(String fileName) throws IOException { // fileName = thumbnail_board_1658205347977_cat.jpg
		log.info("fileDelete 호출 성공");
		boolean result = false;
		String startDirName = "", docRoot = "";
		String dirName = fileName.substring(0, fileName.indexOf("_")); // dirName = thumbnail
		
		if(dirName.equals("thumbnail")) {
			startDirName = fileName.substring(dirName.length()+1, fileName.indexOf("_", dirName.length()+1)); // board
			//						thumbnail의 길이수+1부터 시작하여, thumbnail의 길이수+1 다음부터 시작하여 만나는 _ 전까지 substring
			docRoot = "C://uploadStorage//"+startDirName+"//"+dirName; // C://uploadStorage//board//thumbnail
		} else {
			docRoot = "C://uploadStorage//"+dirName; // C://uploadStorage//board
		}
		
		File fileDelete = new File(docRoot+"/"+fileName); // C://uploadStorage//board//thumbnail/thumbnail_board_1658205347977_cat.jpg
		
		if(fileDelete.exists() && fileDelete.isFile()) {
			result = fileDelete.delete();
		}
		log.info("파일 삭제 여부(true/false) : " + result);
	}
	
	/***********************************************************
	 * 파일 Thumbnail 생성 메서드
	 * 큰 이미지 줄이면 해상도 깨질 수 있으니 아예 파일 크기 바꿈
	 * Thumbnail 경로 및 파일명: thumbnail/thumbnail_board_1658205347977_cat.jpg (활용도 고려 해서 명칭 주기)
	 **********************************************************/
	public static String makeThumbnail(String fileName) throws Exception { // 원본파일 fileName = board_1658205347977_cat.jpg
		String dirName = fileName.substring(0,fileName.indexOf("_")); // 폴더 이름 추출 dirName = board
		// 이미지가 존재하는 폴더 추출
		String imgPath = "C://uploadStorage//"+dirName;
		// 추출된 폴더의 실제 경로(물리적 위치: C:\...)
		File fileAdd = new File(imgPath, fileName); // 파일 객체 만들기 C://uploadStorage//board//board_1658205347977_cat.jpg
		log.info("원본 이미지 파일(fileAdd) : " + fileAdd);
		
		BufferedImage sourceImg = ImageIO.read(fileAdd); // fileAdd에 해당하는 이미지 파일을 읽어와서 데이터로 저장
		BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT, 133); // 크기를 조정하여 이미지 데이터 저장
									// resize(대상[BufferedImage 타입]=원본이미지, 원본비율(가로세로비율), 높이 또는 너비, 크기)
		
		String thumbnailName = "thumbnail_"+fileName; // thumbnail_board_1658205347977_cat.jpg
		String docRoot = imgPath+"/thumbnail"; // 썸네일 폴더 생성 C://uploadStorage//board//thumbnail
		makeDir(docRoot);
		
		File newFile = new File(docRoot, thumbnailName); // C://uploadStorage//board//thumbnail_board_1658205347977_cat.jpg
		// 파일명과 확장자명 추출해야 저장 가능(라이브러리 방법)
		log.info("업로드할 파일(newFile) : " +newFile);
		
		String formatName = fileName.substring(fileName.lastIndexOf(".")+1); // 확장자: jpg
		log.info("확장자(formatName) : " +formatName);
		
		ImageIO.write(destImg, formatName, newFile); // 조정한 이미지 데이터를 생성한 파일에 저장 (이미지 사이즈 줄인 이미지, 확장자, 파일객체)
		
		return thumbnailName; // 서버에 저장된 파일명 반환(thumbnail_board_1658205347977_cat.jpg)
	}
	
}
