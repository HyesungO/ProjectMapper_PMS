package kr.or.ddit.projects.task;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;

import kr.or.ddit.annotation.RootContextWebConfig;
import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.paging.PaginationInfo;
import kr.or.ddit.projects.task.service.TaskService;
import kr.or.ddit.projects.vo.ProjectVO;
import kr.or.ddit.projects.vo.TaskBoardVO;
import lombok.extern.slf4j.Slf4j;

@RootContextWebConfig
@Slf4j
public class TaskServiceTest {

	@Autowired
	TaskService service;
	
	TaskBoardVO taskBoard;
	PaginationInfo<TaskBoardVO> page;
	
	@BeforeEach
	void beforeEach() {
		taskBoard = service.readTaskBoard("TASK000011");
		log.info("==> {}", taskBoard.getPjId());
	}

	@Test
	void testReadTaskList() {
		page.setCurrentPage(1);
		log.info(service.readTaskBoardList("PJ003", page).toString());
		assertDoesNotThrow(()-> service.readTaskBoardList(taskBoard.getPjId(), page));
	}

	@Test
	void testModifyTask() {
		taskBoard.setTaskContent("수정테스트2");
		assertEquals(ServiceResult.OK, service.modifyTaskBoard(taskBoard));
	}

}
