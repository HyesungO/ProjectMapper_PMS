package kr.or.ddit.users.review.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.projects.vo.ReviewVO;
import kr.or.ddit.users.review.mapper.ReviewMapper;

@Service
public class ReviewServiceImpl implements ReviewService {

	@Autowired
	private ReviewMapper mapper;

	@Override
	public List<ReviewVO> readReviewedList(String reviewedId) {
		// TODO Auto-generated method stub
		return mapper.selectReviewedList(reviewedId);
	}

	@Override
	public List<ReviewVO> readReviewerList(String reviewerId) {
		// TODO Auto-generated method stub
		return mapper.selectReviewerList(reviewerId);
	}

	@Override
	public ReviewVO readReview(String reviewId) {
		// TODO Auto-generated method stub
		return mapper.selectReview(reviewId);
	}

	@Override
	public ServiceResult createReview(ReviewVO review) {
		int reviewCnt = mapper.insertReview(review);
		ServiceResult result = reviewCnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
		return result;
	}

	@Override
	public ServiceResult modifyReview(ReviewVO review) {
		// TODO Auto-generated method stub
		int reviewCnt = mapper.updateReview(review);
		ServiceResult result = reviewCnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
		return result;
	}

	@Override
	public ServiceResult removeReview(String reviewId) {
		int reviewCnt = mapper.deleteReview(reviewId);
		ServiceResult result = reviewCnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
		return result;
	}

	@Override
	public List<ReviewVO> reviewerListwithpjid(String pjId, String reviewerId) {
		return mapper.selectReviewerListWithpjId(pjId,reviewerId);
	}


	
	


}
