package kr.or.ddit.projects.project.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/PhotoView")
public class PhotoView extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		 
		String image = request.getParameter("image");
		

		// 업로드된 파일들이 저장될 폴더 설정
		String uploadPath = "//192.168.146.65/192.168.146.65/saveDir";

		File file = new File(uploadPath);
		
		File imageFile = new File(file, image);
		
		if(image==null || !imageFile.exists() ||image == "") {
			imageFile = new File(file,"이미지기본.jpg");
		}
		BufferedInputStream bin = null;
		BufferedOutputStream bout = null;
		try {
			// 출력용 스트림 객체 생성 ==> Response객체 이용
			bout = new BufferedOutputStream(response.getOutputStream());
			
			// 파일 입력용 스트림 객체 생성
			bin = new BufferedInputStream(new FileInputStream(imageFile));
			
			byte[] temp = new byte[1024];
			int len = 0;
			
			while((len = bin.read(temp)) > 0) {
				bout.write(temp, 0, len);
			}
			bout.flush();
			
		} catch (Exception e) {
			System.out.println("입출력 오류 : " + e.getMessage());
		} finally {
			if(bin!=null) try { bin.close(); }catch (IOException e) {}
			if(bout!=null) try { bout.close(); }catch (IOException e) {}
		}
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}