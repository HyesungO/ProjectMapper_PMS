package kr.or.ddit.system.chart.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/system/chart")
@Controller
public class SystemChartController {

	@GetMapping
	public String ReadSystemChart() {
		return "system/system";
	}
}
