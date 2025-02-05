package kr.or.ddit.system.dashboard.service;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.notication.vo.NoticeBoardVO;
import kr.or.ddit.system.dashboard.mapper.SystemDashBoardMapper;

@Service
public class SystemDashBoardServiceImpl implements SystemDashBoardService {

	@Autowired
	private SystemDashBoardMapper mapper;

	@Override
	public Map<String, Object> getPjCnt() {
		List<Map<String,Object>> list = mapper.getPjCreadtedCnt();
		Map<String,Object> data = new HashMap<String,Object>();
		List<String> labels = new ArrayList<String>();
		List<Map<String,Object>> datasets = new ArrayList<Map<String,Object>>();
		Map<String,Object> datasetsMap = new HashMap<String,Object>();
		List<Integer> datas = new ArrayList<Integer>();
		LocalDate today = LocalDate.now();
		LocalDate lastYear = today.minusYears(1);
		
		while(today.isAfter(lastYear) || today.isEqual(lastYear)) {
			labels.add(lastYear.toString().substring(0,7));
			lastYear = lastYear.plusMonths(1);
		}
		
		for(int i=0; i<labels.size(); i++) {
			boolean flag = true;
			for(Map<String,Object> map : list) {
				if(((String)map.get("PJ_CREATED_DT")).substring(0,7).equals(labels.get(i))) {
					datas.add(((BigDecimal)map.get("PJ_CNT")).intValue());
					flag = false;
					break;
				}
			}
			if(flag){
				datas.add(0);
			}
		}
		
		datasetsMap.put("label", "프로젝트 생성");
		datasetsMap.put("data", datas);
		datasetsMap.put("borderWidth", 1);
		datasetsMap.put("backgroundColor", "rgba(75, 192, 192, 0.5)");
		datasets.add(datasetsMap);
		
		List<Map<String,Object>> endList = mapper.getPjEndCnt();
		Map<String,Object> endDatasetsMap = new HashMap<String,Object>();
		List<Integer> endDatas = new ArrayList<Integer>();

		for(int i=0; i<labels.size(); i++) {
			boolean flag = true;
			for(Map<String,Object> map : endList) {
				if(((String)map.get("PJ_END_DT")).substring(0,7).equals(labels.get(i))) {
					endDatas.add(((BigDecimal)map.get("PJ_CNT")).intValue());
					flag = false;
					break;
				}
			}
			if(flag){
				endDatas.add(0);
			}
		}
		
		endDatasetsMap.put("type", "line");
		endDatasetsMap.put("label", "프로젝트 완료");
		endDatasetsMap.put("data", endDatas);
		endDatasetsMap.put("borderWidth", 2);
		endDatasetsMap.put("borderColor", "#ee9933");
		endDatasetsMap.put("backgroundColor", "#ee9933");
		datasets.add(endDatasetsMap);

		data.put("labels", labels);
		data.put("datasets", datasets);
		
		return data;
	}

	@Override
	public Map<String,Object> getPjCategory() {
		List<Map<String,Object>> list = mapper.getPjCategory();
		Map<String,Object> data = new HashMap<String,Object>();
		List<String> labels = new ArrayList<String>();
		List<Map<String,Object>> datasets = new ArrayList<Map<String,Object>>();
		Map<String,Object> datasetsMap = new HashMap<String,Object>();
		List<Integer> datas = new ArrayList<Integer>();

		for(Map<String,Object> map : list) {
			labels.add((String)map.get("PJCATENAME"));
			datas.add(((BigDecimal)map.get("PJCATECNT")).intValue());
		}
		
		datasetsMap.put("label", "프로젝트 카테고리");
		datasetsMap.put("data", datas);
		datasetsMap.put("borderWidth", 1);
		datasets.add(datasetsMap);
		data.put("labels", labels);
		data.put("datasets", datasets);
		
		return data;
	}

	@Override
	public Map<String,Double> getReportCnt() {
		Map<String,BigDecimal> map = mapper.getReportCnt();
		int cntAll = 0;
		int cntY = 0;
		if(map.get("REPORTCNTALL")!=null) {
			cntAll = ((BigDecimal)map.get("REPORTCNTALL")).intValue();
		}
		if(map.get("REPORTCNTY")!=null) {
			cntY = ((BigDecimal)map.get("REPORTCNTY")).intValue();
		}
		
		Map<String,Double> mapd = new HashMap<String,Double>();
		double cntNd = (double)(cntAll-cntY) *100 / cntAll;
		double cntYd = (double)cntY *100 / cntAll;
		mapd.put("reportCntN", cntNd);
		mapd.put("reportCntY", cntYd);
		
		return mapd;
	}

	@Override
	public Map<String,Integer> getBusinessCnt() {
		Map<String,BigDecimal> map = mapper.getBusinessCnt();
		int readyCnt = map.get("READYCNT")==null ? 0 : ((BigDecimal)map.get("READYCNT")).intValue();
		int activeCnt = map.get("ACTIVECNT")==null ? 0 : ((BigDecimal)map.get("ACTIVECNT")).intValue();
		int blackCnt = map.get("BLACKCNT")==null ? 0 : ((BigDecimal)map.get("BLACKCNT")).intValue();
		
		Map<String,Integer> mapi = new HashMap<String,Integer>();
		mapi.put("readyCnt", readyCnt);
		mapi.put("activeCnt", activeCnt);
		mapi.put("blackCnt", blackCnt);
		
		return mapi;
	}

	@Override
	public List<NoticeBoardVO> readNoticeBoardList() {
		return mapper.readNoticeBoardList();
	}

	@Override
	public ServiceResult createVisit(String userId) {
		return mapper.createVisit(userId)>0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public Map<String, Object> getVisitCnt() {
		List<Map<String,Object>> list = mapper.getVisitCnt();
		Map<String,Object> data = new HashMap<String,Object>();
		List<String> labels = new ArrayList<String>();
		List<Map<String,Object>> datasets = new ArrayList<Map<String, Object>>();
		Map<String,Object> datasetsMap = new HashMap<String, Object>();
		List<Integer> datas = new ArrayList<Integer>();
		LocalDate today = LocalDate.now();
		LocalDate lastDay = today.minusMonths(12);
		
		while(today.isAfter(lastDay) || today.isEqual(lastDay)) {
			labels.add(lastDay.toString().substring(0,7));
			lastDay = lastDay.plusMonths(1);
		}
		for(int i=0; i<labels.size(); i++) {
			boolean flag = true;
			for(Map<String,Object> map : list) {
				if(labels.get(i).equals(map.get("VISIT_DATE"))) {
					datas.add(((BigDecimal)map.get("CNT")).intValue());
					flag = false;
					break;
				}
			}
			if(flag) {
				datas.add(0);
			}
		}
		datasetsMap.put("label", "방문자 수");
		datasetsMap.put("data", datas);
		datasetsMap.put("borderWidth", 1);
		datasetsMap.put("backgroundColor", "#ee9999");
		datasetsMap.put("fill", true);
		datasets.add(datasetsMap);
		data.put("labels", labels);
		data.put("datasets", datasets);
		
		return data;
	}
	
}
