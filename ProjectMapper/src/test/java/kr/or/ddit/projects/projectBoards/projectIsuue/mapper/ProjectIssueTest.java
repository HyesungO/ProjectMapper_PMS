package kr.or.ddit.projects.projectBoards.projectIsuue.mapper;

import static org.junit.jupiter.api.Assertions.*;

import javax.inject.Inject;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.annotation.RootContextWebConfig;
import kr.or.ddit.projects.vo.IssueVO;

@RootContextWebConfig
@Transactional
class ProjectIssueTest {
	
	@Inject
	ProjectIssueMapper mapper;
	
	IssueVO issue;
	
	@BeforeEach
	void beforeEach() {
		issue = new IssueVO();
		issue.setIssueRequesterId("USER001");
		issue.setPjId("P0200001");
		issue.setIssueTitle("testtitle");
		issue.setIssueContent("testcontent");
		issue.setIssueImpCode("IO201");
		issue.setIssueTypeCode("IO102");
		assertEquals(1, mapper.insertIssue(issue));
	}
	
//	@Test
//	void testInsertIssue() {
//		issue = new IssueVO();
//		issue.setIssueRequesterId("USER001");
//		issue.setPjId("P0200001");
//		issue.setIssueTitle("testtitle");
//		issue.setIssueContent("testcontent");
//		issue.setIssueImpCode("IO201");
//		issue.setIssueTypeCode("IO102");
//		assertEquals(1, mapper.insertIssue(issue));
//	}

	@Test
	void testSelectIssueList() {
		assertDoesNotThrow(()-> mapper.selectIssueList("P0200001"));
	}

	@Test
	void testSelectIssue() {
		assertDoesNotThrow(()-> mapper.selectIssue("IS000001"));
	}

	@Test
	void testUpdateIssue() {
		issue.setIssueTitle("수정제목");
		issue.setIssueTypeCode("IO101");
		assertEquals(1, mapper.updateIssue(issue));
	}

	@Test
	void testDeleteIssue() {
		assertEquals(1, mapper.deleteIssue(issue.getIssueId()));
	}

}
