package kr.or.ddit.users.user.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.paging.PaginationInfo;
import kr.or.ddit.paging.SimpleCondition;
import kr.or.ddit.users.user.service.UserService;
import kr.or.ddit.users.vo.CompanyUsersVO;
import kr.or.ddit.users.vo.UsersVO;

@Controller
@MultipartConfig
@RequestMapping("/users/user")
public class UserController {
	@Inject
	private UserService service;

	// 로그인 페이지 표시
	@GetMapping("login")
	public String loginForm() {
		return "user/user/login";
	}
	
	 // 로그인 처리
//  @PostMapping("login")
//  public String login(
//      @RequestParam("userId") String userId, 
//      @RequestParam("userPassword") String userPassword,
//      HttpSession session,
//      Model model
//  ) {
//      UsersVO loginUser = service.loginUser(userId, userPassword);
//      
//      if(loginUser != null) {
//          session.setAttribute("loginUser", loginUser);
//          System.out.println("User logged in: " + loginUser.getUserId());
//          return "redirect:/projects/project/myProjects";
//      } else {
//          model.addAttribute("message", "아이디나 비밀번호가 일치하지 않습니다.");
//          return "user/user/userLogin";
//      }
//  }

	// 로그아웃 처리
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/index.do";
	}

	// 사용자 목록 페이지 표시 (페이징, 검색 처리)
	@GetMapping("list")
	public String userList(@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false) String searchType, @RequestParam(required = false) String searchWord,
			Model model) {
		PaginationInfo<UsersVO> paging = new PaginationInfo<>(10, 5);
		paging.setCurrentPage(currentPage);

		SimpleCondition simpleCondition = new SimpleCondition();
		simpleCondition.setSearchType(searchType);
		simpleCondition.setSearchWord(searchWord);
		paging.setSimpleCondition(simpleCondition);

		List<UsersVO> userList = service.retrieveUserList(paging);

		model.addAttribute("userList", userList);
		model.addAttribute("paging", paging);

		return "user/user/userList";
	}

	// 사용자 검색 처리 (페이징 포함)
	@PostMapping("search")
	@ResponseBody
	public Map<String, Object> searchUsers(@RequestParam(required = false, defaultValue = "1") int page,
			@RequestParam String searchType, @RequestParam String searchWord) {
		Map<String, Object> result = new HashMap<>();

		PaginationInfo<UsersVO> paging = new PaginationInfo<>(10, 5);
		paging.setCurrentPage(page);

		SimpleCondition simpleCondition = new SimpleCondition();
		simpleCondition.setSearchType(searchType);
		simpleCondition.setSearchWord(searchWord);
		paging.setSimpleCondition(simpleCondition);

		List<UsersVO> userList = service.retrieveUserList(paging);

		result.put("userList", userList);
		result.put("paging", paging);

		return result;
	}

	// 사용자 목록 정렬 처리 (페이징 포함)
	@GetMapping("sort")
	@ResponseBody
	public Map<String, Object> sortUsers(@RequestParam String column, @RequestParam String direction,
			@RequestParam(required = false, defaultValue = "1") int page) {
		Map<String, Object> result = new HashMap<>();

		PaginationInfo<UsersVO> paging = new PaginationInfo<>(10, 5);
		paging.setCurrentPage(page);

		Map<String, Object> variousCondition = new HashMap<>();
		variousCondition.put("column", column);
		variousCondition.put("direction", direction);
		paging.setVariousCondition(variousCondition);

		List<UsersVO> sortedList = service.retrieveUserList(paging);

		result.put("userList", sortedList);
		result.put("paging", paging);

		return result;
	}

	// 단일 사용자 검색
	@GetMapping("search/{userId}")
	@ResponseBody
	public UsersVO searchUser(@PathVariable("userId") String userId) {
		UsersVO user = service.retrieveUser(userId);
		return user != null ? user : new UsersVO();
	}

	// ID/PW 찾기 페이지 표시
	@GetMapping("find")
	public String findForm() {
		return "user/user/findAccount";
	}

	// ID 찾기 처리
	@PostMapping("find/id")
	@ResponseBody
	public Map<String, Object> findId(@RequestParam String userEmail, @RequestParam String userPhone) {
		Map<String, Object> result = new HashMap<>();
		StringBuilder foundId = new StringBuilder();
		ServiceResult serviceResult = service.findUserId(userEmail, userPhone, foundId);

		result.put("success", serviceResult == ServiceResult.OK);
		if (serviceResult == ServiceResult.OK) {
			result.put("userId", foundId.toString());
		} else {
			result.put("message", "일치하는 회원 정보가 없습니다.");
		}

		return result;
	}

	// 비밀번호 재설정 처리
	@PostMapping("find/password")
	@ResponseBody
	public Map<String, Object> resetPassword(@RequestParam String userId, @RequestParam String userEmail) {
		Map<String, Object> result = new HashMap<>();
		ServiceResult serviceResult = service.resetPassword(userId, userEmail);

		result.put("success", serviceResult == ServiceResult.OK);
		if (serviceResult == ServiceResult.OK) {
			result.put("message", "임시 비밀번호가 이메일로 발송되었습니다.");
		} else {
			result.put("message", "일치하는 회원 정보가 없습니다.");
		}

		return result;
	}

	// 일반 회원 회원가입
	@GetMapping("form")
	public String userForm() {
		return "user/user/userForm";
	}

	// 기업 회원 회원가입
	@GetMapping("company/form")
	public String companyForm() {
		return "user/user/companyForm";
	}

	// ID 중복확인 처리
	@PostMapping("checkId")
	@ResponseBody
	public Map<String, Object> checkId(@RequestParam String userId) {
		Map<String, Object> result = new HashMap<>();
		UsersVO user = service.retrieveUser(userId);
		result.put("available", user == null);
		return result;
	}

	// 이메일 인증 메일 발송
	@PostMapping("/sendVerification")
	@ResponseBody
	public Map<String, Object> sendVerificationEmail(@RequestParam String email) {
		Map<String, Object> result = new HashMap<>();
		ServiceResult serviceResult = service.sendVerificationEmail(email);
		result.put("success", serviceResult == ServiceResult.OK);
		if (serviceResult != ServiceResult.OK) {
			result.put("message", "인증 메일 발송에 실패했습니다. 잠시 후 다시 시도해주세요.");
		}
		return result;
	}

	// 이메일 인증 코드 확인
	@PostMapping("/verifyCode")
	@ResponseBody
	public Map<String, Object> verifyCode(@RequestParam String email, @RequestParam String code) {
		Map<String, Object> result = new HashMap<>();
		ServiceResult serviceResult = service.verifyEmail(email, code);
		switch (serviceResult) {
		case OK:
			result.put("success", true);
			break;
		case NOTEXIST:
			result.put("success", false);
			result.put("message", "인증 정보가 존재하지 않습니다. 인증 메일을 다시 발송해주세요.");
			break;
		case INVALIDPASSWORD:
			result.put("success", false);
			result.put("message", "인증 코드가 일치하지 않습니다.");
			break;
		case FAIL:
			result.put("success", false);
			result.put("message", "인증 시간이 만료되었습니다. 인증 메일을 다시 발송해주세요.");
			break;
		default:
			result.put("success", false);
			result.put("message", "인증에 실패했습니다. 잠시 후 다시 시도해주세요.");
			break;
		}
		return result;
	}

	// 일반 회원 회원가입 처리
	@PostMapping
	@ResponseBody
	public Map<String, Object> userInsert(@ModelAttribute UsersVO user) {
		Map<String, Object> result = new HashMap<>();

		try {
			// 입력값 길이 검증
			if (user.getUserId().length() > 20 || user.getUserEmail().length() > 100
					|| user.getUserPassword().length() > 100 || user.getUserAddr1().length() > 200
					|| user.getUserAddr2().length() > 200) {
				result.put("success", false);
				result.put("message", "입력값이 너무 깁니다.");
				return result;
			}

			// 이메일 인증 확인
			if (!service.isEmailVerified(user.getUserEmail())) {
				result.put("success", false);
				result.put("message", "이메일 인증이 필요합니다.");
				return result;
			}

			ServiceResult serviceResult = service.createUser(user);
			result.put("success", serviceResult == ServiceResult.OK);
			if (serviceResult == ServiceResult.PKDUPLICATED) {
				result.put("message", "이미 사용중인 아이디입니다.");
			} else if (serviceResult != ServiceResult.OK) {
				result.put("message", "서버 오류, 잠시후 다시 시도해주세요.");
			}
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", "서버 오류: " + e.getMessage());
		}

		return result;
	}

	// 기업 회원 회원가입 처리
	@PostMapping("/company")
	@ResponseBody
	public Map<String, Object> companyUserInsert(@ModelAttribute CompanyUsersVO companyUser) {
		Map<String, Object> result = new HashMap<>();

		try {
			// 입력값 길이 검증
			if (companyUser.getUserId().length() > 20 || companyUser.getUserEmail().length() > 100
					|| companyUser.getUserPassword().length() > 100 || companyUser.getUserAddr1().length() > 200
					|| companyUser.getUserAddr2().length() > 200) {
				result.put("success", false);
				result.put("message", "입력값이 너무 깁니다.");
				return result;
			}

			// 이메일 인증 확인
			if (!service.isEmailVerified(companyUser.getUserEmail())) {
				result.put("success", false);
				result.put("message", "이메일 인증이 필요합니다.");
				return result;
			}

			// 필수 기업 정보 검증
			if (companyUser.getCompanyName() == null || companyUser.getCompanyName().trim().isEmpty()
					|| companyUser.getUserBsRegistNo() == null || companyUser.getUserBsRegistNo().trim().isEmpty()) {
				result.put("success", false);
				result.put("message", "필수 기업 정보가 누락되었습니다.");
				return result;
			}

			ServiceResult serviceResult = service.createCompanyUser(companyUser);
			result.put("success", serviceResult == ServiceResult.OK);

			if (serviceResult == ServiceResult.PKDUPLICATED) {
				result.put("message", "이미 사용중인 아이디입니다.");
			} else if (serviceResult != ServiceResult.OK) {
				result.put("message", "서버 오류, 잠시후 다시 시도해주세요.");
			}

		} catch (Exception e) {
			result.put("success", false);
			result.put("message", "서버 오류: " + e.getMessage());
		}

		return result;
	}

	// 회원정보 수정 페이지 표시
	@GetMapping("modify/{userId}")
	public String userModifyForm(@PathVariable String userId, Model model) {
		UsersVO user = service.retrieveUser(userId);
		model.addAttribute("user", user);
		return "user/user/userModify";
	}

	// 회원정보 수정 처리
	@PutMapping("{userId}")
	@ResponseBody
	public Map<String, Object> userModify(@PathVariable String userId, @RequestBody UsersVO user) {
		Map<String, Object> result = new HashMap<>();
		user.setUserId(userId);
		ServiceResult serviceResult = service.modifyUser(user);

		result.put("success", serviceResult == ServiceResult.OK);
		if (serviceResult != ServiceResult.OK) {
			result.put("message", "서버 오류, 잠시후 다시 시도해주세요.");
		}

		return result;
	}

	// 회원 탈퇴 처리
	@DeleteMapping("{userId}")
	@ResponseBody
	public Map<String, Object> userDelete(@PathVariable String userId) {
		Map<String, Object> result = new HashMap<>();
		ServiceResult serviceResult = service.removeUser(userId);

		result.put("success", serviceResult == ServiceResult.OK);
		if (serviceResult != ServiceResult.OK) {
			result.put("message", "서버 오류, 잠시후 다시 시도해주세요.");
		}

		return result;
	}
}