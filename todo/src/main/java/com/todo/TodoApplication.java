package com.todo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

/**
 * TODO 앱 시작 클래스.
 * - STS: Boot Dashboard에서 todo 실행 (또는 이 파일 우클릭 > Run As > Spring Boot App)
 * - 명령줄: mvnw spring-boot:run
 * 실행 후 http://localhost:8080/todo/todo_login.jsp
 */
@SpringBootApplication
public class TodoApplication extends SpringBootServletInitializer {

    public static void main(String[] args) {
        SpringApplication.run(TodoApplication.class, args);
    }

    // 외부 WAS(톰캣 등)에 war로 배포할 때 사용
    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
        return builder.sources(TodoApplication.class);
    }
}
