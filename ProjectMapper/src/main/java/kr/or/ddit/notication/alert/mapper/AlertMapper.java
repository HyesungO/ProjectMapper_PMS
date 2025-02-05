package kr.or.ddit.notication.alert.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.notication.vo.AlertVO;

@Mapper
public interface AlertMapper {

	/**
	 * 알람이 필요한 것들에 대해 단일 처리용 메소드
	 * @param alert
	 */
	public int insertAlert(AlertVO alert);
	
	/**
	 * 알람이 필요한 것들에 대해 여러데이터 처리용 메소드
	 * ex ) 프로젝트 멤버들 전원에게 알림이 가는 경우
	 * @param alerts
	 * @return
	 */
	public int insertAlerts(List<AlertVO> alerts);
	
	/**
	 * 알림 리스트 띄울 것
	 * @param userId
	 * @return
	 */
	public List<AlertVO> selectAlertList(String userId);
}
