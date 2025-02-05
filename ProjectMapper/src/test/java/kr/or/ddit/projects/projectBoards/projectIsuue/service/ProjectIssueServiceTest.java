package kr.or.ddit.projects.projectBoards.projectIsuue.service;

import static org.junit.jupiter.api.Assertions.*;

import java.io.File;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;
import java.util.stream.Stream;

import javax.inject.Inject;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.ArrayUtils;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.BeanUtils;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.annotation.RootContextWebConfig;
import kr.or.ddit.atch.vo.AtchFileDetailVO;
import kr.or.ddit.atch.vo.AtchFileVO;
import kr.or.ddit.projects.vo.IssueVO;

@RootContextWebConfig
@Transactional
class ProjectIssueServiceTest {
	
	@Inject
	ProjectIssueService service;
	
	IssueVO issueWithFiles;
	IssueVO issueWithNoFiles;
	
	@BeforeEach
	void beforeEach() {
		issueWithFiles = new IssueVO();
		issueWithNoFiles = new IssueVO();
		issueWithFiles.setIssueTitle("새글 제목");
		issueWithFiles.setIssueRequesterId("USER001");
		issueWithFiles.setPjId("P0200001");
		issueWithFiles.setIssueImpCode("IO201");
		issueWithFiles.setIssueTypeCode("IO102");
		issueWithFiles.setIssueContent("새글의 내용");

		BeanUtils.copyProperties(issueWithFiles, issueWithNoFiles);

		AtchFileVO atchFile = new AtchFileVO();
		MockMultipartFile file1 = new MockMultipartFile("atchFile.fileDetails[0].boFiles", "test.jpg", "image/jpeg",
				ArrayUtils.EMPTY_BYTE_ARRAY);
		MockMultipartFile file2 = new MockMultipartFile("atchFile.fileDetails[1].boFiles", "test.jpg", "image/jpeg",
				ArrayUtils.EMPTY_BYTE_ARRAY);
		atchFile.setFileDetails(Arrays.asList(new AtchFileDetailVO(file1), new AtchFileDetailVO(file2)));

		// 여러 케이스의 테스트를 위해 없는경우와 있는 경우 두개 다 인서트한것
		assertDoesNotThrow(() -> {
			issueWithFiles.setAtchFile(atchFile);
			service.createIssue(issueWithFiles);
		});
		assertDoesNotThrow(() -> {
			issueWithFiles.setAtchFile(null);
			service.createIssue(issueWithNoFiles);
		});
	}
	
	@AfterEach
	void afterEach() {
		assertDoesNotThrow(() -> {
			Optional.ofNullable(issueWithFiles)
					.map(IssueVO::getAtchFile)
					.map(AtchFileVO::getFileDetails)
					.map(List::stream).orElse(Stream.empty())
					.filter(fd -> fd.getFileStrePath() != null)
					.forEach(fd -> FileUtils.deleteQuietly(new File(fd.getFileStrePath())));
			Optional.ofNullable(issueWithNoFiles)
					.map(IssueVO::getAtchFile)
					.map(AtchFileVO::getFileDetails)
					.map(List::stream).orElse(Stream.empty())
					.filter(fd -> fd.getFileStrePath() != null)
					.forEach(fd -> FileUtils.deleteQuietly(new File(fd.getFileStrePath())));
		});
	}
	

	@Test
	void testReadProjectIssueList() {
		fail("Not yet implemented");
	}


	@Test
	void testReadIssueList() {
		fail("Not yet implemented");
	}

	@Test
	void testReadIssue() {
		assertNotNull(service.readIssue(issueWithFiles.getIssueId()));
		assertEquals(2, issueWithFiles.getAtchFile().getFileDetails().size());
	}

	@Test
	void testModifyIssue() {
		fail("Not yet implemented");
	}

	@Test
	void testRemoveIssue() {
		fail("Not yet implemented");
	}

}
