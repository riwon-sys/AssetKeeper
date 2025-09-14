AssetKeeper — 자산(비품) 관리 웹앱 (JSP/Servlet/MVC)

AssetKeeper는 회사/개인용 비품(자산) 목록을 등록·수정·삭제·조회(CRUD)하고,
대여/반납, 수리 이력, 위치/상태를 관리하는 경량 JSP/Servlet 기반 웹 애플리케이션입니다.

✨ 주요 기능

자산 관리: 자산 등록/수정/삭제, 검색(이름/태그/상태), 페이징

대여/반납: 사용자에게 자산 대여, 반납 처리, 연체 표시

수리 이력: 고장/수리 이력 기록, 비용/업체 메모

기본 통계: 총 자산 수, 가용/대여중/폐기 수량

권한(옵션): 간단한 로그인(Session) + 관리자/일반 사용자 분리

순수 MVC: Controller(서블릿) → Service → DAO(JDBC) → MySQL

🏗 아키텍처 개요
브라우저
  │  (HTTP)
  ▼
[Servlet Controller]  →  [Service]  →  [DAO(JDBC)]  →  [MySQL]
        │                       │
        └────────> [JSP(View)] <┘   (JSTL/EL)

📂 디렉토리 구조(예시)
assetkeeper/
├─ pom.xml
├─ src
│  ├─ main
│  │  ├─ java/com/assetkeeper
│  │  │  ├─ controller
│  │  │  │  ├─ AssetListController.java
│  │  │  │  ├─ AssetCreateController.java
│  │  │  │  ├─ AssetUpdateController.java
│  │  │  │  ├─ AssetDeleteController.java
│  │  │  │  ├─ RentalController.java        // 대여/반납
│  │  │  │  └─ AuthController.java          // (옵션) 로그인
│  │  │  ├─ service
│  │  │  │  └─ AssetService.java
│  │  │  ├─ dao
│  │  │  │  └─ AssetDao.java
│  │  │  ├─ model
│  │  │  │  ├─ Asset.java
│  │  │  │  ├─ Rental.java
│  │  │  │  └─ RepairLog.java
│  │  │  └─ util
│  │  │     └─ DBUtil.java
│  │  ├─ resources
│  │  │  └─ db.properties                  // DB 연결설정
│  │  └─ webapp
│  │     ├─ WEB-INF
│  │     │  ├─ views
│  │     │  │  ├─ asset
│  │     │  │  │  ├─ list.jsp
│  │     │  │  │  ├─ form.jsp
│  │     │  │  │  └─ detail.jsp
│  │     │  │  └─ auth
│  │     │  │     └─ login.jsp
│  │     │  └─ web.xml
│  │     ├─ assets
│  │     │  ├─ css/style.css
│  │     │  └─ js/app.js
│  │     └─ index.jsp                      // 대시보드
└─ README.md

🚀 빠른 시작
0) 사전 준비

Java 11+, Maven 3.8+

MySQL 8.0, (선택) Tomcat 9/10 또는 Jetty

1) 데이터베이스 생성 & 샘플 데이터
-- DB & 사용자
CREATE DATABASE assetkeeper CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER 'asset'@'%' IDENTIFIED BY 'assetpass';
GRANT ALL PRIVILEGES ON assetkeeper.* TO 'asset'@'%';
FLUSH PRIVILEGES;

USE assetkeeper;

