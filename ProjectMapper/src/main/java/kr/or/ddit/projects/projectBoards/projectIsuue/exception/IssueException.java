package kr.or.ddit.projects.projectBoards.projectIsuue.exception;

/**
 * 게시판 에서만 사용할 커스텀 예외
 *
 */
public class IssueException extends RuntimeException{
	
	public IssueException() {
		super();
		
	}
	
	public IssueException(int boNo) {
		super(String.format("글번호 %d 예서 예외 발생", boNo));
		
	}

	public IssueException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
		super(message, cause, enableSuppression, writableStackTrace);
		
	}

	public IssueException(String message, Throwable cause) {
		super(message, cause);
		
	}

	public IssueException(String message) {
		super(message);
		
	}

	public IssueException(Throwable cause) {
		super(cause);
		
	}
	
}
