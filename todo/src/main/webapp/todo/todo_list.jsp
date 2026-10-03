<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%--
    isELIgnored="true" 주의:
    jquery.tmpl 템플릿 문법 ${title} 이 JSP EL 문법과 똑같아서,
    EL을 끄지 않으면 JSP가 서버에서 먼저 ${title}을 빈 값으로 바꿔 버린다.
    그래서 이 페이지는 EL을 끄고, 컨텍스트 경로는 스크립틀릿(<%= ctx %>)으로 넣는다.
--%>
<%@ page isELIgnored="true" %>
<%
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<title>TODO - 목록</title>
<link rel="stylesheet" href="<%= ctx %>/todo/css/todo.css">
<script src="<%= ctx %>/js/jquery-3.7.1.min.js"></script>
<script src="<%= ctx %>/js/jquery.tmpl.min.js"></script>
<script>var CTX = "<%= ctx %>";</script>
<script src="<%= ctx %>/todo/js/todo-common.js"></script>
</head>
<body>
<div class="app">
    <header class="app-header">
        <span style="width:40px"></span>
        <h1>나의 TODO</h1>
        <button type="button" id="btnLogout" class="btn-text">로그아웃</button>
    </header>

    <!-- 요약 카드 -->
    <section class="summary">
        <p class="hello"><span id="userName"></span>님, 안녕하세요 👋</p>
        <p class="count">남은 할 일 <span id="remainCount">0</span>개</p>
        <div class="bar"><i id="doneBar" style="width:0%"></i></div>
    </section>

    <!-- 필터 탭 -->
    <nav class="tabs">
        <button type="button" class="active" data-filter="all">전체</button>
        <button type="button" data-filter="todo">진행중</button>
        <button type="button" data-filter="done">완료</button>
    </nav>

    <!-- 목록이 그려질 자리 -->
    <ul id="todoList" class="todo-list">
        <li class="loading">불러오는 중...</li>
    </ul>

    <button type="button" class="fab" id="btnAdd" title="할 일 추가">+</button>
</div>

<!--
    jquery.tmpl 템플릿
    - ${필드명} : 값 출력 (HTML 자동 이스케이프)
    - {{if 조건}} ... {{else}} ... {{/if}} : 조건 처리
    - $item.함수() : tmpl() 호출 시 넘긴 옵션 객체의 함수 사용
-->
<script id="todoItemTmpl" type="text/x-jquery-tmpl">
    <li class="todo-item {{if done}}done{{/if}}" data-done="${done}">
        <span class="check">{{if done}}✓{{/if}}</span>
        <div class="body">
            <p class="title">${title}</p>
            {{if content}}<p class="content">${content}</p>{{/if}}
            <p class="meta">
                <span class="badge ${priority}">${$item.priorityName(priority)}</span>
                {{if dueDate}}<span>마감 ${dueDate}</span>{{/if}}
                <span>등록 ${regDate}</span>
            </p>
        </div>
    </li>
</script>

<script id="emptyTmpl" type="text/x-jquery-tmpl">
    <li class="empty">${message}</li>
</script>

<script>
$(function () {
    var allList = [];

    // TODOListController(/api/todo/list) 호출
    Todo.ajax("/api/todo/list", "GET", null, function (res) {
        $("#userName").text(res.userName);
        allList = res.list;
        renderSummary();
        renderList("all");
    });

    // 요약 카드: 남은 개수, 완료 비율
    function renderSummary() {
        var doneCnt = $.grep(allList, function (t) { return t.done; }).length;
        $("#remainCount").text(allList.length - doneCnt);
        $("#doneBar").css("width", allList.length ? (doneCnt / allList.length * 100) + "%" : "0%");
    }

    // 목록 그리기: 받은 JSON 배열을 템플릿에 넣어서 한 번에 그린다
    function renderList(filter) {
        var list = $.grep(allList, function (t) {
            if (filter === "todo") return !t.done;
            if (filter === "done") return t.done;
            return true;
        });

        var $ul = $("#todoList").empty();
        if (list.length === 0) {
            $("#emptyTmpl").tmpl({ message: "표시할 할 일이 없습니다." }).appendTo($ul);
            return;
        }
        // 두 번째 인자로 넘긴 객체는 템플릿 안에서 $item 으로 접근한다
        $("#todoItemTmpl").tmpl(list, { priorityName: Todo.priorityName }).appendTo($ul);
    }

    // 필터 탭
    $(".tabs button").on("click", function () {
        $(".tabs button").removeClass("active");
        $(this).addClass("active");
        renderList($(this).data("filter"));
    });

    // 추가 화면으로
    $("#btnAdd").on("click", function () {
        location.href = CTX + "/todo/todo_add.jsp";
    });

    // 로그아웃
    $("#btnLogout").on("click", function () {
        Todo.ajax("/api/logout", "POST", null, function () {
            location.href = CTX + "/todo/todo_login.jsp";
        });
    });
});
</script>
</body>
</html>
