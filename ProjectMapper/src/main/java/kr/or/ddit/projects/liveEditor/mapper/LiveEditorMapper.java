package kr.or.ddit.projects.liveEditor.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.projects.vo.LiveEditorVO;

@Mapper
public interface LiveEditorMapper {
	
	public List<LiveEditorVO> selectLiveEditorList(String pjId);
	
	public LiveEditorVO selectLiveEditor(String liveEditorId);
	
	public int insertLiveEditor(LiveEditorVO liveEditor);
	
	public int updateLiveEditor(LiveEditorVO liveEditor);
	
	public int deleteLiveEditor(String liveEditorId);
	
}
