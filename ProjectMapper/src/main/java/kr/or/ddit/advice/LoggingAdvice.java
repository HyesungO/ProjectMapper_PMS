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
	@Autowired
	private AlertService alertService;
	
   public Object around(ProceedingJoinPoint point) throws Throwable {
      long start = System.currentTimeMillis();
      
   // Spring Security Context에서 Principal 가져오기
      Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
      String username = authentication != null ? authentication.getName() : "Unknown";
      authentication.getPrincipal();
      // 필요한건 타겟네임 / 메소드 네임 / args / 
      // 메소드 네임이 create / modify / remove로 시작하는 것들 찾기
      // 그 뒤에 이름을 처리한다던가 createIssue 면 create / Issue 분리한다던가
      // retValue
      // result == OK 라면 인 딜 업 한것
      // args 값에서 뭐 꺼내던지해서 처리해야할듯?
      
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
      
      // 로그 찍기
      if(ServiceResult.OK==retValue) {
    	  if(methodName.startsWith("create")||methodName.startsWith("modify")||methodName.startsWith("remove")) {
    		  LogVO logVo = new LogVO();
    		  logVo.setResourceId(selectResourceId(methodName));
    		  logVo.setUserId(username);
    		  logVo.setEntityId(selelctPk(args));
    		  logVo.setPjId(selelctPjId(args));
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
   
	private String selelctPk(Object... args) {
		for (Object arg : args) {
			if (arg instanceof PrimaryKeyIdentify) {
				return ((PrimaryKeyIdentify) arg).getPrimaryKey();
			}
		}
		return null;
	}
	private String selelctPjId(Object... args) {
		for (Object arg : args) {
			try {
				Field field = arg.getClass().getDeclaredField("pjId");
				if(field!=null) {
					field.setAccessible(true);
					Object pjId = field.get(arg);
					return pjId != null ? pjId.toString() : null;
				}
			} catch (Exception e) {
				return null;
			}
			
		}
		return null;
	}
}
