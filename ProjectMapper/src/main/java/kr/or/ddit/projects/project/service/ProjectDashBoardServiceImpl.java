package kr.or.ddit.projects.project.service;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.datetime.DateFormatter;
import org.springframework.format.datetime.joda.LocalDateParser;
import org.springframework.stereotype.Service;

import kr.or.ddit.projects.project.mapper.ProjectDashBoardMapper;
import kr.or.ddit.projects.project.vo.DailyTaskProgressVO;
import kr.or.ddit.projects.project.vo.TaskProgressVO;
import kr.or.ddit.projects.project.vo.TaskVolumeVO;
import kr.or.ddit.projects.vo.IssueVO;
import kr.or.ddit.projects.vo.ProjectBoardVO;
import kr.or.ddit.projects.vo.ProjectMemberVO;
import kr.or.ddit.projects.vo.TaskBoardVO;
import kr.or.ddit.projects.vo.TodoListVO;
import kr.or.ddit.resources.mapper.ResourcesMapper;
import kr.or.ddit.vo.ResourceVO;

@Service
public class ProjectDashBoardServiceImpl implements ProjectDashBoardService {
	@Autowired
	private ProjectDashBoardMapper mapper;
	
	@Autowired
	private ResourcesMapper resourceMapper;

	@Override
	public ProjectMemberVO readProjectMemberVO(String pjId, String userId) {
		
		ProjectMemberVO projectMember = mapper.readProjectMemberVO(pjId, userId);
		List<ResourceVO> resList = resourceMapper.selectMemberResourceList(projectMember.getPjRoleId());
		projectMember.setResList(resList);
		return projectMember;
	}

	@Override
	public List<ProjectBoardVO> readProjectBoardList(String pjId) {
		List<ProjectBoardVO> list = mapper.readProjectBoardList(pjId);
		for(ProjectBoardVO vo : list) {
			if(vo.getPjBoardTitle().length()>=15) {
				vo.setPjBoardTitle(vo.getPjBoardTitle().substring(0,12)+"...");
			}
		}
		return list;
	}

	@Override
	public List<TaskBoardVO> readTaskBoardList(String pjMemId) {
		List<TaskBoardVO> list = mapper.readTaskBoardList(pjMemId);
		for(TaskBoardVO vo : list) {
			String endDate = null;
			if(vo.getTaskEndDate()!=null) {
				endDate = vo.getTaskEndDate().substring(0,4)+"-"+vo.getTaskEndDate().substring(4,6)+"-"+vo.getTaskEndDate().substring(6,8);
			}
			vo.setTaskEndDate(endDate);
			if(vo.getTaskName().length()>=15) {
				vo.setTaskName(vo.getTaskName().substring(0,12)+"...");
			}
		}
		return list;
	}

	@Override
	public List<TodoListVO> readTodoListList(String pjMemId) {
		return mapper.readTodoListList(pjMemId);
	}

	@Override
	public List<IssueVO> readIssueList(String pjMemId) {
		return mapper.readIssueList(pjMemId);
	}

