package kr.or.ddit.errors;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("errors")
@Controller
public class ErrorController {
	
	@GetMapping("500")
	public String error500(Model model) {
		
		return "/errors/500";
	}
	@GetMapping("403")
	public String error403(Model model) {
		
		return "/errors/403";
	}
	@GetMapping("404")
	public String error404(Model model) {
		
		return "/errors/404";
	}
}
