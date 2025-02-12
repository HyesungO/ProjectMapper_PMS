package kr.or.ddit.advice;

import java.lang.reflect.Field;

import org.aspectj.lang.ProceedingJoinPoint;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.commons.primaryKey.PrimaryKeyIdentify;
import kr.or.ddit.log.service.LogService;
import kr.or.ddit.notication.alert.service.AlertService;
import kr.or.ddit.resources.service.ResourcesService;
import kr.or.ddit.vo.LogVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class LoggingAdvice {
	@Autowired
	private ResourcesService resourceService;
	@Autowired
	private LogService logService;
	
   public Object around(ProceedingJoinPoint point) throws Throwable {
      long start = System.currentTimeMillis();
      
   // Spring Security Context에서 Principal 가져오기
      Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
      String username = authentication != null ? authentication.getName() : "Unknown";
      authentication.getPrincipal();
      
      Object target = point.getTarget(); // 객체 그자체
      String targetName = target.getClass().getSimpleName(); // 타겟 실행 클래스명
      String methodName = point.getSignature().getName(); // 실행 메소드
      Object[] args = point.getArgs(); // 실행하는 쿼리 데이터들
     
      log.info("around before prici :  {}", authentication.getPrincipal());
      log.info("around before username :  {}", username);
      log.info("around before target :  {}", target);
      log.info("around before targetName :  {}", targetName);
      log.info("around before methodName :  {}", methodName);
      log.info("around before args :  {}", args);
      
//      log.info("=-=-=-=-=-=-BEFORE=-=-=-=-=-=-=-=-{}.{}({})", targetName, methodName, args);
      
      Object retValue = point.proceed(args);
      
      long end = System.currentTimeMillis();
      log.info("around after username :  {}", username);
      log.info("around after target :  {}", target);
      log.info("around after targetName :  {}", targetName);
      log.info("around after methodName :  {}", methodName);
      log.info("around after args :  {}", args);
      log.info("around after retValue :  {}", retValue);
      log.info("=-=-=-=-=-=-AFTER=-=-소요시간 : {}ms=-=-: 반환값: {} =-=-=-=",(end-start), retValue);
      
      // 로그 DB 저장
      if(ServiceResult.OK==retValue) {
    	  if(methodName.startsWith("create")||methodName.startsWith("modify")||methodName.startsWith("remove")) {
    		  LogVO logVo = new LogVO();
    		  logVo.setResourceId(selectResourceId(methodName));
    		  logVo.setUserId(username);
    		  logVo.setEntityId(selectPk(args));
    		  logVo.setPjId(selectPjId(args));
    		  log.info("이슈에 대한 로그 찍기 위한 logVo : {} ",logVo);
    		  logService.saveLog(logVo);
    	  }    	      	  
      }
      
      return retValue;
   }
   
   private String selectResourceId(String methodName) {
	   String resourceId = resourceService.readResourceid(methodName);
	   // 여기서 자원 찾기
	   return resourceId;
   }
   
	private String selectPk(Object... args) {
		for (Object arg : args) {
			// PK를 찾는 인터페이스를 생성하고, VO에서 상속 받아 getter를 설정함.
			if (arg instanceof PrimaryKeyIdentify) {
				// a instanceof b a가 b 타입이거나, 하위 타입의 객체인지 확인하는 조건문
				return ((PrimaryKeyIdentify) arg).getPrimaryKey();
			}
		}
		return null;
	}
	
	private String selectPjId(Object... args) {
		for (Object arg : args) {
			try {
				// arg에서 "pjId" 필드를 찾음
				Field field = arg.getClass().getDeclaredField("pjId");
				field.setAccessible(true); // private 필드에 접근 가능하도록 설정
				
				// pjId 값을 가져오기
				Object pjId = field.get(arg);
				if(pjId!=null) {
					return pjId.toString();
				}
			} catch (NoSuchFieldException | IllegalAccessException e) {
				// 없으면 패스
			}
		}
		return null;
	}
}
