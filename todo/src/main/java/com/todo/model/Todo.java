package com.todo.model;

/**
 * TODO 한 건. JSON으로 내려갈 때 필드 이름이 그대로 키가 된다.
 * 예) {"no":1,"title":"...","content":"...","priority":"HIGH","done":false,"dueDate":"2026-10-10","regDate":"2026-10-01"}
 */
public class Todo {

    private int no;
    private String title;
    private String content;
    private String priority;   // HIGH / NORMAL / LOW
    private boolean done;
    private String dueDate;    // yyyy-MM-dd, 없으면 빈 문자열
    private String regDate;    // yyyy-MM-dd

    public Todo() {
    }

    public Todo(int no, String title, String content, String priority, boolean done, String dueDate, String regDate) {
        this.no = no;
        this.title = title;
        this.content = content;
        this.priority = priority;
        this.done = done;
        this.dueDate = dueDate;
        this.regDate = regDate;
    }

    public int getNo() { return no; }
    public void setNo(int no) { this.no = no; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public String getPriority() { return priority; }
    public void setPriority(String priority) { this.priority = priority; }

    public boolean isDone() { return done; }
    public void setDone(boolean done) { this.done = done; }

    public String getDueDate() { return dueDate; }
    public void setDueDate(String dueDate) { this.dueDate = dueDate; }

    public String getRegDate() { return regDate; }
    public void setRegDate(String regDate) { this.regDate = regDate; }
}
