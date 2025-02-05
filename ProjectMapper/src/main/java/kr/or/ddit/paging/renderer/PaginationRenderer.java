package kr.or.ddit.paging.renderer;

import kr.or.ddit.paging.PaginationInfo;
import kr.or.ddit.paging.PaginationInfo2;

public interface PaginationRenderer {
	
	/**
	 * PaginationInfo 내의 startPage 와 endPage로 페이지 이동 링크 생성
	 * @param paging
	 * @param fnName
	 * @return
	 */
	public String renderPagination(PaginationInfo paging, String fnName);


	public String renderPagination(PaginationInfo2 paging, String fnName);

}
