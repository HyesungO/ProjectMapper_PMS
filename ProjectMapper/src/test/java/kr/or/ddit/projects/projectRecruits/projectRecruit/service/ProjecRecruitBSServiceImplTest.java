package kr.or.ddit.projects.projectRecruits.projectRecruit.service;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;

import kr.or.ddit.annotation.RootContextWebConfig;
import kr.or.ddit.projects.project.service.ProjectService;
import kr.or.ddit.projects.vo.ProjectRecruitVO;
import kr.or.ddit.projects.vo.ProjectVO;

@RootContextWebConfig
class ProjecRecruitBSServiceImplTest {
	
	@Autowired
	ProjectRecruitBSService service;
	
	@Test
	void testCreateRecruitBS() {
		ProjectRecruitVO projectRecruit = new ProjectRecruitVO();
		projectRecruit.setPjId("P0200011");
		projectRecruit.setPjRecruitTitle("test");
		projectRecruit.setPjRecruitContent("요구사항");
		projectRecruit.setPjIsOutsourced("Y");
		projectRecruit.setPjOutsourcingCost(800000);
		
		System.out.println(service.createRecruitBS(projectRecruit));
	}

	@Test
	void testModifyRecruitBS() {
		fail("Not yet implemented");
	}

	@Test
	void testRemoveRecruitBS() {
		fail("Not yet implemented");
	}

}
