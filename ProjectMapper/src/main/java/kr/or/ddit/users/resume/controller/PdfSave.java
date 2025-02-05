package kr.or.ddit.users.resume.controller;

import java.io.File;
import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import javax.servlet.annotation.MultipartConfig;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequestMapping("/pdf")
@MultipartConfig
public class PdfSave {
	
	@Value("#{dirInfo.saveDir}")
	private Resource folderPath;
	private File saveFoler;
	
	@PostMapping
	@ResponseBody
	public void pdfSave(@RequestParam("pdfFile") MultipartFile pdfFile) throws IOException, URISyntaxException{
		this.saveFoler = folderPath.getFile();
		if (!saveFoler.exists()) {
			saveFoler.mkdirs();
		}
		URI uri = new URI(folderPath.getURI() + pdfFile.getOriginalFilename());
        Path path = Paths.get(uri);
        try {
//			FileOutputStream fout = new FileOutputStream(path.toString());
//			
//			BufferedOutputStream bout = new BufferedOutputStream(fout, 5);
//			
//			for(char c='1'; c<='9'; c++) {
//				bout.write(c);
//			}
//			bout.close();
			Files.write(path, pdfFile.getBytes());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
//		FileOutputStream stream = null;
//		String imgData = map.get("imgData");
//		try{
//			System.out.println("binary file =====================================>  "  + imgData);
//			if(imgData == null || imgData.trim().equals("")) {
//			    throw new Exception();
//			}
//			imgData = imgData.replaceAll("data:image/png;base64,", "");
//			byte[] file = Base64.getDecoder().decode(imgData);
//			String fileName=  UUID.randomUUID().toString();
//			
//			stream = new FileOutputStream("D:/multipartDir/saveDir/"+fileName+".png");
//			stream.write(file);
//			stream.close();
//			
//		}catch(Exception e){
//			e.printStackTrace();
//			System.out.println("에러 발생");
//		}finally{
//			if(stream != null) {
//				try {
//					stream.close();
//				} catch (IOException e) {
//					// TODO Auto-generated catch block
//					e.printStackTrace();
//				}
//			}
//		}
	}
	
}
