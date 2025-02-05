package kr.or.ddit.projects.schedule.service;

import java.time.LocalDate;
import java.time.Period;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.datetime.DateFormatter;
import org.springframework.stereotype.Service;

import kr.or.ddit.projects.schedule.mapper.ProjectGanttMapper;
import kr.or.ddit.projects.vo.GanttLinksVO;
import kr.or.ddit.projects.vo.GanttVO;
import kr.or.ddit.projects.vo.TaskBoardVO;

@Service
public class ProjectGanttServiceImpl implements ProjectGanttService {
	
	@Autowired
	public ProjectGanttMapper mapper;

	@Override
	public Map<String,Object> readGanttList(String pjId) {

//        "id": 1,
//        "text": "개발 사무실 환경 구성",
//        "type": "project",
//        "order": "10",
//        "progress": 0.4,
//        "open": false,
//        "user": "0",
//        "start_date": "2023-11-02 00:00",
//        "duration": 17,
//        "end_date": "2023-11-19 00:00",
//        "parent": 0

//		 task_id
//		,task_assignee_id
//		,task_name
//		,task_progress
//		,task_start_date
//		,task_end_date
//		,task_parent_id
		
		Map<String,Object> map = new HashMap<String,Object>();
		List<TaskBoardVO> taskList = mapper.selectGanttList(pjId);
		List<GanttVO> ganttList = new ArrayList<GanttVO>();
		List<GanttLinksVO> ganttLinksList = new ArrayList<GanttLinksVO>();
		
		for(TaskBoardVO task : taskList) {
			GanttVO gantt = new GanttVO();
			GanttLinksVO ganttLinks = new GanttLinksVO();
			
			gantt.setId(task.getTaskId());
			gantt.setUser(task.getUserName());
			gantt.setText(task.getTaskName());
			gantt.setProgress(task.getTaskProgress()/100.0);
			
			String start = null;
			String end = null;
			int duration = 0;
			if(task.getTaskEndDate()!=null && !task.getTaskEndDate().isEmpty()) {
				LocalDate startDate = LocalDate.parse(task.getTaskStartDate(), DateTimeFormatter.ofPattern("yyyyMMdd"));
				LocalDate endDate = LocalDate.parse(task.getTaskEndDate(), DateTimeFormatter.ofPattern("yyyyMMdd"));
				duration = Period.between(startDate, endDate).getDays();
				gantt.setDuration(duration);
			}
			
			if(task.getTaskStartDate()!=null) {
				start = task.getTaskStartDate().substring(0,4)+"-"+task.getTaskStartDate().substring(4,6)+"-"+task.getTaskStartDate().substring(6,8);
			}
			if(task.getTaskEndDate()!=null) {
				end = task.getTaskEndDate().substring(0,4)+"-"+task.getTaskEndDate().substring(4,6)+"-"+task.getTaskEndDate().substring(6,8);
			}
			gantt.setStart_date(start);
			gantt.setEnd_date(end);
			gantt.setParent(task.getTaskParentId());
			ganttList.add(gantt);
			
			ganttLinks.setId(task.getTaskId());
			ganttLinks.setSource(task.getTaskId());
			ganttLinks.setTarget(task.getTaskParentId());
			ganttLinksList.add(ganttLinks);
		}
		map.put("data", ganttList);
		map.put("links", ganttLinksList);
		
		return map;
	}

}
