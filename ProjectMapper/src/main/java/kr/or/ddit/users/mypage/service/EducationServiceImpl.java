package kr.or.ddit.users.mypage.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.users.mypage.mapper.EducationMapper;
import kr.or.ddit.users.vo.EducationVO;

@Service
public class EducationServiceImpl implements EducationService {
	
	@Autowired
	private EducationMapper mapper;
	
	@Override
	public ServiceResult createEducation(EducationVO education) {
		ServiceResult result = null;
		int rowcnt = mapper.insertEducation(education);
		result = rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
		return result;
	}

	@Override
	public List<EducationVO> readEducationList() {
		return mapper.selectEducationList();
	}

	@Override
	public EducationVO readEducation(String eduId) {
		return mapper.selectEducation(eduId);
	}

	@Override
	public ServiceResult modifyEducation(EducationVO education) {
		ServiceResult result = null;
		int rowcnt = mapper.updateEducation(education);
		result = rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
		return result;
	}

	@Override
	public ServiceResult removeEducation(String eduId) {
		ServiceResult result = null;
		int rowcnt = mapper.deleteEducation(eduId);
		result = rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
		return result;
	}

}