-- 자산(비품)
CREATE TABLE assets (
  id           BIGINT PRIMARY KEY AUTO_INCREMENT,
  name         VARCHAR(100) NOT NULL,
  category     VARCHAR(50)  NOT NULL,
  serial_no    VARCHAR(100) UNIQUE,
  location     VARCHAR(100),
  status       ENUM('AVAILABLE','RENTED','REPAIR','DISPOSED') DEFAULT 'AVAILABLE',
  price        DECIMAL(12,2),
  purchased_at DATE,
  note         TEXT,
  created_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 대여
CREATE TABLE rentals (
  id           BIGINT PRIMARY KEY AUTO_INCREMENT,
  asset_id     BIGINT NOT NULL,
  renter_name  VARCHAR(50) NOT NULL,
  rented_at    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  due_at       DATETIME,
  returned_at  DATETIME,
  note         TEXT,
  CONSTRAINT fk_rentals_asset FOREIGN KEY (asset_id) REFERENCES assets(id)
);

-- 수리 이력
CREATE TABLE repair_logs (
  id           BIGINT PRIMARY KEY AUTO_INCREMENT,
  asset_id     BIGINT NOT NULL,
  title        VARCHAR(100) NOT NULL,
  vendor       VARCHAR(100),
  cost         DECIMAL(12,2),
  started_at   DATE,
  finished_at  DATE,
  memo         TEXT,
  CONSTRAINT fk_repairs_asset FOREIGN KEY (asset_id) REFERENCES assets(id)
);

-- (선택) 사용자/권한
CREATE TABLE users (
  id         BIGINT PRIMARY KEY AUTO_INCREMENT,
  email      VARCHAR(120) UNIQUE NOT NULL,
  password   VARCHAR(200) NOT NULL, -- 단순학습용 평문/sha256 권장
  role       ENUM('ADMIN','USER') DEFAULT 'USER',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 샘플 데이터
INSERT INTO assets(name, category, serial_no, location, status, price, purchased_at, note) VALUES
('맥북 프로 14', '노트북', 'MBP14-001', '본사-1층 IT실', 'AVAILABLE', 2900000, '2023-08-10', '개발자용'),
('델 모니터 27', '모니터', 'DEL27-101', '본사-2층 QA', 'RENTED', 380000, '2024-02-01', 'QA팀 대여중'),
('HP 프린터 2040', '프린터', 'HP-PR-2040', '본사-3층 공용', 'REPAIR', 120000, '2022-09-18', '토너 이슈');

INSERT INTO users(email, password, role) VALUES
('admin@example.com','admin123','ADMIN'),
('user@example.com','user123','USER');

2) DB 연결 설정

src/main/resources/db.properties

db.url=jdbc:mysql://localhost:3306/assetkeeper?useSSL=false&serverTimezone=Asia/Seoul&characterEncoding=utf8
db.user=asset
db.pass=assetpass

3) 빌드 & 실행

Maven 빌드

mvn clean package


Tomcat 배포

생성된 target/assetkeeper.war를 Tomcat webapps/에 복사

Tomcat 기동 후 http://localhost:8080/assetkeeper/ 접속

Jetty(플러그인)로 실행(옵션)

mvn jetty:run
# http://localhost:8080/ 로 접속

⚙️ pom.xml (핵심 의존성 예시)
<project>
  <modelVersion>4.0.0</modelVersion>
  <groupId>com.assetkeeper</groupId>
  <artifactId>assetkeeper</artifactId>
  <version>1.0.0</version>
  <packaging>war</packaging>

  <properties>
    <maven.compiler.source>11</maven.compiler.source>
    <maven.compiler.target>11</maven.compiler.target>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    <jstl.version>1.2</jstl.version>
  </properties>

  <dependencies>
    <!-- Servlet/JSP/JSTL -->
    <dependency>
      <groupId>jakarta.servlet</groupId>
      <artifactId>jakarta.servlet-api</artifactId>
      <version>5.0.0</version>
      <scope>provided</scope>
    </dependency>
    <dependency>
      <groupId>javax.servlet</groupId>
      <artifactId>jstl</artifactId>
      <version>${jstl.version}</version>
    </dependency>

    <!-- JDBC -->
    <dependency>
      <groupId>mysql</groupId>
      <artifactId>mysql-connector-java</artifactId>
      <version>8.0.33</version>
    </dependency>

    <!-- (옵션) 로깅 -->
    <dependency>
      <groupId>org.slf4j</groupId>
      <artifactId>slf4j-simple</artifactId>
      <version>2.0.12</version>
    </dependency>
  </dependencies>

  <build>
    <finalName>assetkeeper</finalName>
    <plugins>
      <!-- JSP 컴파일 등 기본 빌드 플러그인 생략 가능 -->
    </plugins>
  </build>
</project>

