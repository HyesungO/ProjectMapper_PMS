package kr.or.ddit.users.mypage.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.users.mypage.mapper.CareerMapper;
import kr.or.ddit.users.vo.CareerVO;

@Service
public class CareerServiceImpl implements CareerService {
	
	@Autowired
	private CareerMapper mapper;
	
	@Override
	public ServiceResult createCareer(CareerVO career) {
		ServiceResult result = null;
		int rowcnt = mapper.insertCareer(career);
		result = rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
		return result;
	}

	@Override
	public List<CareerVO> readCareerList() {
		return mapper.selectCareerList();
	}

	@Override
	public CareerVO readCareer(String careerId) {
		return mapper.selectCareer(careerId);
	}

	@Override
	public ServiceResult modifyCareer(CareerVO career) {
		ServiceResult result = null;
		int rowcnt = mapper.updateCareer(career);
		result = rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
		return result;
	}

	@Override
	public ServiceResult deleteCareer(String careerId) {
		ServiceResult result = null;
		int rowcnt = mapper.deleteCareer(careerId);
		result = rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
		return result;
	}

}
