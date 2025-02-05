package kr.or.ddit.projects.project.mapper;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.annotation.RootContextWebConfig;
import kr.or.ddit.projects.vo.ProjectVO;

@RootContextWebConfig
@Transactional
class ProjectMapperTest {
	
	@Autowired
	ProjectMapper mapper;
	
	ProjectVO project;
	
	@BeforeEach
	@Disabled
	void beforeEach() {
		project = new ProjectVO();
		project.setPjName("TEST제목");
		project.setUserId("tester");
		project.setPjDescription("test내용");
		project.setPjTypeCode("P0201");
		assertEquals(1, mapper.insertProject(project));
	}
	
	@Test
	void testInsertProject() {
		project = new ProjectVO();
		project.setPjName("TEST제목");
		project.setUserId("tester");
		project.setPjDescription("test내용");
		project.setPjTypeCode("P0201");
		assertEquals(1, mapper.insertProject(project));
	}

//	@Test
//	void testSelectProjectList() {
//		assertDoesNotThrow(()-> mapper.selectProjectList(project.getUserId()));
//	}

	@Test
	void testSelectProject() {
		assertDoesNotThrow(()-> mapper.selectProject(project.getPjId()));
	}

	@Test
	void testUpdateProject() {
		project.setPjName("수정테스트");
		project.setPjDescription("수정테스트내용");
		assertEquals(1, mapper.updateProject(project));
	}

	@Test
	void testUpdateProjectStatus() {
		project.setPjStCode("P0402");
		assertEquals(1, mapper.updateProject(project));
	}

}
