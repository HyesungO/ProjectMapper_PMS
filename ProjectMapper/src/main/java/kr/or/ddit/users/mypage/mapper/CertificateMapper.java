package kr.or.ddit.users.mypage.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.users.vo.CertificateVO;

@Mapper
public interface CertificateMapper {

	/**
	 * 자격증 등록
	 * @param certificate
	 * @return
	 */
	public int insertCertificate(CertificateVO certificate);
	
	/**
	 * 자격증 전체 조회
	 * @return
	 */
	public List<CertificateVO> selectCertificateList();
	
	/**
	 * 자격증 상세 조회
	 * @param certId
	 * @return
	 */
	public CertificateVO selectCertificate(String certId);
	
	/**
	 * 자격증 수정
	 * @param certificate
	 * @return
	 */
	public int updateCertificate(CertificateVO certificate);
	
	/**
	 * 자격증 삭제
	 * @param certId
	 * @return
	 */
	public int deleteCertificate(String certId);
}
