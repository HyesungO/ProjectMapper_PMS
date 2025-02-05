package kr.or.ddit.code.service;

import java.util.List;

import kr.or.ddit.vo.CodeVO;

public interface CodeService {

	/**
	 * 상위 코드로 리스트 불러오기
	 * @param codePId
	 * @return
	 */
	public List<CodeVO> readIssueImpCodeList(String codeParId);
}
