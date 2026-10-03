<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<title>TODO - 로그인</title>
<link rel="stylesheet" href="<%= ctx %>/todo/css/todo.css">
<script src="<%= ctx %>/js/jquery-3.7.1.min.js"></script>
<script>var CTX = "<%= ctx %>";</script>
<script src="<%= ctx %>/todo/js/todo-common.js"></script>
</head>
<body>
<div class="app">
    <div class="login-wrap">
        <div class="login-logo">✓</div>
        <h2 class="login-title">TODO</h2>
        <p class="login-sub">오늘 할 일을 한눈에 관리하세요</p>

        <form id="loginForm" autocomplete="off">
            <div class="field">
                <label for="userId">아이디</label>
                <input type="text" id="userId" name="userId" placeholder="아이디를 입력하세요">
            </div>
            <div class="field">
                <label for="password">비밀번호</label>
                <input type="password" id="password" name="password" placeholder="비밀번호를 입력하세요">
            </div>
            <p id="loginMsg" class="msg-error"></p>
            <button type="submit" id="btnLogin" class="btn-primary">로그인</button>
        </form>
    </div>
</div>

<script>
$(function () {
    $("#userId").focus();

    $("#loginForm").on("submit", function (e) {
        e.preventDefault();

        var userId = $.trim($("#userId").val());
        var password = $("#password").val();

        if (userId === "") {
            $("#loginMsg").text("아이디를 입력해 주세요.");
            $("#userId").focus();
            return;
        }
        if (password === "") {
            $("#loginMsg").text("비밀번호를 입력해 주세요.");
            $("#password").focus();
            return;
        }

        $("#btnLogin").prop("disabled", true);

        // LoginController(/api/login) 호출
        Todo.ajax("/api/login", "POST", { userId: userId, password: password }, function (res) {
            $("#btnLogin").prop("disabled", false);

            if (res.result === "success") {
                location.href = CTX + "/todo/todo_list.jsp";
            } else {
                $("#loginMsg").text(res.message);
                $("#password").val("").focus();
            }
        });
    });
});
</script>
</body>
</html>
