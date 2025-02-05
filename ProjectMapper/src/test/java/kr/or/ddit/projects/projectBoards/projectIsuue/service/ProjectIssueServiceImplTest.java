package kr.or.ddit.projects.projectBoards.projectIsuue.service;

import static org.junit.jupiter.api.Assertions.*;

import javax.inject.Inject;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.annotation.RootContextWebConfig;
import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.projects.vo.IssueVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RootContextWebConfig
@Transactional
class ProjectIssueServiceImplTest {
	
	@Inject
	ProjectIssueService service;
	
	IssueVO issue;
	
//	@BeforeEach
//	void beforeEach() {
//		issue = new IssueVO();
//		issue.setIssueRequesterId("USER001");
//		issue.setPjId("P0200001");
//		issue.setIssueTitle("testtitle");
//		issue.setIssueContent("testcontent");
//		issue.setIssueImpCode("IO201");
//		issue.setIssueTypeCode("IO102");
//		assertEquals(ServiceResult.OK, service.createIssue(issue));
//	}
//	
//	@Test
//	void testCreateIssue() {
//		fail("Not yet implemented");
//	}

	@Test
	void testReadIssueList() {
		assertDoesNotThrow(()-> service.readIssueList("P0200001"));
	}

	@Test
	void testReadIssue() {
		log.info("list : {}" , service.readIssue("IS000020"));
//		assertDoesNotThrow(()-> service.readIssue("IS000020"));
	}

//	@Test
//	void testModifyIssue() {
//		issue.setIssueTitle("수정제목");
//		issue.setIssueTypeCode("IO101");
//		assertEquals(ServiceResult.OK, service.modifyIssue(issue));
//	}

	@Test
	void testRemoveIssue() {
		assertEquals(ServiceResult.OK, service.removeIssue(issue.getIssueId()));
	}

}
