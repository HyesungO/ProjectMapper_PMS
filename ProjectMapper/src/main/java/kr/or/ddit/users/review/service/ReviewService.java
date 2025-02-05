package kr.or.ddit.users.review.service;

import java.util.List;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.projects.vo.DailyTaskVO;
import kr.or.ddit.projects.vo.ReviewVO;

public interface ReviewService {
	
	
	/**
	 * 받은 리뷰를 리스트로 조회하는 메서드
	 * @param reviewedId
	 * @return
	 */
	public List<ReviewVO> readReviewedList(String reviewedId);
	
	/**
	 * 준 리뷰를 리스트로 조회하는 메서드
	 * @param reviewerId
	 * @return
	 */
	public List<ReviewVO> readReviewerList(String reviewerId);
	
	/**
	 * 리뷰 상세조회하는 메서드
	 * @param reviewId
	 * @return
	 */
	public ReviewVO readReview(String reviewId);
	

	/**
	 * 리뷰를 생성하는 메서드
	 * @param review
	 * @return ServiceResult(fail,ok)
	 */
	public ServiceResult createReview(ReviewVO review);
	
	/**
	 * 리뷰를 수정하는 메서드 
	 * @param review
	 * @return ServiceResult(fail,ok)
	 */
	public ServiceResult modifyReview(ReviewVO review);
	
	/**
	 * 리뷰를 삭제하는 메서드 
	 * @param reviewId
	 * @return ServiceResult(fail,ok)
	 */
	public ServiceResult removeReview(String reviewId);

	/**
	 * @param pjId
	 * @param reviewerId
	 */
	public List<ReviewVO> reviewerListwithpjid(String pjId, String reviewerId);
}
