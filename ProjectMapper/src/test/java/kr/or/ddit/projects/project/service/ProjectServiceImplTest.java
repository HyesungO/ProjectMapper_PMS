package kr.or.ddit.projects.project.service;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.annotation.RootContextWebConfig;
import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.paging.PaginationInfo;
import kr.or.ddit.projects.vo.ProjectVO;


@RootContextWebConfig
class ProjectServiceImplTest {
	
	@Autowired
	ProjectService service;
	
	ProjectVO project;
	
//	@BeforeEach
//	void beforeEach() {
//		project = new ProjectVO();
//		project.setPjName("TEST제목");
//		project.setUserId("tester2323");
//		project.setPjDescription("test내용");
//		project.setPjTypeCode("P0201");
//		
//	}
	
	@Disabled
	@Rollback(false) // 테스트 후 롤백하지 않도록 설정
	@Test
	void testCreateProject() {
	    project = new ProjectVO();
	    project.setPjName("TEST제목");
	    project.setUserId("tester2323");
	    project.setPjDescription("test내용");
	    project.setPjTypeCode("P0201");
	    assertDoesNotThrow(() -> service.createProject(project));
	}

	@Test
	void testReadProjectList() {
		 PaginationInfo paging = new PaginationInfo();
		 paging.setCurrentPage(1);
		System.out.println(service.readMyProjectList(paging, "USER002"));
	}


	void testReadProject() {
		assertDoesNotThrow(()-> service.readProject(project.getPjId()));
	}


	void testModifyProject() {
		project.setPjName("수정테스트");
		project.setPjDescription("수정테스트내용");
		assertEquals(ServiceResult.OK, service.modifyProject(project));
	}


	void testModifyProjectStatus() {
		project.setPjStCode("P0402");
		assertEquals(ServiceResult.OK, service.modifyProjectStatus(project));
	}

}
