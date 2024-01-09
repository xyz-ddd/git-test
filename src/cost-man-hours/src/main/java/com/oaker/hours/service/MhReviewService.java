package com.oaker.hours.service;


import com.oaker.hours.doman.dto.MhReviewDTO;
import com.oaker.hours.doman.dto.UserHourSaveDTO;
import com.oaker.hours.doman.vo.UserHourReviewVO;

import java.time.LocalDate;
import java.util.List;

/**
 * @Description :  工时审核接口
 * <功能详细描述>
 * @author: sixfly
 * @Data : 2023年10月27日 19:28:09
 */
public interface MhReviewService {

      void  setReview(long resultId,UserHourSaveDTO userHourSaveDTO);


      List<UserHourReviewVO> query(MhReviewDTO mhReviewDTO, LocalDate localDate);
}
