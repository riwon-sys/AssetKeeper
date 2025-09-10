AssetKeeper 🗂️

Java · JSP 기반의 개인 프로젝트 (MVC 패턴, CRUD 실습)

📌 프로젝트 개요

AssetKeeper는 자산(비품) 관리 기능을 실습하기 위해 설계한 웹 애플리케이션입니다. Java와 JSP를 활용하여 CRUD(생성, 조회, 수정, 삭제) 기능을 직접 구현했고, MVC 아키텍처를 적용하여 백엔드와 프론트엔드의 흐름을 구조적으로 나누는 경험을 쌓았습니다.

🛠️ 기술 스택

언어: Java (JDK 17), JSP

DB: MySQL 8.x

아키텍처: MVC (Model-View-Controller)

빌드 도구: Apache Tomcat (서버 실행), Maven/Gradle(선택)

IDE: IntelliJ IDEA / Eclipse

📂 주요 기능

CRUD 기능

자산 등록(Create)

자산 목록 조회(Read)

자산 정보 수정(Update)

자산 삭제(Delete)

MVC 패턴 학습

Controller: 요청(Request) 처리 및 비즈니스 로직 분기

DAO (Data Access Object): DB 연동 및 SQL 실행

View (JSP): 화면단 렌더링

DB 설계부터 화면 연동까지 전 과정 경험

🔄 흐름 구조 사용자 요청 → Controller → DAO → DB → 결과 반환 → JSP(View)

📑 학습 포인트

Java·JSP 기반의 전통적인 웹 구조를 직접 구현

MVC 아키텍처의 장점(관심사 분리) 과 단점(복잡성 증가) 체감

DB 설계, SQL 작성, JSP 화면 구성까지 Full-stack 개발 전 과정 경험

실무에 가까운 CRUD 프로젝트 플로우를 경험하며 웹 개발 기초 감각 향상

🚀 실행 방법

MySQL에서 DB 및 테이블 생성 후 샘플 데이터 삽입

application.properties 또는 DB 설정 파일에서 DB 연결정보 수정

Tomcat 서버 실행 후 브라우저에서 접속

http://localhost:8080/assetkeeper

📸 화면 예시

추후 화면 캡처 추가 (목록, 등록/수정 폼, 상세 조회 화면 등)

🧑‍💻 개발자

김리원 (개인 프로젝트)
