<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>    
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/index/index.css" />
      
      
        <div class="bg-holder bg-holder overlay bg-opacity-50" style="background-image:url(../../assets/video/travel.png);">
          <video class="bg-video" autoplay="autoplay" loop="loop" muted="muted" playsinline="playsinline">
            <source src="${pageContext.request.contextPath }/resources/phoenix-v1.20.1/public/assets/video/3255275-uhd_3840_2160_25fps.mp4" type="video/mp4" />
            											
           
          </video>
        </div>
        <!--/.bg-holder-->
        <div class="container-medium position-relative z-5">
          <h2 class="text-secondary-lighter fs-5 fs-md-3 fw-normal mb-3">Welcome</h2>
          <h1 class="fs-4 fs-md-1 text-white fw-normal mb-6 overflow-hidden"> ProjectMapper <span class="typed-text"></span></h1>
          <a class="btn custom-btn me-3" href="${pageContext.request.contextPath }/users/user/login"><i class="fas fa-sign-in-alt"></i> Sign in</a>
          <!-- Sign up 버튼을 모달 트리거로 변경 -->
          <a class="btn custom-btn" href="#" data-bs-toggle="modal" data-bs-target="#signupModal"><i class="fas fa-user-plus"></i> Sign up</a>
        </div>
      
        <!-- 회원가입 선택 모달 -->
        <div class="modal fade" id="signupModal" tabindex="-1" aria-labelledby="signupModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="signupModalLabel">회원가입 유형 선택</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="d-grid gap-3">
                            <button type="button" class="btn btn-lg btn-primary" onclick="location.href='${pageContext.request.contextPath}/users/user/form'">
                                <i class="fas fa-user me-2"></i>일반회원 가입
                            </button>
                            <button type="button" class="btn btn-lg btn-secondary" onclick="location.href='${pageContext.request.contextPath}/users/user/company/form'">
                                <i class="fas fa-building me-2"></i>기업회원 가입
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>