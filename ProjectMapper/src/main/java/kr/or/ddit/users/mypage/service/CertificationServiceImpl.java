package kr.or.ddit.users.mypage.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.users.mypage.mapper.CertificateMapper;
import kr.or.ddit.users.vo.CertificateVO;

@Service
public class CertificationServiceImpl implements CertificateService {

	@Autowired
	private CertificateMapper mapper;
	
	@Override
	public ServiceResult createCertificate(CertificateVO certificate) {
		ServiceResult result = null;
		int rowcnt = mapper.insertCertificate(certificate);
		result = rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
		return result;
	}

	@Override
	public List<CertificateVO> readCertificateList() {
		return mapper.selectCertificateList();
	}

	@Override
	public CertificateVO readCertificate(String certId) {
		return mapper.selectCertificate(certId);
	}

	@Override
	public ServiceResult modifyCertificate(CertificateVO certificate) {
		ServiceResult result = null;
		int rowcnt = mapper.updateCertificate(certificate);
		result = rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
		return result;
	}

	@Override
	public ServiceResult removeCertificate(String certId) {
		ServiceResult result = null;
		int rowcnt = mapper.deleteCertificate(certId);
		result = rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
		return result;
	}

}
