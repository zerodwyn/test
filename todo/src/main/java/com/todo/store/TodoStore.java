package com.todo.store;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;

import org.springframework.stereotype.Component;

import com.todo.model.Todo;

/**
 * DB 대신 서버 메모리에 TODO를 들고 있는 임시 저장소.
 * 시작할 때 하드코딩 데이터를 넣어 두고, 추가한 데이터는 서버를 재시작하면 사라진다.
 */
@Component
public class TodoStore {

    private final List<Todo> todos = new ArrayList<>();
    private final AtomicInteger seq = new AtomicInteger(0);

    public TodoStore() {
        add(new Todo(0, "주간 업무 보고서 작성", "금요일 오전까지 팀장님께 제출", "HIGH", false, "2026-10-09", "2026-10-01"));
        add(new Todo(0, "운영 서버 로그 점검", "지난주 에러 로그 정리", "NORMAL", false, "2026-10-06", "2026-10-02"));
        add(new Todo(0, "Git 브랜치 전략 공부", "main / dev / 작업 브랜치 흐름 익히기", "NORMAL", true, "", "2026-10-02"));
        add(new Todo(0, "회의실 예약", "다음주 화요일 14시, 6인", "LOW", false, "2026-10-07", "2026-10-03"));
    }

    /** 최신 등록 순(번호 내림차순)으로 복사본을 돌려준다. */
    public synchronized List<Todo> findAll() {
        List<Todo> result = new ArrayList<>(todos);
        result.sort((a, b) -> b.getNo() - a.getNo());
        return result;
    }

    /** 번호와 등록일을 채워서 저장한다. */
    public synchronized Todo add(Todo todo) {
        todo.setNo(seq.incrementAndGet());
        if (todo.getRegDate() == null || todo.getRegDate().isEmpty()) {
            todo.setRegDate(LocalDate.now().toString());
        }
        todos.add(todo);
        return todo;
    }
}
