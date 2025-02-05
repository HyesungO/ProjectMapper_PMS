package kr.or.ddit.users.mypage.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.users.mypage.mapper.EducationHistoryMapper;
import kr.or.ddit.users.vo.EducationHistoryVO;
import kr.or.ddit.users.vo.EducationVO;

@Service
public class EducationHistoryServiceImpl implements EducationHistoryService {
	
	@Autowired
	private EducationHistoryMapper mapper;
	
	@Override
	public ServiceResult createEducationHistory(EducationHistoryVO educationHistory) {
		ServiceResult result = null;
		int rowcnt = mapper.insertEducationHistory(educationHistory);
		result = rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
		return result;
	}

	@Override
	public List<EducationVO> readEducationHistoryList() {
		return mapper.selectEducationHistoryList();
	}

	@Override
	public EducationVO readEducationHistory(String edHistoryId) {
		return mapper.selectEducationHistory(edHistoryId);
	}

	@Override
	public ServiceResult modifyEducationHistory(EducationHistoryVO educationHistory) {
		ServiceResult result = null;
		int rowcnt = mapper.updateEducationHistory(educationHistory);
		result = rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
		return result;
	}

	@Override
	public ServiceResult removeEducationHistory(String edHistoryId) {
		ServiceResult result = null;
		int rowcnt = mapper.deleteEducationHistory(edHistoryId);
		result = rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
		return result;
	}

}
