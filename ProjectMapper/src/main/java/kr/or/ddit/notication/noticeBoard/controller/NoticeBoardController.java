package kr.or.ddit.notication.noticeBoard.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.atch.service.AtchFileService;
import kr.or.ddit.atch.vo.AtchFileDetailVO;
import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.notication.noticeBoard.service.NoticeBoardService;
import kr.or.ddit.notication.vo.NoticeBoardVO;
import kr.or.ddit.paging.PaginationInfo;
import kr.or.ddit.paging.SimpleCondition;
import kr.or.ddit.paging.renderer.CustomPaginationRenderer;
import kr.or.ddit.paging.renderer.PaginationRenderer;

@Controller
@RequestMapping("/system/noticeBoard")
public class NoticeBoardController {
    
    // 페이징 관련 상수 정의
    private static final int SCREEN_SIZE = 10; // 페이지당 게시물 수
    private static final int BLOCK_SIZE = 5;   // 페이지 블록 크기
    
    @Inject
    private NoticeBoardService service;
    
    @Inject
    private AtchFileService atchService;
    
    @Value("#{dirInfo.saveDir}")
    private File saveFolder;
    
    // PaginationInfo 생성 공통 메서드
    private PaginationInfo<NoticeBoardVO> getPaginationInfo(int currentPage, SimpleCondition simpleCondition) {
        PaginationInfo<NoticeBoardVO> paging = new PaginationInfo<>(SCREEN_SIZE, BLOCK_SIZE);
        paging.setCurrentPage(currentPage);
        paging.setSimpleCondition(simpleCondition);
        return paging;
    }
    
    // 목록 조회 - 페이징 적용
    @GetMapping("list")
    public String noticeList(
        @RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
        @ModelAttribute("simpleCondition") SimpleCondition simpleCondition,
        Model model
    ) {
        PaginationInfo<NoticeBoardVO> paging = getPaginationInfo(currentPage, simpleCondition);
        List<NoticeBoardVO> noticeList = service.retrieveNoticeList(paging);
        
        // CustomPaginationRenderer 사용
        PaginationRenderer renderer = new CustomPaginationRenderer();
        
        model.addAttribute("noticeList", noticeList);
        model.addAttribute("paging", paging);
        model.addAttribute("pagingHTML", renderer.renderPagination(paging, "fn_paging"));
        
        return "system/noticeBoard/NoticeBoardList";
    }
    
    // 공지사항 등록 폼
    @GetMapping("form")
    public String noticeForm(
        @RequestParam(required = false) String noticeId, 
        Model model
    ) {
        if(noticeId != null) {
            // 수정 시: 기존 데이터 조회
            NoticeBoardVO notice = service.retrieveNotice(noticeId);
            model.addAttribute("notice", notice);
        } else if(!model.containsAttribute("notice")) {
            // 새로운 등록 시
            NoticeBoardVO notice = new NoticeBoardVO();
            notice.setAdminId("USER052");
            model.addAttribute("notice", notice);
        }
        return "system/noticeBoard/NoticeBoardForm";
    }
    
    // 상세 조회
    @GetMapping("detail")
    public String noticeDetail(
        @RequestParam String noticeId,
        @RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
        Model model
    ) {
        NoticeBoardVO notice = service.retrieveNotice(noticeId);
        model.addAttribute("notice", notice);
        model.addAttribute("currentPage", currentPage);
        return "system/noticeBoard/NoticeBoardDetail";
    }
    
    // 파일 다운로드
    @GetMapping("download/{atchFileId}/{fileNumber}")
    public ResponseEntity<Resource> download(
        @PathVariable("atchFileId") String atchFileId,
        @PathVariable("fileNumber") int fileNumber
    ) {
        AtchFileDetailVO fileDetail = atchService.readAtchFileDetail(
            Integer.parseInt(atchFileId), fileNumber, saveFolder
        );
        
        if(fileDetail == null) {
            return ResponseEntity.notFound().build();
        }
        
        Resource resource = fileDetail.getSavedFile();
        String filename = fileDetail.getOriginalFileName();
        
        return ResponseEntity.ok()
            .header("Content-Length", String.valueOf(fileDetail.getFileSize()))
            .header("Content-Type", fileDetail.getFileMime())
            .header("Content-Disposition", "attachment;filename=" + filename)
            .body(resource);
    }
    
