package kr.or.ddit.projects.project.mapper;

import static org.junit.jupiter.api.Assertions.*;

import javax.inject.Inject;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.annotation.RootContextWebConfig;
import kr.or.ddit.projects.config.mapper.ProjectMemberMapper;
import kr.or.ddit.projects.vo.ProjectMemberVO;

@RootContextWebConfig
@Transactional
class ProjectMemberMapperTest {

	@Inject
	ProjectMemberMapper mapper;
	
	ProjectMemberVO projectMember;
	
	@BeforeEach
	void beforeEach() {
		projectMember = new ProjectMemberVO();
		projectMember.setPjId("P0200001");
		projectMember.setUserId("USER034");
		projectMember.setPjMemRoleTypeCode("GE");
		projectMember.setPjRoleId("아무역할");
		assertEquals(1, mapper.insertProjectMember(projectMember));
	}
	
//	@Test
//	void testInsertProjectMember() {
//		 ProjectMemberVO projectMember = new ProjectMemberVO();
//		    projectMember.setPjId("P0200001");
//		    projectMember.setUserId("USER034");
//		    projectMember.setPjMemRoleTypeCode("GE");
//		    projectMember.setPjMemRoleName("아무역할");
//
//		    // Null 값을 방지하고 올바른 데이터가 전달되었는지 확인
//		    assertNotNull(projectMember.getPjId());
//		    assertNotNull(projectMember.getUserId());
//
//		    int result = mapper.insertProjectMember(projectMember);
//		    assertEquals(1, result);
//	}

	@Test
	void testSelectProjectMemberList() {
		assertDoesNotThrow(()->mapper.selectProjectMemberList("P0200001"));
	}

	@Test
	void testSelectProjectMember() {
		assertDoesNotThrow(()-> mapper.selectProjectMember("P0200001USER001"));
	}

	@Test
	void testSelectMyProjectList() {
		assertDoesNotThrow(()-> mapper.selectMyProjectList("tester"));
	}

	@Test
	void testDeleteProjectMember() {
		assertEquals(1, mapper.deleteProjectMember("P0200001USER001"));
	}

}
