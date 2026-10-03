package com.todo.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.todo.model.Todo;
import com.todo.store.TodoStore;

import jakarta.servlet.http.HttpSession;

/**
 * TODO 추가.
 */
@RestController
public class TODOAddController {

    private final TodoStore todoStore;

    public TODOAddController(TodoStore todoStore) {
        this.todoStore = todoStore;
    }

    /**
     * 요청: POST /api/todo/add  (title, content, priority, dueDate)
     * 응답: {"result":"success","item":{...}}
     *       입력 오류면 {"result":"fail","message":"..."}, 로그인 안 했으면 {"result":"no_session"}
     */
    @PostMapping("/api/todo/add")
    public Map<String, Object> add(@RequestParam(defaultValue = "") String title,
                                   @RequestParam(defaultValue = "") String content,
                                   @RequestParam(defaultValue = "NORMAL") String priority,
                                   @RequestParam(defaultValue = "") String dueDate,
                                   HttpSession session) {
        Map<String, Object> res = new HashMap<>();

        if (session.getAttribute(LoginController.SESSION_USER) == null) {
            res.put("result", "no_session");
            return res;
        }

        title = title.trim();
        if (title.isEmpty()) {
            res.put("result", "fail");
            res.put("message", "제목을 입력해 주세요.");
            return res;
        }
        if (title.length() > 50) {
            res.put("result", "fail");
            res.put("message", "제목은 50자까지 입력할 수 있습니다.");
            return res;
        }
        if (!priority.equals("HIGH") && !priority.equals("NORMAL") && !priority.equals("LOW")) {
            priority = "NORMAL";
        }

        Todo saved = todoStore.add(new Todo(0, title, content.trim(), priority, false, dueDate, null));
        res.put("result", "success");
        res.put("item", saved);
        return res;
    }
}
