package kr.or.ddit.projects.projectRecruits.position.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.projects.vo.ApplicationVO;
import kr.or.ddit.projects.vo.PositionVO;

@Mapper
public interface PositionMapper {
	
	public PositionVO selectPosition(String positionId);
	
	public int insertPosition(ApplicationVO application);
	
	public int updatePosition(PositionVO position);
	
}
