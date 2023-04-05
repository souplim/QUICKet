package com.spring.client.review.controller;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.spring.client.paypage.vo.UserVO;
import com.spring.client.review.service.ReviewService;
import com.spring.client.review.vo.ReviewVO;
import com.spring.client.show.service.ClientShowService;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping(value="/reviewList")
@Slf4j
public class ReviewController {   

      @Setter(onMethod_ = @Autowired)
      private ReviewService reviewService;
      
      @Setter(onMethod_ = @Autowired)
      private ClientShowService clientShowService;
      
      /***************************************************************************************
       * 댓글 글목록 구현하기
       * @return List<ReviewVO>
       * 참고 : @PathVariable는 URI의 경로에서 원하는 데이터를 추출하는 용도의 어노테이션.
       * 응답 문서 타입을 xml이나 json으로 반환할 때는 produces 속성을 사용한다.
       * produces = { MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_VALUE }
       * 현재 요청 URL : http://localhost:8080/replies/all/게시판글번호(b_num)
       * 예전 요청 URL : http://localhost:8080/replies/ReviewList?b_num=게시판글번호
       * ResponseEntity는 개발자가 직접 결과 데이터와 HTTP 상태 코드(200, 404, 500..)를 직접 제어할 수 있는 클래스.
       **************************************************************************************/
   
       @GetMapping(value = "/all/{s_num}", produces=MediaType.APPLICATION_JSON_VALUE)
       public List<ReviewVO> reviewList(@PathVariable("s_num") Integer s_num) {
          log.info("list 호출 성공");
          
          List<ReviewVO> entity = null;         
          entity = reviewService.reviewList(s_num);
          return entity;          
       } 
       
       /**************************************************************
          * 댓글 추가 구현하기
           **********************************************************
       @PostMapping(value = "/reviewInsert", consumes = "application/json", produces = MediaType.TEXT_PLAIN_VALUE)
         public String reviewInsert(@RequestBody ReviewVO rvo) { // {b_num:1, r_name:홍길동 ... }
            log.info("reviewInsert 호출 성공");
            log.info("ReviewVO : "+rvo);
            int result = 0;
            result = reviewService.reviewInsert(rvo);
            
             
           if(result==1) {clientShowService.showPointUpdate(rvo);}
            
            return (result==1) ? "SUCCESS": "FAILURE";
         }***/
       
       
       /**************************************************************
          * 댓글 추가 구현하기 user_id 가져오기 추가
           *************************************************************/
       @PostMapping(value = "/reviewInsert", consumes = "application/json", produces = MediaType.TEXT_PLAIN_VALUE)
         public String reviewInsert(@RequestBody ReviewVO rvo, @ModelAttribute("userLogin") UserVO userVO) { // {b_num:1, r_name:홍길동 ... }
            log.info("reviewInsert 호출 성공");
            log.info("ReviewVO : "+rvo);
            int result = 0;            
            
            result = reviewService.reviewInsert(rvo); 
             
           if(result==1) {clientShowService.showPointUpdate(rvo);}
           rvo.setU_id(userVO.getU_id());
            
           return (result==1) ? "SUCCESS": "FAILURE";
         }
         
         /**************************************************************
          * 댓글 수정 구현하기
          * @return 
          * 참고 : REST 방식에서 UPDATE 작업은 PUT, PATCH방식을 이용해서 처리.
          *       전체 데이터를 수정하는 경우에는 PUT을 이용하고, 
          *       일부의 데이터를 수정하는 경우에는 PATCH를 이용하나 일반적으로 PUT을 이용.
          * 현재 요청 URL : http://localhost:8080/replies/댓글번호
          **************************************************************/     
          
          @PutMapping(value = "/{r_no}", consumes = "application/json", produces = MediaType.TEXT_PLAIN_VALUE )
          public String reviewUpdate(@PathVariable("r_no") int r_no, @RequestBody ReviewVO rvo) {
             log.info("reviewUpdate 호출 성공");
             
             rvo.setR_no(r_no);
             int result = reviewService.reviewUpdate(rvo);
             return (result==1) ? "SUCCESS": "FAILURE"; 
          }
   
         /**************************************************************
          * 댓글 삭제 구현하기
          * @return 
          * 참고 : REST 방식에서 삭제 작업은 DELETE 방식을 이용해서 처리.
          * 현재 요청 URL : http://localhost:8080/replies/댓글번호
          **************************************************************/        
           
           @DeleteMapping(value = "/{r_no}", produces =  MediaType.TEXT_PLAIN_VALUE )
           public String reviewDelete(@PathVariable("r_no") int r_no) {
              log.info("reviewDelete 호출 성공");
              log.info("r_no = " + r_no );
              
              int result = reviewService.reviewDelete(r_no);
              return (result==1) ? "SUCCESS": "FAILURE";  
           }
    
   
   }