	@Override
	public Map<String, Object> readTaskProgress(String pjId) {
//		data: {
//		labels: ['2025-01', '2025-02', '2025-03', '2025-04', '2025-05', '2025-06'],
//		datasets: [{
//			label: '업무 진행률',
//			data: [3, 3, 5, 12, 19, 30],			// labels index하고 data index하고 같은 연월은 같은 index로 넣는 배열로
//			borderWidth: 1
//		}]
//	},
//	
//	labels ==> 프로젝트 시작 연월부터 현재 연월까지, 현재 연월이 endDate 초과하면 endDate로 교체
//	datasets
//		==> label: '업무 진행률',
//			data: [각각 해당 월 진행률 평균] (전체 업무를 월별 업무로 나누고 거기에서 다시 진행률로 나눈 평균)
//			borderWidth: 1
		
		List<TaskProgressVO> list = mapper.readTaskProgress(pjId);
		Map<String,Object> map = new HashMap<String,Object>();
		List<String> labels = new ArrayList<String>();
		List<Map<String,Object>> datasets = new ArrayList<Map<String,Object>>();
		Map<String,Object> datasetsMap = new HashMap<String,Object>();
		List<Double> data = new ArrayList<Double>();
		
		// labels
		for(TaskProgressVO vo : list) {
			LocalDate pjCreatedDt = LocalDate.parse(vo.getPjCreatedDt(), DateTimeFormatter.ofPattern("yyyyMMdd"));
			LocalDate today = LocalDate.parse(vo.getToday(), DateTimeFormatter.ofPattern("yyyyMMdd"));
			if(!vo.getPjEndDt().equals("01")) {
				LocalDate pjEndDt = LocalDate.parse(vo.getPjEndDt(), DateTimeFormatter.ofPattern("yyyyMMdd"));
				if(today.isAfter(pjEndDt)) {
					today = pjEndDt;
				}
			}
			while(today.isAfter(pjCreatedDt) || today.isEqual(pjCreatedDt)) {
				labels.add(pjCreatedDt.toString());
				pjCreatedDt = pjCreatedDt.plusMonths(1);
			}
			
			break;
		}
		
		// data
		Map<String,Double> progressMap = new HashMap<String, Double>();
		
		for(TaskProgressVO vo : list) {
			LocalDate today = LocalDate.parse(vo.getToday(), DateTimeFormatter.ofPattern("yyyyMMdd"));
			if(!vo.getPjEndDt().equals("01")) {
				LocalDate pjEndDt = LocalDate.parse(vo.getPjEndDt(), DateTimeFormatter.ofPattern("yyyyMMdd"));
				if(today.isAfter(pjEndDt)) {
					today = pjEndDt;
				}
			}
			if(progressMap.get(vo.getTaskStartDate())==null) {
				progressMap.put(vo.getTaskStartDate(), vo.getTaskProgress());
			}
			else {
				progressMap.put(vo.getTaskStartDate(), ( progressMap.get(vo.getTaskStartDate()) + vo.getTaskProgress() ) / 2);
			}
		}
		
		for(int i=0; i<labels.size(); i++) {
			for(String key : progressMap.keySet()) {
				if(labels.get(i).replace("-", "").equals(key)) {
					data.add(i, progressMap.get(key)*100);
					break;
				}
				else {
					data.add(i, 0.0);
				}
			}
		}
		datasetsMap.put("label", "월별 업무 진행률");
		datasetsMap.put("data", data);
		datasetsMap.put("borderWidth", 1);
		datasetsMap.put("borderColor", "rgba(75, 192, 192, 0.5)");
		datasetsMap.put("backgroundColor", "rgba(75, 192, 192, 0.5)");
		datasets.add(datasetsMap);
		
		map.put("labels", labels);
		map.put("datasets", datasets);
		
		System.out.println("===============================================================> \n"+map);
		
		return map;
	}
	
	@Override
	public Map<String, Object> readTaskCount(String pjId) {
		List<TaskVolumeVO> taskVolumeList = mapper.readTaskCount(pjId);
		
		Map<String,Object> map = new HashMap<String,Object>();
		List<String> labels = new ArrayList<String>();
		List<Map<String,Object>> datasets = new ArrayList<Map<String,Object>>();
		Map<String,Object> datasetsMap = new HashMap<String,Object>();
		List<Integer> data = new ArrayList<Integer>();
		
		for(TaskVolumeVO vo : taskVolumeList) {
			labels.add(vo.getUserName());
			data.add(vo.getTaskCount());
		}
		datasetsMap.put("label", "할당 업무량");
		datasetsMap.put("data", data);
		datasetsMap.put("borderWidth", 1);
		datasets.add(datasetsMap);
		
		map.put("labels", labels);
		map.put("datasets", datasets);
		
		return map;
	}

	@Override
	public Map<String, Object> readDailyTaskCount(String pjId) {
		List<DailyTaskProgressVO> dailyTaskProgressList = mapper.readDailyTaskCount(pjId);
		
		Map<String,Object> map = new HashMap<String,Object>();
		List<String> labels = new ArrayList<String>();
		List<Map<String,Object>> datasets = new ArrayList<Map<String,Object>>();
		Map<String,Object> datasetsMap = new HashMap<String,Object>();
		List<Integer> data = new ArrayList<Integer>();
		
		for(DailyTaskProgressVO vo : dailyTaskProgressList) {
			labels.add(vo.getUserName());
			data.add(vo.getDailyTaskCount());
		}
		datasetsMap.put("label", "업무 보고");
		datasetsMap.put("data", data);
		datasetsMap.put("borderWidth", 1);
		datasets.add(datasetsMap);
		
		map.put("labels", labels);
		map.put("datasets", datasets);
		
		return map;
	}
	
}
