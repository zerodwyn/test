/**
 * TODO 앱 공통 스크립트
 * - CTX: 컨텍스트 경로 (각 JSP에서 window.CTX로 넣어 준다)
 */
var Todo = {

    /** 서버 호출 공통 함수. 로그인이 풀렸으면 로그인 화면으로 보낸다. */
    ajax: function (url, method, data, onSuccess) {
        $.ajax({
            url: CTX + url,
            type: method,
            data: data,
            dataType: "json",
            success: function (res) {
                if (res.result === "no_session") {
                    alert("로그인이 필요합니다.");
                    location.href = CTX + "/todo/todo_login.jsp";
                    return;
                }
                onSuccess(res);
            },
            error: function (xhr) {
                Todo.toast("서버 통신 오류 (" + xhr.status + ")");
            }
        });
    },

    /** 화면 아래 잠깐 보였다 사라지는 메시지 */
    toast: function (msg) {
        var $t = $("#toast");
        if ($t.length === 0) {
            $t = $('<div id="toast" class="toast"></div>').appendTo("body");
        }
        $t.text(msg).stop(true, true).fadeIn(150).delay(1500).fadeOut(300);
    },

    /** 우선순위 코드 -> 화면 표시 이름 */
    priorityName: function (code) {
        return { HIGH: "높음", NORMAL: "보통", LOW: "낮음" }[code] || code;
    }
};
