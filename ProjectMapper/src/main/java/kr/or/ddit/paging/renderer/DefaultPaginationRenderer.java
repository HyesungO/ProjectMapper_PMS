package kr.or.ddit.paging.renderer;

import kr.or.ddit.paging.PaginationInfo;
import kr.or.ddit.paging.PaginationInfo2;

public class DefaultPaginationRenderer implements PaginationRenderer {

	@Override
	public String renderPagination(PaginationInfo paging, String fnName) {
		int startPage = paging.getStartPage();
		int endPage = paging.getEndPage();
		int totalPage = paging.getTotalPage();
		int blockSize = paging.getBlockSize();
		int currentPage = paging.getCurrentPage();
		
		endPage = endPage > totalPage ? totalPage : endPage;
		
		StringBuffer html = new StringBuffer();
//		html.append(" <div class='d-flex justify-content-center mt-4'> ");
		html.append(" <nav aria-label='Page navigation example'> ");
		html.append("			<ul class= 'pagination'>");
		String pattern = "<li class= 'page-item '><a class= 'page-link' href= '?page=%d'>%s</a></li>";  
		 
		if(startPage > blockSize) {
			html.append(
				String.format(pattern, startPage-blockSize, "이전")
			);
		}
		for(int page = startPage; page <= endPage; page++) {
			if(page == currentPage) {
				html.append(
					String.format(pattern, page,page)	
				);
			}else {
				html.append(
					String.format(pattern, page, page)
				);
			}
				
		}
		if(endPage < totalPage) {
			html.append(
				String.format(pattern, endPage+1, "다음")
			);
		}
		html.append(" </ul> ");
		html.append(" </nav>");
//		html.append(" </div> ");
		
		return html.toString();
	}
	@Override
	public String renderPagination(PaginationInfo2 paging, String fnName) {
		int startPage = paging.getStartPage();
		int endPage = paging.getEndPage();
		int totalPage = paging.getTotalPage();
		int blockSize = paging.getBlockSize();
		int currentPage = paging.getCurrentPage();
		
		endPage = endPage > totalPage ? totalPage : endPage;
		
		StringBuffer html = new StringBuffer();
//		html.append(" <div class='d-flex justify-content-center mt-4'> ");
		html.append(" <nav aria-label='Page navigation example'> ");
		html.append("			<ul class= 'pagination'>");
		String pattern = "<li class= 'page-item '><a class= 'page-link' href= '?page=%d'>%s</a></li>";  
		
		if(startPage > blockSize) {
			html.append(
					String.format(pattern, startPage-blockSize, "이전")
					);
		}
		for(int page = startPage; page <= endPage; page++) {
			if(page == currentPage) {
				html.append(
						String.format(pattern, page,page)	
						);
			}else {
				html.append(
						String.format(pattern, page, page)
						);
			}
			
		}
		if(endPage < totalPage) {
			html.append(
					String.format(pattern, endPage+1, "다음")
					);
		}
		html.append(" </ul> ");
		html.append(" </nav>");
//		html.append(" </div> ");
		
		return html.toString();
	}

}










