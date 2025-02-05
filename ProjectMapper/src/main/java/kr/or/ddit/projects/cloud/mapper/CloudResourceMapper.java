package kr.or.ddit.projects.cloud.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.projects.vo.CloudResourceVO;

@Mapper
public interface CloudResourceMapper {
	
	/**
	 * 클라우드에 파일, 폴더를 생성할 때 메타데이터 등록
	 * @param cloudResource
	 * @return
	 */
	public int insertCloudResource(CloudResourceVO cloudResource);
	
	/**
	 * 클라우드에 파일, 폴더에 대한 값 조회
	 * @param cloudResourceId
	 * @return
	 */
	public CloudResourceVO selectCloudResource(String cloudResourceId);
	
	/**
	 * ResourceList가져오기
	 * 
	 * @param cloudRootId
	 * @return
	 */
	public List<CloudResourceVO> selectCloudResourceList(String cloudRootId);
	
	/**
	 * 폴더, 파일 삭제시 삭제
	 * @param cloudResource
	 * @return
	 */
	public int deleteCloudResource(String cloudResourceId);
	
	/**
	 * 멀티 파일 삭제 시 먼저 자식들 먼저 전부 삭제하기
	 * @param cloudResourceId
	 * @return
	 */
	public int deleteChildCloudResource(String cloudResourceId);
	
	/**
	 * 수정사항
	 * rename
	 * @param cloudResourceId
	 * @return
	 */
	public int updateCloudResource(CloudResourceVO cloudResource);
	
	/**
	 * 파일의 경로를 변경하기 위해
	 * 자신의 부모를 변경
	 * @param cloudResourceId
	 * @param cloudParResId
	 * @return
	 */
	public int updateMoveObjectPath(@Param("cloudResourceId") String cloudResourceId, @Param("cloudParResId") String cloudParResId);
	
	/**
	 * aws 클라우드 경로 불러오기
	 * @param cloudRootId
	 * @return
	 */
	public List<CloudResourceVO> selectPathList(String cloudRootId);
	
	/**
	 * 클라우드옆에 리스트를 나타내기 위한 리스트 자식에 담는 구조
	 * @param cloudRootId
	 * @return
	 */
	public List<CloudResourceVO> selectSideFileList(String cloudRootId);
	
	/**
	 * 클라우드 파일 이동을 위한 모달 ui용 리스트
	 * @param cloudRootId
	 * @return
	 */
	public List<CloudResourceVO> selectModalFolderList(String cloudRootId);
	
	/**
	 * cloudResourceId 조회할 pk값 / 만약 null 이라면 if 조건으로 rootId에 해당하는 전체 리스트 조회
	 * @param cloudResourceId
	 * @param cloudParResId
	 * @return
	 */
	public List<CloudResourceVO> selectChildObjectCntList(@Param("cloudRootId") String cloudRootId, @Param("cloudResourceId") String cloudResourceId);
	
	/**
	 * 클라우드 루트 아이디로 클라우드 용량 조회
	 * @param cloudRootId
	 * @return
	 */
	public List<CloudResourceVO> selectStorageCloudList(String cloudRootId);
}
