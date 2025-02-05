package kr.or.ddit.projects.dailyTasks.dailyTask.service;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;

import kr.or.ddit.annotation.RootContextWebConfig;
import lombok.extern.slf4j.Slf4j;

@RootContextWebConfig
@Slf4j
class DailyTaskServiceImplTest {
	
	@Autowired
	DailyTaskService service;

	@Test
	void testReadDailyTaskList() {
//		log.info(service.readDailyTaskList("PJ003").toString());
	}

}
