package com.todo.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import jakarta.servlet.http.HttpSession;

/**
 * 로그인 / 로그아웃 처리.
 * DB 없이 아이디·비밀번호를 하드코딩으로 비교하고, 맞으면 세션에 사용자 정보를 저장한다.
 */
@RestController
public class LoginController {

    /** 세션에 로그인 사용자 이름을 저장하는 키 (다른 컨트롤러에서 로그인 여부 확인에 사용) */
    public static final String SESSION_USER = "LOGIN_USER_NAME";

    // 연습용 하드코딩 계정
    private static final String LOGIN_ID = "todo";
    private static final String LOGIN_PW = "1234";
    private static final String USER_NAME = "홍길동";

    /**
     * 요청: POST /api/login  (userId, password)
     * 응답: {"result":"success","userName":"홍길동"} 또는 {"result":"fail","message":"..."}
     */
    @PostMapping("/api/login")
    public Map<String, Object> login(@RequestParam(defaultValue = "") String userId,
                                     @RequestParam(defaultValue = "") String password,
                                     HttpSession session) {
        Map<String, Object> res = new HashMap<>();

        if (LOGIN_ID.equals(userId.trim()) && LOGIN_PW.equals(password)) {
            session.setAttribute(SESSION_USER, USER_NAME);
            res.put("result", "success");
            res.put("userName", USER_NAME);
        } else {
            res.put("result", "fail");
            res.put("message", "아이디 또는 비밀번호가 올바르지 않습니다.");
        }
        return res;
    }

    /**
     * 요청: POST /api/logout
     * 응답: {"result":"success"}
     */
    @PostMapping("/api/logout")
    public Map<String, Object> logout(HttpSession session) {
        session.invalidate();
        Map<String, Object> res = new HashMap<>();
        res.put("result", "success");
        return res;
    }
}