    // 공지사항 등록 처리
    @PostMapping
    @ResponseBody
    public Map<String, Object> noticeInsert(
        @ModelAttribute NoticeBoardVO notice,
        HttpServletRequest req
    ) {
        Map<String, Object> result = new HashMap<>();
        try {
            notice.setAdminId("USER052"); // 관리자 ID 설정
            ServiceResult serviceResult = service.createNotice(notice);
            result.put("success", serviceResult == ServiceResult.OK);
            if(serviceResult == ServiceResult.OK) {
                result.put("noticeId", notice.getNoticeId());
            } else {
                result.put("message", "저장에 실패했습니다.");
            }
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "서버 오류: " + e.getMessage());
        }
        return result;
    }

    // 공지사항 수정 처리
    @PutMapping("{noticeId}")
    @ResponseBody
    public Map<String, Object> noticeModify(
        @PathVariable String noticeId,
        @ModelAttribute NoticeBoardVO notice
    ) {
        Map<String, Object> result = new HashMap<>();
        notice.setNoticeId(noticeId);
        notice.setAdminId("USER052"); // 관리자 ID 설정
        
        try {
            ServiceResult serviceResult = service.modifyNotice(notice);
            result.put("success", serviceResult == ServiceResult.OK);
            if(serviceResult != ServiceResult.OK) {
                result.put("message", "수정에 실패했습니다.");
            }
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "서버 오류: " + e.getMessage());
        }
        return result;
    }

    // 공지사항 삭제 처리
    @DeleteMapping("{noticeId}")
    @ResponseBody
    public Map<String, Object> noticeDelete(
        @PathVariable String noticeId,
        @RequestParam(name = "page", required = false, defaultValue = "1") int currentPage
    ) {
        Map<String, Object> result = new HashMap<>();
        try {
            ServiceResult serviceResult = service.removeNotice(noticeId);
            result.put("success", serviceResult == ServiceResult.OK);
            if(serviceResult == ServiceResult.OK) {
                result.put("currentPage", currentPage);
            } else {
                result.put("message", "삭제에 실패했습니다.");
            }
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "서버 오류: " + e.getMessage());
        }
        return result;
    }

    // 검색 기능
    @PostMapping("/search")
    @ResponseBody
    public Map<String, Object> searchNotices(
        @RequestParam("searchType") String searchType,
        @RequestParam("searchWord") String searchWord,
        @RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
        Model model
    ) {
        Map<String, Object> result = new HashMap<>();
        try {
            // 공통 메서드 사용
            SimpleCondition simpleCondition = new SimpleCondition();
            simpleCondition.setSearchType(searchType);
            simpleCondition.setSearchWord(searchWord);
            
            PaginationInfo<NoticeBoardVO> paging = getPaginationInfo(currentPage, simpleCondition);
            List<NoticeBoardVO> noticeList = service.retrieveNoticeList(paging);
            
            PaginationRenderer renderer = new CustomPaginationRenderer();
            result.put("success", true);
            result.put("noticeList", noticeList);
            result.put("paging", paging);
            result.put("pagingHTML", renderer.renderPagination(paging, "fn_paging"));
            
        } catch (Exception e) {
            return handleException(e);
        }
        return result;
    }

    // 팝업 공지사항 조회
    @GetMapping("popup")
    @ResponseBody
    public List<NoticeBoardVO> getPopupNotices() {
        return service.retrievePopupNotices();
    }

    // 첨부파일 삭제
    @DeleteMapping("file/{atchFileId}/{fileNumber}")
    @ResponseBody
    public Map<String, Object> deleteAtchFile(
        @PathVariable int atchFileId,
        @PathVariable int fileNumber
    ) {
        Map<String, Object> result = new HashMap<>();
        try {
            atchService.removeAtchFileDetail(atchFileId, fileNumber, saveFolder);
            result.put("success", true);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "파일 삭제 실패: " + e.getMessage());
        }
        return result;
    }
    
    // 에러 결과 생성 공통 메서드
    private Map<String, Object> createErrorResult(String message) {
        Map<String, Object> result = new HashMap<>();
        result.put("success", false);
        result.put("message", message);
        return result;
    }
    
    // 예외 처리 공통 메서드
    private Map<String, Object> handleException(Exception e) {
        return createErrorResult("처리 중 오류가 발생했습니다: " + e.getMessage());
    }
}