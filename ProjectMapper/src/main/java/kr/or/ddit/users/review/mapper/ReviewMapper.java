package kr.or.ddit.users.review.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.projects.vo.ReviewVO;

@Mapper
public interface ReviewMapper {
	//받은 리뷰를 리스트로 조회하는 메서드
	public List<ReviewVO> selectReviewedList(String reviewedId);
	//준 리뷰를 리스트로 조회하는 메서드
	public List<ReviewVO> selectReviewerList(String reviewerId);
	//리뷰 상세조회하는 메서드
	public ReviewVO selectReview(String reviewId);
	//리뷰를 생성하는 메서드
	public int insertReview(ReviewVO review);
	//리뷰를 수정하는 메서드 
	public int updateReview(ReviewVO review);
	//리뷰를 삭제하는 메서드
	public int deleteReview(String reviewId);
	//pjid와 reviewerId가 포함된 리스트를 들고오는 메서드 
	public List<ReviewVO> selectReviewerListWithpjId(@Param("pjId") String pjId,@Param("reviewerId") String reviewerId);
}
