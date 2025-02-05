package kr.or.ddit.projects.projectBoards.projectBoard.service;

import static org.junit.jupiter.api.Assertions.*;

import javax.inject.Inject;

import org.junit.jupiter.api.Test;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.annotation.RootContextWebConfig;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RootContextWebConfig
@Transactional
class ProjectBoardServiceImplTest {
	
	@Inject
	ProjectBoardService service;

	@Test
	void testReadProjectBoardList() {
		fail("Not yet implemented");
	}

	@Test
	void testReadProjectBoard() {
		log.info("asd : {} ", service.readProjectBoard("PJBD001"));
	}

	@Test
	void testModifyProjectBoard() {
		fail("Not yet implemented");
	}

	@Test
	void testCreateProjectBoard() {
		fail("Not yet implemented");
	}

	@Test
	void testRemoveProjectBoard() {
		fail("Not yet implemented");
	}

}
