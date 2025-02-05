package kr.or.ddit.projects.cloud.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.projects.vo.CloudResourceVO;

public interface CloudResourceService {

	/**
	 * 클라우드에 파일, 폴더를 생성할 때 메타데이터 등록
	 * @param cloudResource
	 * @return
	 */
	public ServiceResult createCloudResource(CloudResourceVO cloudResource);
	
	/**
	 * 클라우드에 파일, 폴더에 대한 값 조회
	 * 조회해서 인증 처리
	 * @param cloudResourceId
	 * @return
	 */
	public CloudResourceVO readCloudResource(CloudResourceVO cloudResource);
	
	/**
	 * ResourceList가져오기
	 * @param cloudRootId
	 * @return
	 */
	public List<CloudResourceVO> readCloudResourceList(String cloudRootId);
	
	/**
	 * 폴더, 파일 삭제시 삭제
	 * @param cloudResource
	 * @return
	 */
	public ServiceResult removeCloudResource(List<CloudResourceVO> cloudResourceList);
	
	/**
	 * 수정사항
	 * @param cloudResourceId
	 * @return
	 */
	public ServiceResult modifyCloudResource(CloudResourceVO cloudResource);
	
	/**
	 * aws 파일, 폴더 주소
	 * @param cloudRootId
	 * @return
	 */
	public List<CloudResourceVO> readPathList(String cloudRootId);
	
	/**
	 * 클라우드옆에 리스트를 나타내기 위한 리스트 자식에 담는 구조
	 * @param cloudRootId
	 * @return
	 */
	public StringBuffer readSideFileList(String cloudRootId);

	/**
	 * 클라우드 폴더 수정 하기 위해 리스트를 나타내기 위한 리스트 자식에 담는 구조
	 * @param cloudRootId
	 * @return
	 */
	public StringBuffer readMoveModalFolderList(String cloudRootId);
	
	/**
	 * moveCrId : 이동할 대상 pk
	 * newParCrId : 이동할 위치 부모가 될 pk
	 * @param moveCrId
	 * @param newParCrId
	 * @return
	 */
	public ServiceResult modifyMoveOjbectPath(String moveCrId, String newParCrId);
	
	/**
	 * cloudRootId 클라우드 루트
	 * cloudResourceId 클라우드 리소스 id pk
	 * @param cloudRootId
	 * @param cloudResourceId
	 * @return
	 */
	public CloudResourceVO readDetailObject(String cloudRootId, String cloudResourceId);
	
	/**
	 * resourceList로 받아서 for문 돌려서 객체 경로값만 List에 담는다
	 * @param cloudResourceList
	 * @return
	 */
	public String readCloudResPathLIST(List<CloudResourceVO> cloudResourceList);
	
	/**
	 * 클라우드 명으로 스토리지 값을 조회해서 온다.
	 * @param cloudRootId
	 * @return
	 */
	public List<CloudResourceVO> readStorageCloudList(String cloudRootId);
}
