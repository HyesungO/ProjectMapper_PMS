package kr.or.ddit.users.mypage.service;

import java.util.List;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.users.vo.CertificateVO;

public interface CertificateService {

	/**
	 * 자격증 등록
	 * @param certificate
	 * @return 성공하면 OK / 실패하면 FAIL
	 */
	public ServiceResult createCertificate(CertificateVO certificate);
	
	/**
	 * 자격증 전체 조회
	 * @return 
	 */
	public List<CertificateVO> readCertificateList();
	
	/**
	 * 자격증 상세 조회
	 * @param certId
	 * @return
	 */
	public CertificateVO readCertificate(String certId);
	
	/**
	 * 자격증 수정
	 * @param certificate
	 * @return 성공하면 OK / 실패하면 FAIL
	 */
	public ServiceResult modifyCertificate(CertificateVO certificate);
	
	/**
	 * 자격증 삭제
	 * @param certId
	 * @return 성공하면 OK / 실패하면 FAIL
	 */
	public ServiceResult removeCertificate(String certId);
}
