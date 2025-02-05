package kr.or.ddit.projects.liveEditor.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.projects.liveEditor.mapper.LiveEditorMapper;
import kr.or.ddit.projects.vo.LiveEditorVO;

@Service
public class LiveEditorServiceImpl implements LiveEditorService {
	
	@Autowired
	private LiveEditorMapper mapper;

	@Override
	public List<LiveEditorVO> readLiveEditorList(String pjId) {
		return mapper.selectLiveEditorList(pjId);
	}

	@Override
	public LiveEditorVO readLiveEditor(String leId) {
		return mapper.selectLiveEditor(leId);
	}

	@Override
	public ServiceResult createLiveEditor(LiveEditorVO liveEditor) {
		return mapper.insertLiveEditor(liveEditor)>0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public ServiceResult modifyLiveEditor(LiveEditorVO liveEditor) {
		return mapper.updateLiveEditor(liveEditor)>0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public ServiceResult removeLiveEditor(String leId) {
		return mapper.deleteLiveEditor(leId)>0 ? ServiceResult.OK : ServiceResult.FAIL;
	}
	
}
