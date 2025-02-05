package kr.or.ddit.projects.comment.mapper;

import static org.junit.jupiter.api.Assertions.*;

import javax.inject.Inject;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.annotation.RootContextWebConfig;
import kr.or.ddit.projects.projectBoards.projectIsuue.mapper.ProjectIssueMapper;
import kr.or.ddit.projects.vo.IssueCommentVO;
import kr.or.ddit.projects.vo.IssueVO;

@RootContextWebConfig
@Transactional
class ProjectIssueCommentMapperTest {
	
	@Inject
	ProjectIssueCommentMapper mapper;

	IssueCommentVO comment;
	
	@BeforeEach
	void beforeEach() {
		comment = new IssueCommentVO();
		comment.setIssueId("IS000001");
		comment.setPjCommentMemId("USER001");
		comment.setIssueCommentContent("댓글테스트내용");
		mapper.insertIssueComment(comment);
		assertEquals(1, mapper.insertIssueComment(comment));
	}
	
//	@Test
//	void testInsertIssueComment() {
//		comment = new IssueCommentVO();
//		comment.setIssueId("IS000001");
//		comment.setPjCommentMemId("USER001");
//		comment.setIssueCommentContent("댓글테스트내용");
//		mapper.insertIssueComment(comment);
//		assertEquals(1, mapper.insertIssueComment(comment));
//	}

	@Test
	void testSelelctIssueCommentList() {
		assertDoesNotThrow(()-> mapper.selelctIssueCommentList("IS000001"));
	}

	@Test
	void testUpdateIssueComment() {
		comment.setIssueCommentContent("댓글수정테스트내용");
		assertEquals(1, mapper.updateIssueComment(comment));
	}

	@Test
	void testDeleteIssueComment() {
		assertEquals(1, mapper.deleteIssueComment(comment.getIssueCommentId()));
	}

}
