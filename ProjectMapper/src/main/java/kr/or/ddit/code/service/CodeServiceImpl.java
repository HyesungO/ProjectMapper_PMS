package kr.or.ddit.code.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.code.mapper.CodeMapper;
import kr.or.ddit.vo.CodeVO;

@Service
public class CodeServiceImpl implements CodeService {

	@Inject
	CodeMapper codeMapper;
	
	@Override
	public List<CodeVO> readIssueImpCodeList(String codeParId) {
		
		return codeMapper.selectIssueImpCodeList(codeParId);
	}

}
