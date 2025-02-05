package kr.or.ddit.users.review.service;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.fail;

import java.util.List;

import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.annotation.RootContextWebConfig;
import kr.or.ddit.projects.vo.ReviewVO;

@RootContextWebConfig

class ReviewServiceImplTest extends ReviewServiceImpl {
	@Autowired
	public ReviewService service;
	@Disabled
	@Test
	void testReadReviewedList() {
	    List<ReviewVO> result = assertDoesNotThrow(() -> service.readReviewedList("USER002"));
	    assertNotNull(result, "결과가 null입니다.");
	    assertFalse(result.isEmpty(), "결과 리스트가 비어 있습니다.");
	}
	
	@Disabled
	@Test
	void testReadDailyReviewerList() {
		System.out.println(service.readReviewerList("USER004"));
	    
	}
	@Disabled
	@Test
	void testReadReviewe() {
		System.out.println(service.readReview("RV00000002"));
	}
	@Disabled
	@Test
	void testCreateReviewe() {
		ReviewVO vo = new ReviewVO();
		vo.setReviewId("PR000001");
		vo.setReviewSummary("다신하기 싫어용");
		vo.setCollabScroe(3);
		vo.setCommScore(5);
		vo.setExpertScroe(3);
		vo.setPerforScroe(4);
		vo.setProblemScroe(3);
		vo.setSatisfyScroe(4);
		System.out.println(service.modifyReview(vo));
	}
	@Disabled
	@Test
	void testModifyReviewe() {
		ReviewVO vo = new ReviewVO();
		vo.setPjId("P0200011");
		vo.setReviewerId("USER006");
		vo.setReviewedId("USER010");
		vo.setReviewSummary("다신하기 싫어용");
		vo.setCollabScroe(3);
		vo.setCommScore(4);
		vo.setExpertScroe(5);
		vo.setPerforScroe(4);
		vo.setProblemScroe(3);
		
		System.out.println(service.createReview(vo));
	}
	
	@Test
	void testRemoveReviewe() {
		System.out.println(service.removeReview("PR000001"));
	}

}
