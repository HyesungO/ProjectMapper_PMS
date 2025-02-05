package kr.or.ddit.log.service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.log.mapper.LogMapper;
import kr.or.ddit.projects.dto.WorkHistoryDTO;
import kr.or.ddit.vo.LogVO;

@Service
public class LogServiceImpl implements LogService {
	
	@Inject
	LogMapper logMapper;
	
	@Override
	public void saveLog(LogVO log) {
		logMapper.insertLog(log);
	}

	@Override
	public Map<String, List<WorkHistoryDTO>> readWorkHistoryList(String pjId) {
		List<LogVO> logIssueList = logMapper.selectWorkIssueList(pjId);
		List<LogVO> logTaskList = logMapper.selectWorkTaskList(pjId);
		
		List<WorkHistoryDTO> whDTOList = new ArrayList<WorkHistoryDTO>();
		
		for(LogVO log : logIssueList) {
			WorkHistoryDTO dto = new WorkHistoryDTO();
			
			dto.setWorkHistoryId(log.getLogId()); // logId
			dto.setCreateDate(log.getLogCreatedDate()); // 정렬용 date
			dto.setYyyymmdd(formatDate(log.getLogCreatedDate())); // yyyyMMdd
			dto.setAhhmmss(formatTime(log.getLogCreatedDate()));  // a hh:mm:ss
			dto.setRequesterId(log.getRequester().getUserId());
			dto.setRequesterName(log.getRequester().getUserName());
			dto.setHandlerName(log.getHandler());
			if("POST".equals(log.getResource().getResourceMethod())) {
				dto.setTopTitle("새이슈");	
				dto.setStatusType("n");
			}else if("PUT".equals(log.getResource().getResourceMethod())) {
				dto.setTopTitle("이슈처리");
			}
			dto.setCodeName(log.getCode().getCodeName());
			dto.setTitle(log.getIssue().getIssueTitle());
			dto.setContent(log.getIssue().getIssueContent());
			dto.setMoveAddress(log.getResource().getResourceUriAddr());
			dto.setPathVariable(log.getEntityId());
			
			whDTOList.add(dto);
		}
		
		for(LogVO log : logTaskList) {
			WorkHistoryDTO dto = new WorkHistoryDTO();
			
			dto.setWorkHistoryId(log.getLogId()); // logId
			dto.setCreateDate(log.getLogCreatedDate()); // 정렬용 date
			dto.setYyyymmdd(formatDate(log.getLogCreatedDate())); // yyyyMMdd
			dto.setAhhmmss(formatTime(log.getLogCreatedDate()));  // a hh:mm:ss
			dto.setRequesterId(log.getRequester().getUserId());
			dto.setRequesterName(log.getRequester().getUserName());
			dto.setHandlerName(log.getHandler());
			if("POST".equals(log.getResource().getResourceMethod())) {
				dto.setTopTitle("새일감");				
			}else if("PUT".equals(log.getResource().getResourceMethod())) {
				dto.setTopTitle("일감 진척 업데이트");
			}
			dto.setCodeName(log.getCode().getCodeName());
			dto.setTitle(log.getTaskBoard().getTaskName());
			dto.setContent(log.getTaskBoard().getTaskContent());
			dto.setMoveAddress(log.getResource().getResourceUriAddr());
			dto.setPathVariable(log.getEntityId());
			
			whDTOList.add(dto);
		}
		
		whDTOList.sort((dto1, dto2)->{
			LocalDateTime ldt1 = dto1.getCreateDate();
			LocalDateTime ldt2 = dto2.getCreateDate();
			return ldt2.compareTo(ldt1);
		});
		
		Map<String, List<WorkHistoryDTO>> whDTOMap = new ConcurrentHashMap<>();
		for (WorkHistoryDTO whd : whDTOList) {
			String mapKey = whd.getYyyymmdd();
			whDTOMap.computeIfAbsent(mapKey, k -> new ArrayList<>()).add(whd);
//			whDTOMap.put(whd.getYyyymmdd(), whd); ;
		}
		return whDTOMap;
	}
	// 날짜 포맷팅 함수
	private String formatDate(LocalDateTime date) {
	    // 날짜 포맷팅 코드 구현
	    DateTimeFormatter yyyymmdd = DateTimeFormatter.ofPattern("yyyy-MM-dd");
	    return date.format(yyyymmdd);
	}
	// 시간 포맷팅 함수
	private String formatTime(LocalDateTime date) {
	    // 시간 포맷팅 코드 구현
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("a hh:mm:ss");
	    return date.format(formatter);
	}

}
