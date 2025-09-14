# AssetKeeper

**Java · JSP · MVC · MySQL 기반 비품(자산) 관리 웹 애플리케이션**  
비품 등록/조회/수정/삭제(CRUD) 기능을 중심으로,  
요청 → Controller → DAO → DB 연동의 **MVC 구조 전 과정**을 직접 설계·구현했습니다.  

---

## 📌 프로젝트 개요
- **제작기간**: 2025-02-03 ~ 2025-02-23  
- **핵심 목표**: Controller → DAO → DB CRUD 플로우 정립, MVC 패턴 적용  
- **역할**:  
  - DB 스키마 설계 및 SQL 작성  
  - DAO 계층 & JSP 화면 연동  
  - 전체 기능 단독 구현  

---

## 🔑 기술 스택
- **Backend**: Java (Servlet, JSP), JDBC, DAO 패턴  
- **Database**: MySQL, JNDI DataSource(커넥션 풀)  
- **Frontend**: JSP, HTML, CSS  
- **Etc.**: MVC 아키텍처 설계, 유효성 검증 로직  

---

## ⚙️ 주요 기능
- **비품 관리 CRUD**  
  - 비품 등록 / 조회 / 수정 / 삭제  
  - 자산명, 분류, 수량, 사용여부 등 관리  
- **DB 설계 및 연동**  
  - JDBC → JNDI Connection Pool 전환  
- **MVC 구조 적용**  
  - Controller → DAO → DTO → JSP 흐름 정립  

---

## 🛠️ 트러블슈팅 사례
- **DB 연결 불안정**  
  - 원인: 요청 폭주 시 드라이버 직접 연결 방식의 한계  
  - 해결: JNDI DataSource(커넥션 풀) 적용 + try-with-resources → 안정적 CRUD 확보  

- **입력값 검증 누락**  
  - 원인: 분산된 검증 로직 → 잘못된 값 저장  
  - 해결: DTO `validate()` 도입 + JSP 폼 에러 피드백 → UX 개선  

---

## 📝 KPT 회고
- ✅ **Keep**: MVC/DAO 패턴을 처음부터 끝까지 단독 구현 → 구조적 개발 습관 강화  
- ⚠️ **Problem**: 초기 드라이버 직접 연결로 유지보수 어려움, 검증 로직 분산  
- 💡 **Try**: 공통 검증/에러 핸들러 유틸화, 검색·페이징 기능 추가  

---

## 📂 산출물
- 🔗 [GitHub Repository](#)  
- 📑 [발표자료](#)  
- 🖼️ AssetKeeper 프로젝트 로고  

---

✨ **AssetKeeper는 단순 CRUD 이상의 학습 프로젝트로, 안정성·유효성 검증·구조적 설계의 중요성을 체감한 경험입니다.**
