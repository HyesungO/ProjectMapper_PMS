package kr.or.ddit.resources.service;

import java.util.List;

import kr.or.ddit.vo.ResourceVO;

public interface ResourcesService {

	/**
	 * 프로젝트 관련 리소스 리스트 조회
	 * @return
	 */
	public List<ResourceVO> readPjResourceList();
	
	/**
	 * 메소드명을 이용하여 MethodName 컬럼을 비교해서 같은 것에 대한 값 가져오기
	 * @return
	 */
	public String readResourceid(String signatureName);
	
	/**
	 * alert에서 put, post, delete 요청에 대한 get 메소드인 컬럼 찾아오기
	 * @param resourceId
	 * @return
	 */
	public ResourceVO readResource(String resourceId);
}
