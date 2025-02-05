package kr.or.ddit.code.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.vo.CodeVO;

@Mapper
public interface CodeMapper {

	/**
	 * 상위 아이디로 해당하는 code 불러오기
	 * @param codePId
	 * @return
	 */
	public List<CodeVO> selectIssueImpCodeList(@Param("codeParId") String codeParId);
}
