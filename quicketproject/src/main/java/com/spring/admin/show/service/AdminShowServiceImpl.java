package com.spring.admin.show.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.spring.admin.img.dao.AdminImgDao;
import com.spring.admin.show.dao.AdminShowDao;
import com.spring.client.show.vo.ImgVO;
import com.spring.client.show.vo.RankVO;
import com.spring.client.show.vo.ShowVO;
import com.spring.common.file.ImgUploadUtil;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class AdminShowServiceImpl implements AdminShowService {	
	@Setter(onMethod_=@Autowired)
	private AdminShowDao adminShowDao;
	@Setter(onMethod_=@Autowired)
	private AdminImgDao adminImgDao;

	@Override
	public List<ShowVO> showList(ShowVO vo) {
		List<ShowVO> showList = adminShowDao.showList(vo);
		if(showList!=null) {
			for(ShowVO show : showList) {
				ImgVO poster = adminImgDao.posterImg(show);
				if(poster!=null) {
					show.setS_posterimg(poster);
				}
			}
		}
		return showList;
	}

	@Override
	public ShowVO showDetail(ShowVO vo) {
		ShowVO result = adminShowDao.showDetail(vo);
		ImgVO poster = adminImgDao.posterImg(vo);
		if(result!=null) {
			if(poster!=null) {
				result.setS_posterimg(poster);
			}
			List<ImgVO> detailImg = adminImgDao.detailImg(vo);
			if(detailImg!=null) {
				result.setS_detailimg(detailImg);
			}
		}
		return result;
	}

	@Override
	public int showInsert(ShowVO vo) throws Exception {
		int result = 0;
		
		//문자형 데이터 먼저 입력
		result = adminShowDao.showInsert(vo);
		
		if(result==1) {	//입력 성공 시 파일 업로드 실행(이 순서로 안하면 제약규칙에 따른 에러가 발생함.
			//포스터 이미지 입력
			if(vo.getS_posterfile().getSize()>0) {
				//기존에 해당 번호의 공연 포스터 이미지가 있을 경우 그 이미지를 없앤다.
				ImgVO posterCheck = adminImgDao.posterImg(vo);
				if(posterCheck!=null && posterCheck.getImg_id()>0) {
					ImgUploadUtil.imgDelete(posterCheck);
					adminImgDao.deleteImg(posterCheck);
				}
				ImgVO s_posterimg = ImgUploadUtil.imgUpload(vo.getS_posterfile(), "poster", vo.getS_num());
				adminImgDao.insertImg(s_posterimg);
			}
			//디테일 이미지 입력
			if(vo.getS_detailfile()!=null && vo.getS_detailfile().size()>0) {
				List<MultipartFile> files = vo.getS_detailfile();
				for(MultipartFile file:files) {
					if(file.getSize()>0) {
						ImgVO imgData = ImgUploadUtil.imgUpload(file, "detail", vo.getS_num());
						adminImgDao.insertImg(imgData);
					}
				}
			}
		}
		
		return result;
	}

	@Override
	public int showUpdate(ShowVO vo) throws Exception {
		int result = 0;
		
		//이미지 처리를 service에 따로 명시해서 교체기능을 만든다.
		
		//포스터 이미지 : 이미지가 새로 담겨있으면 기존 이미지를 삭제하고 새 이미지를 담아주고, 그게 아니면 그냥 둔다.
		if(vo.getS_posterfile().getSize()>0) {
			//이미지가 새로 담긴 경우 기존 이미지 삭제 (insert의 이미지 체크와 동일)
			ImgVO oldposter = adminImgDao.posterImg(vo);
			if(oldposter!=null && oldposter.getImg_id()>0) {
				ImgUploadUtil.imgDelete(oldposter);
				adminImgDao.deleteImg(oldposter);
			}
			ImgVO newposter = ImgUploadUtil.imgUpload(vo.getS_posterfile(), "poster", vo.getS_num());
			adminImgDao.insertImg(newposter);
		}
		
		//디테일 이미지 : 이미지 리스트를 불러와서 기존 이미지 중에 삭제된 것이 있으면 제거하고, 새로 올라온 파일은 추가한다.
		//1. 원래 보유한 이미지 리스트를 테이블에서 불러오기
		List<ImgVO> oldlist =  adminImgDao.detailImg(vo);
		//2. 올라온 이미지 번호 리스트를 객체 리스트로 변환하고 업로드 객체에서 확인하기
		String s_detail_str = vo.getS_detail_str();
		List<ImgVO> newlist = null;
		if(s_detail_str!=null && s_detail_str!=""){
			newlist= new ArrayList<ImgVO>();
			String[] new_files = vo.getS_detail_str().split(",");
			log.info("s_detail_str : " + s_detail_str);
			for(int i=0; i<new_files.length; i++ ) {log.info(new_files[i]);}
			if(new_files.length>0) {
				for(int i=0; i<new_files.length; i++) {
					String img_id = new_files[i];
					if(!img_id.isEmpty()&&!img_id.isBlank()) {
						ImgVO svo = new ImgVO();
						svo.setImg_id(Integer.parseInt(img_id));
						ImgVO savedimg = adminImgDao.oneImg(svo);
						newlist.add(savedimg);
					}
				}
			}
		}
		//3. 원래 보유한 이미지 리스트에서 올라온 이미지 리스트에 없는 내용을 확인하여 파일과 정보를 삭제하기
		if(oldlist!=null) {
			if(newlist!=null && !newlist.isEmpty()) {
				//신규 리스트에 데이터가 하나라도 존재하면 대조작업을 거친다.
				for(ImgVO olddata : oldlist) {
					if(!newlist.contains(olddata)) {
						ImgUploadUtil.imgDelete(olddata);
						adminImgDao.deleteImg(olddata);
					}
				}
			}else {
				//신규 리스트가 아예 존재하지 않는 경우 = 다 지운 경우 대조작업 없이 날린다.
				for(ImgVO olddata : oldlist) {
					ImgUploadUtil.imgDelete(olddata);
					adminImgDao.deleteImg(olddata);
				}
			}
		}
		//4. 파일리스트로 새로 올라온게 있으면 추가한다.
		if(vo.getS_detailfile()!=null && vo.getS_detailfile().size()>0) {
			List<MultipartFile> files = vo.getS_detailfile();
			for(MultipartFile file:files) {
				if(file.getSize()>0) {
					ImgVO imgData = ImgUploadUtil.imgUpload(file, "detail", vo.getS_num());
					adminImgDao.insertImg(imgData);
				}
			}
		}
		
		result = adminShowDao.showUpdate(vo);
		return result;
	}

	@Override
	public int showDelete(ShowVO vo) throws Exception {
		int result = 0;
		//우선 가지고 있는 모든 이미지 데이터를 조회
		List<ImgVO> allImg = adminImgDao.allImg(vo);
		if(allImg!=null && !allImg.isEmpty()) {	//이미지가 존재하는 경우에는 파일을 날린다.
			for(ImgVO img : allImg) {
				ImgUploadUtil.imgDelete(img);
			}
		}
		//제약조건에 따라 공연이 삭제되면 이미지 파일도 같이 삭제된다.
		result = adminShowDao.showDelete(vo);
		return result;
	}

	@Override
	public int showListCnt(ShowVO vo) {
		int result = adminShowDao.showListCnt(vo);
		return result;
	}
}
