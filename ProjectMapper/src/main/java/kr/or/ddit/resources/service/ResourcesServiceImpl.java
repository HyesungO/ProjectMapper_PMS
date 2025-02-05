package kr.or.ddit.resources.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.resources.mapper.ResourcesMapper;
import kr.or.ddit.vo.ResourceVO;

@Service
public class ResourcesServiceImpl implements ResourcesService {
	
	@Inject
	private ResourcesMapper mapper;

	@Override
	public List<ResourceVO> readPjResourceList() {
		return mapper.selectPjResourceList();
	}

	@Override
	public String readResourceid(String signatureName) {
		return mapper.selectResourceId(signatureName);
	}

	@Override
	public ResourceVO readResource(String resourceId) {
		
		return mapper.selectResource(resourceId);
	}

}
