package kr.or.ddit.atch.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Base64;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.Base64Utils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.atch.service.AtchFileService;
import kr.or.ddit.atch.vo.AtchFileDetailVO;
import kr.or.ddit.atch.vo.AtchFileVO;

@Controller
@RequestMapping("/atch")
public class AtchFileController {

	// DirectoryInfo 설정 및 properties 파읿 빈 등록(context-common.xml)
	@Value("#{dirInfo.saveDir}") // 2인 데이터 저장위치
	private Resource saveFolderRes;
	private File saveFolder;
	
	@Inject
	private AtchFileService atchFileService;
	
	
	@GetMapping("{atchFileId}")
	public AtchFileVO readFileList(@PathVariable("atchFileId") int atchFileId) {
		
		return atchFileService.readAtchFileList(atchFileId);
	}
	
	@GetMapping("{atchFileId}/{fileNumber}")
	public ResponseEntity<String> pdfFile(@PathVariable("atchFileId")int atchFileId, @PathVariable("fileNumber")int fileNumber) throws IOException {
			
		AtchFileDetailVO afdVo = atchFileService.readAtchFileDetail(atchFileId, fileNumber, saveFolder);
			
		File file = afdVo.getSavedFile().getFile();
		
//		File file2 = new File("C:\\Users\\gptjd\\Desktop\\pdfFile-compressed.pdf");
		
	    // 파일을 바이트 배열로 읽어오기
	    byte[] fileContent = Files.readAllBytes(file.toPath());

	    // Base64로 인코딩
	    String base64EncodedPDF = Base64.getEncoder().encodeToString(fileContent);

	    return ResponseEntity.ok(base64EncodedPDF);
	}
}
