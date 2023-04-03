package com.spring.admin.img.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.spring.client.show.vo.ImgVO;
import com.spring.client.show.vo.ShowVO;

@Mapper
public interface AdminImgDao {
	public ImgVO posterImg(ShowVO vo);
	public List<ImgVO> detailImg(ShowVO vo);
	public List<ImgVO> allImg(ShowVO vo);
	public ImgVO oneImg(ImgVO vo);
	public int insertImg(ImgVO vo);
	public int deleteImg(ImgVO vo);

}
