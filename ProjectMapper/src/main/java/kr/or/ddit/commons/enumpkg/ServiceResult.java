package kr.or.ddit.commons.enumpkg;

public enum ServiceResult {
	
	OK,                // 성공
    FAIL,              // 실패
    PKDUPLICATED,      // 기본키 중복
    INVALIDPASSWORD,   // 잘못된 비밀번호
    NOTEXIST           // 데이터 없음 - 추가
}
