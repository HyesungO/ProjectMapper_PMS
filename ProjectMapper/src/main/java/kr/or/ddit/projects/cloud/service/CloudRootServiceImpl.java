package kr.or.ddit.projects.cloud.service;

import java.util.List;

import org.springframework.stereotype.Service;

import kr.or.ddit.projects.vo.CloudRootVO;

@Service
public class CloudRootServiceImpl implements CloudRootService {

	@Override
	public int insertCloudRoot(CloudRootVO cloudRoot) {
		
		return 0;
	}

	@Override
	public List<CloudRootVO> selectCloudRootList() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public CloudRootVO selectCloudRoot(String pjId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int updateAddUsedCapa(String pjId, int fileByte) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateSubUsedCapa(String pjId, int fileByte) {
		// TODO Auto-generated method stub
		return 0;
	}

}
