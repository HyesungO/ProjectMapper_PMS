package kr.or.ddit.projects.projectBoards.projectIsuue.mapper;

import static org.junit.jupiter.api.Assertions.*;

import javax.inject.Inject;

import org.junit.jupiter.api.Test;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.annotation.RootContextWebConfig;
import kr.or.ddit.projects.vo.IssueVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RootContextWebConfig
@Transactional
class ProjectIssueMapperTest {
	
	@Inject
	ProjectIssueMapper mapper;
	
	IssueVO issue;
	
	
	
	@Test
	void testSelectTotalBoard() {
		fail("Not yet implemented");
	}

	@Test
	void testSelectProjectIssueList() {
		fail("Not yet implemented");
	}

	@Test
	void testInsertIssue() {
		fail("Not yet implemented");
	}

	@Test
	void testSelectIssueList() {
		fail("Not yet implemented");
	}

	@Test
	void testSelectIssue() {
		log.info("list : {}", mapper.selectIssue("IS000020"));
	}

	@Test
	void testUpdateIssue() {
		fail("Not yet implemented");
	}

	@Test
	void testDeleteIssue() {
		fail("Not yet implemented");
	}

}
