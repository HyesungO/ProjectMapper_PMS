package kr.or.ddit.validate.constraint;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import javax.validation.Constraint;
import javax.validation.Payload;
import javax.validation.ReportAsSingleViolation;
import javax.validation.constraints.Pattern;

@Constraint(validatedBy = { }) //컴스트레인트 어노테이션 
@Target(ElementType.FIELD)
@Retention(RetentionPolicy.RUNTIME) //사람 컴퓨터 벌쳐머신도 읽을 수 있음 
@Pattern(regexp = "\\d{2,3}-\\d{3,4}-\\d{4}")
//@ReportAsSingleViolation
//실행시점에도 트레이싱할 수 있음 RUNTIME
public @interface TelephoneNumber {
   //메타어노테이션 
   //마커어노테이션은 될 수가 없다. 
   //밸류가 사용되지 않아서 싱글 벨류 어노테이션 @Target(ElementType.FIELD)
   //-> 전역변수에만 사용가능 
	String  regexp() default "";
	
   
    String message() default "전화번호 형식 확인";

    Class<?>[] groups() default { };

    Class<? extends Payload>[] payload() default { };
   

}
