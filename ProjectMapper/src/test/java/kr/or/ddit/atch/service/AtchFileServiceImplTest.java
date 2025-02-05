package kr.or.ddit.atch.service;

import static org.junit.jupiter.api.Assertions.*;

import javax.inject.Inject;

import org.junit.jupiter.api.Test;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.annotation.RootContextWebConfig;
import kr.or.ddit.atch.mapper.AtchFileMapper;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RootContextWebConfig
@Transactional
class AtchFileServiceImplTest {
	
	@Inject
	AtchFileMapper mapper;
	
	@Test
	void testCreateAtchFile() {
		fail("Not yet implemented");
	}

	@Test
	void testReadAtchFile() {
		log.info("AtchFile List: {}", mapper.selectAtchFileEnable(2));

	}

	@Test
	void testReadAtchFileDetail() {
		fail("Not yet implemented");
	}

	@Test
	void testRemoveAtchFileDetail() {
		fail("Not yet implemented");
	}

	@Test
	void testDisableAtchFile() {
		fail("Not yet implemented");
	}

	@Test
	void testRemoveDiabledAtchFile() {
		fail("Not yet implemented");
	}

}
