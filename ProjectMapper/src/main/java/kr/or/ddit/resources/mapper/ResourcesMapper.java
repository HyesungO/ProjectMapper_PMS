package kr.or.ddit.resources.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.ResourceVO;

@Mapper
public interface ResourcesMapper {
	
	/**
	 * 프로젝트 관련 리소스 리스트 조회
	 * @return
	 */
	public List<ResourceVO> selectPjResourceList();
	
	/**
	 * 접근 제한자에 따른 접근제한 리소스 찾기
	 * @return
	 */
	public List<ResourceVO> selectMemberResourceList(String pjRoleId);
	
	/**
	 * 메소드명을 이용하여 MethodName 컬럼을 비교해서 같은 것에 대한 값 가져오기
	 * @param methodName
	 * @return
	 */
	public String selectResourceId(String signatureName);
	
	/**
	 * alert에서 put, post, delete 요청에 대한 get 메소드인 컬럼 찾아오기
	 * @param resourceId
	 * @return
	 */
	public ResourceVO selectResource(String resourceId);
	
	/**
	 * 알람을 위한 테이블 네임으로 주소 URI 불러오기
	 * @param TableName
	 * @return
	 */
	public String selectUriAddr(String TableName);
}
