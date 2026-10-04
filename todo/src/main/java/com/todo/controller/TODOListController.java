package com.todo.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.todo.model.Todo;
import com.todo.store.TodoStore;

import jakarta.servlet.http.HttpSession;

/**
 * TODO 목록 조회.
 */
@RestController
public class TODOListController {

    private final TodoStore todoStore;

    public TODOListController(TodoStore todoStore) {
        this.todoStore = todoStore;
    }

    /**
     * 요청: GET /api/todo/list
     * 응답: {"result":"success","userName":"홍길동","count":4,"list":[{...}, ...]}
     *       로그인 안 했으면 {"result":"no_session"}
     */
    @GetMapping("/api/todo/list")
    public Map<String, Object> list(HttpSession session) {
        Map<String, Object> res = new HashMap<>();

        Object userName = session.getAttribute(LoginController.SESSION_USER);
        if (userName == null) {
            res.put("result", "no_session");
            return res;
        }

        List<Todo> list = todoStore.findAll();
        res.put("result", "success");
        res.put("userName", userName);
        res.put("count", list.size());
        res.put("list", list);
        return res;
    }
}
