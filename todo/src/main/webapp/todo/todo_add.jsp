<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%-- jquery.tmpl의 ${...} 문법과 겹치지 않게 EL을 끈다 (todo_list.jsp 설명 참고) --%>
<%@ page isELIgnored="true" %>
<%
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<title>TODO - 추가</title>
<link rel="stylesheet" href="<%= ctx %>/todo/css/todo.css">
<script src="<%= ctx %>/js/jquery-3.7.1.min.js"></script>
<script src="<%= ctx %>/js/jquery.tmpl.min.js"></script>
<script>var CTX = "<%= ctx %>";</script>
<script src="<%= ctx %>/todo/js/todo-common.js"></script>
</head>
<body>
<div class="app">
    <header class="app-header">
        <button type="button" id="btnBack" class="btn-icon" title="뒤로">‹</button>
        <h1>할 일 추가</h1>
        <span style="width:40px"></span>
    </header>

    <form id="addForm" class="form-wrap" autocomplete="off">
        <div class="field">
            <label for="title">제목</label>
            <input type="text" id="title" name="title" maxlength="50" placeholder="할 일을 입력하세요">
            <p class="hint"><span id="titleLen">0</span> / 50</p>
        </div>

        <div class="field">
            <label for="content">메모</label>
            <textarea id="content" name="content" placeholder="자세한 내용을 적어 두세요 (선택)"></textarea>
        </div>

        <div class="field">
            <label>우선순위</label>
            <!-- 우선순위 버튼은 템플릿으로 그린다 -->
            <div id="prioritySegment" class="segment"></div>
        </div>

        <div class="field">
            <label for="dueDate">마감일</label>
            <input type="date" id="dueDate" name="dueDate">
        </div>

        <p id="addMsg" class="msg-error"></p>
        <button type="submit" id="btnSave" class="btn-primary">저장</button>
    </form>
</div>

<script id="priorityTmpl" type="text/x-jquery-tmpl">
    <label class="{{if checked}}on-${code}{{/if}}">
        <input type="radio" name="priority" value="${code}" {{if checked}}checked{{/if}}>
        <span>${name}</span>
    </label>
</script>

<script>
$(function () {
    // 우선순위 선택 버튼 (기본값: 보통)
    var priorities = [
        { code: "HIGH",   name: "높음", checked: false },
        { code: "NORMAL", name: "보통", checked: true  },
        { code: "LOW",    name: "낮음", checked: false }
    ];
    $("#priorityTmpl").tmpl(priorities).appendTo("#prioritySegment");

    $("#prioritySegment").on("change", "input", function () {
        $("#prioritySegment label").attr("class", "");
        $(this).closest("label").addClass("on-" + this.value);
    });

    // 제목 글자 수
    $("#title").on("input", function () {
        $("#titleLen").text(this.value.length);
    }).focus();

    $("#btnBack").on("click", function () {
        location.href = CTX + "/todo/todo_list.jsp";
    });

    $("#addForm").on("submit", function (e) {
        e.preventDefault();

        if ($.trim($("#title").val()) === "") {
            $("#addMsg").text("제목을 입력해 주세요.");
            $("#title").focus();
            return;
        }

        $("#btnSave").prop("disabled", true);

        // TODOAddController(/api/todo/add) 호출 - 폼 값을 그대로 보낸다
        Todo.ajax("/api/todo/add", "POST", $(this).serialize(), function (res) {
            if (res.result === "success") {
                Todo.toast("'" + res.item.title + "' 추가되었습니다.");
                setTimeout(function () {
                    location.href = CTX + "/todo/todo_list.jsp";
                }, 800);
            } else {
                $("#btnSave").prop("disabled", false);
                $("#addMsg").text(res.message);
            }
        });
    });
});
</script>
</body>
</html>
