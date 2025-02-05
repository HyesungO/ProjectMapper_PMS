package kr.or.ddit.projects.projectBoards.projectBoard.mapper;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.junit.jupiter.api.Assertions.assertEquals;

import javax.inject.Inject;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.annotation.RootContextWebConfig;
import kr.or.ddit.projects.vo.ProjectBoardVO;


@RootContextWebConfig
@Transactional
class ProjectBoardMapperTest {
	
	@Inject
	ProjectBoardMapper mapper;
	
	ProjectBoardVO pbVO;
	
	@BeforeEach
	void BeforeEach() {
		pbVO = new ProjectBoardVO();
		pbVO.setPjId("PJ009");
		pbVO.setPjMemId("USER001");
		pbVO.setPjBoardTitle("titleTest");
		pbVO.setPjBoardContent("contentTest");
		pbVO.setPjBoardCateCode("P0502");
		assertEquals(1, mapper.insertProjectBoard(pbVO));
	}
	
//	@Test
//	void testSelectProjectBoardList() {
//		assertDoesNotThrow(()-> mapper.selectProjectBoardList("PJ009"));
//	}

	@Test
	void testSelectProjectBoard() {
		assertDoesNotThrow(()-> mapper.selectProjectBoard("PJBD004"));
	}

	@Test
	void testUpdateProjectBoard() {
		pbVO.setPjBoardTitle("test수정");
		pbVO.setPjBoardContent("수정 내용");
		pbVO.setPjBoardCateCode("P0502");
		mapper.updateProjectBoard(pbVO);
		assertEquals(1, mapper.updateProjectBoard(pbVO));
	}

	@Test
	void testInsertProjectBoard() {
		pbVO = new ProjectBoardVO();
		pbVO.setPjMemId("abc");
		pbVO.setPjId("PJ009");
		pbVO.setPjBoardTitle("titleTest");
		pbVO.setPjBoardContent("contentTest");
		pbVO.setPjBoardCateCode("P0502");
		pbVO.setPjBoardTitle("사진이름");
		assertEquals(1, mapper.insertProjectBoard(pbVO));
	}

	@Test
	void testDeleteProjectBoard() {
		assertDoesNotThrow(()-> mapper.deleteProjectBoard(pbVO.getPjBoardId()));
	}

}
