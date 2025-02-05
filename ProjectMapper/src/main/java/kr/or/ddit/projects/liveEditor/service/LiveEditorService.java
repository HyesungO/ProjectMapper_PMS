package kr.or.ddit.projects.liveEditor.service;

import java.util.List;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.projects.vo.LiveEditorVO;

public interface LiveEditorService {
	
	public List<LiveEditorVO> readLiveEditorList(String pjId);
	
	public LiveEditorVO readLiveEditor(String leId);
	
	public ServiceResult createLiveEditor(LiveEditorVO liveEditor);
	
	public ServiceResult modifyLiveEditor(LiveEditorVO liveEditor);
	
	public ServiceResult removeLiveEditor(String leId);
	
}
