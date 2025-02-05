package kr.or.ddit.notication.noticeBoard.service;

import java.io.File;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.atch.service.AtchFileService;
import kr.or.ddit.atch.vo.AtchFileDetailVO;
import kr.or.ddit.atch.vo.AtchFileVO;
import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.notication.noticeBoard.mapper.NoticeBoardMapper;
import kr.or.ddit.notication.vo.NoticeBoardVO;
import kr.or.ddit.paging.PaginationInfo;

@Service
public class NoticeBoardServiceImpl implements NoticeBoardService {
    
    @Inject
    private NoticeBoardMapper mapper;
    
    @Inject
    private AtchFileService atchService;
    
    @Value("#{dirInfo.saveDir}")
    private File saveFolder;

    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd");

    // 날짜 포맷팅을 위한 유틸리티 메서드
    private String formatDateTime(LocalDateTime dateTime) {
        return dateTime != null ? dateTime.format(DATE_FORMATTER) : "";
    }

    // 첨부파일 처리 메서드
    private void processNoticeFiles(NoticeBoardVO notice) {
        MultipartFile[] noticeFiles = notice.getNoticeFiles();
        if(noticeFiles != null && noticeFiles.length > 0) {
            AtchFileVO fileGroup = new AtchFileVO();
            fileGroup.setFileDetails(new ArrayList<>());
            fileGroup.setAtchUseAt(true);
            
            for(MultipartFile file : noticeFiles) {
                if(!file.isEmpty()) {
                    AtchFileDetailVO fileDetail = new AtchFileDetailVO(file);
                    fileGroup.getFileDetails().add(fileDetail);
                }
            }
            
            if(!fileGroup.getFileDetails().isEmpty()) {
                atchService.createAtchFile(fileGroup, saveFolder);
                notice.setNoticeAfi(String.valueOf(fileGroup.getAtchFileId()));
            }
        }
    }
    
    // 페이징 처리된 공지사항 목록 조회
    @Override
    public List<NoticeBoardVO> retrieveNoticeList(PaginationInfo<NoticeBoardVO> paging) {
        int totalRecord = mapper.selectTotalRecord(paging);
        paging.setTotalRecord(totalRecord);
        
        List<NoticeBoardVO> noticeList = mapper.selectNoticeList(paging);
        for(NoticeBoardVO notice : noticeList) {
            notice.setFormattedCreatedDt(formatDateTime(notice.getNoticeCreatedDt()));
            notice.setFormattedUpdatedDt(formatDateTime(notice.getNoticeUpdatedDt()));
        }
        return noticeList;
    }
    
    // 공지사항 상세 조회 (조회수 증가 포함)
    @Override
    @Transactional
    public NoticeBoardVO retrieveNotice(String noticeId) {
        NoticeBoardVO notice = mapper.selectNotice(noticeId);
        if(notice != null) {
            mapper.incrementViewCount(noticeId);
            notice.setNoticeViewCount(notice.getNoticeViewCount() + 1);
            notice.setFormattedCreatedDt(formatDateTime(notice.getNoticeCreatedDt()));
            notice.setFormattedUpdatedDt(formatDateTime(notice.getNoticeUpdatedDt()));
        }
        return notice;
    }
    
    // 공지사항 등록
    @Override
    @Transactional
    public ServiceResult createNotice(NoticeBoardVO notice) {
        try {
            processNoticeFiles(notice);
            
            String noticeId = "NOT" + System.currentTimeMillis();
            notice.setNoticeId(noticeId);
            notice.setAdminId("USER052");
            notice.setNoticeCreatedDt(LocalDateTime.now());
            notice.setNoticeDeleteFlag("N");
            notice.setNoticeViewCount(0L);
            
            int rowcnt = mapper.insertNotice(notice);
            return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
        } catch (Exception e) {
            e.printStackTrace();
            return ServiceResult.FAIL;
        }
    }
    
    // 공지사항 수정
    @Override
    @Transactional
    public ServiceResult modifyNotice(NoticeBoardVO notice) {
        NoticeBoardVO existingNotice = mapper.selectNotice(notice.getNoticeId());
        if(existingNotice == null) {
            return ServiceResult.NOTEXIST;
        }
        
        try {
            processNoticeFiles(notice);
            notice.setNoticeUpdatedDt(LocalDateTime.now());
            int rowcnt = mapper.updateNotice(notice);
            return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
        } catch (Exception e) {
            e.printStackTrace();
            return ServiceResult.FAIL;
        }
    }
    
    // 공지사항 삭제
    @Override
    @Transactional
    public ServiceResult removeNotice(String noticeId) {
        NoticeBoardVO existingNotice = mapper.selectNotice(noticeId);
        if(existingNotice == null) {
            return ServiceResult.NOTEXIST;
        }
        
        try {
            if(existingNotice.getNoticeAfi() != null) {
                atchService.disableAtchFile(Integer.parseInt(existingNotice.getNoticeAfi()));
            }
            
            int rowcnt = mapper.deleteNotice(noticeId);
            return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
        } catch (Exception e) {
            e.printStackTrace();
            return ServiceResult.FAIL;
        }
    }
    
    // 공지사항 검색
    @Override
    public List<NoticeBoardVO> searchNotices(String searchType, String searchWord) {
        Map<String, String> params = new HashMap<>();
        params.put("searchType", searchType);
        params.put("searchWord", searchWord);
        List<NoticeBoardVO> noticeList = mapper.searchNotices(params);
        for(NoticeBoardVO notice : noticeList) {
            notice.setFormattedCreatedDt(formatDateTime(notice.getNoticeCreatedDt()));
            notice.setFormattedUpdatedDt(formatDateTime(notice.getNoticeUpdatedDt()));
        }
        return noticeList;
    }
    
    // 팝업 공지사항 조회
    @Override
    public List<NoticeBoardVO> retrievePopupNotices() {
        List<NoticeBoardVO> noticeList = mapper.selectPopupNotices();
        for(NoticeBoardVO notice : noticeList) {
            notice.setFormattedCreatedDt(formatDateTime(notice.getNoticeCreatedDt()));
            notice.setFormattedUpdatedDt(formatDateTime(notice.getNoticeUpdatedDt()));
        }
        return noticeList;
    }
    
    // 첨부파일 다운로드
    @Override
    public AtchFileDetailVO download(int atchFileId, int fileNumber) {
        return atchService.readAtchFileDetail(atchFileId, fileNumber, saveFolder);
    }
}