🧭 web.xml (서블릿 매핑 예시)
<web-app xmlns="https://jakarta.ee/xml/ns/jakartaee"
         version="5.0">
  <display-name>AssetKeeper</display-name>

  <!-- 인덱스 -->
  <welcome-file-list>
    <welcome-file>index.jsp</welcome-file>
  </welcome-file-list>

  <!-- 자산 목록 -->
  <servlet>
    <servlet-name>AssetListController</servlet-name>
    <servlet-class>com.assetkeeper.controller.AssetListController</servlet-class>
  </servlet>
  <servlet-mapping>
    <servlet-name>AssetListController</servlet-name>
    <url-pattern>/assets</url-pattern>
  </servlet-mapping>

  <!-- 등록/수정/삭제/대여 -->
  <servlet>
    <servlet-name>AssetCreateController</servlet-name>
    <servlet-class>com.assetkeeper.controller.AssetCreateController</servlet-class>
  </servlet>
  <servlet-mapping>
    <servlet-name>AssetCreateController</servlet-name>
    <url-pattern>/assets/create</url-pattern>
  </servlet-mapping>

  <servlet>
    <servlet-name>AssetUpdateController</servlet-name>
    <servlet-class>com.assetkeeper.controller.AssetUpdateController</servlet-class>
  </servlet>
  <servlet-mapping>
    <servlet-name>AssetUpdateController</servlet-name>
    <url-pattern>/assets/update</url-pattern>
  </servlet-mapping>

  <servlet>
    <servlet-name>AssetDeleteController</servlet-name>
    <servlet-class>com.assetkeeper.controller.AssetDeleteController</servlet-class>
  </servlet>
  <servlet-mapping>
    <servlet-name>AssetDeleteController</servlet-name>
    <url-pattern>/assets/delete</url-pattern>
  </servlet-mapping>

  <servlet>
    <servlet-name>RentalController</servlet-name>
    <servlet-class>com.assetkeeper.controller.RentalController</servlet-class>
  </servlet>
  <servlet-mapping>
    <servlet-name>RentalController</servlet-name>
    <url-pattern>/rentals/*</url-pattern>
  </servlet-mapping>
</web.xml>

🔌 DB 연결 유틸 (예시)
// com.assetkeeper.util.DBUtil.java
package com.assetkeeper.util;

import java.sql.*;
import java.util.Properties;

public class DBUtil {
    private static String URL;
    private static String USER;
    private static String PASS;

    static {
        try {
            Properties p = new Properties();
            p.load(DBUtil.class.getResourceAsStream("/db.properties"));
            URL  = p.getProperty("db.url");
            USER = p.getProperty("db.user");
            PASS = p.getProperty("db.pass");
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (Exception e) { throw new RuntimeException(e); }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASS);
    }
}

🧪 기능 플로우(요약)

목록: GET /assets?page=&size=&q= → list.jsp에 전달 (JSTL로 반복 렌더)

등록: GET /assets/create 폼 / POST /assets/create 처리 → 목록 리다이렉트

수정: GET /assets/update?id= 폼 / POST /assets/update

삭제: POST /assets/delete (id 파라미터)

대여: POST /rentals/create (asset_id, renter, due_at) → 상태 RENTED

반납: POST /rentals/return (rental_id) → returned_at 기록 + 자산 상태 복귀

🖼 UI (JSP) 팁

JSTL/EL 사용: <c:forEach>, ${asset.name}

공통 레이아웃: header.jspf, footer.jspf 분리 후 jsp:include

폼 검증: HTML5 required, 서버단 재검증

🛡 트러블슈팅

JSP 404/EL 미동작: 컨테이너 버전/JSP 라이브러리 확인(서블릿 5+에서는 JSTL 의존성 필요)

한글 깨짐: URIEncoding=UTF-8 (Tomcat), <%@ page contentType="text/html; charset=UTF-8" %>

DB 연결 오류: db.properties/방화벽/계정권한, JDBC URL의 serverTimezone/characterEncoding 확인

Foreign Key 제약: 대여/수리 이력 삭제 순서 주의(이력→자산)

🗺 로드맵(선택)

 엑셀/CSV 내보내기

 이미지 업로드(영수증/자산사진)

 로그인 암호 해시(BCrypt) & 권한별 메뉴 제어

 태그/바코드/QR 라벨링

 REST API 모드(차후 스프링 전환 대비)

📜 라이선스

MIT License — 자유롭게 사용/수정/배포 가능.

👤 Maintainer

김리원 (풀스택 · QA/QC)
이슈/건의사항은 GitHub Issues로 남겨주세요.
