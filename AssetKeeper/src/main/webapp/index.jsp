<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>비품 관리 시스템</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .navbar {
            background-color: #343a40 !important;
        }
        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
        }
        .btn-primary:hover {
            background-color: #0056b3;
        }
        .table-dark {
            background-color: #343a40 !important;
            color: white;
        }
    </style>
</head>
<body>

<!-- 네비게이션 바 -->
<nav class="navbar navbar-expand-lg navbar-dark">
    <div class="container d-flex align-items-center">
        <a class="navbar-brand d-flex align-items-center" href="#">
            <img src="/AssetKeeper/img/assetkeeperweblogo.jpg" alt="로고" style="height: 40px; margin-right: 10px;">
            비품 관리 시스템
        </a>
        <button class="btn btn-primary ms-2" data-bs-toggle="modal" data-bs-target="#addAssetModal">비품 등록</button>
    </div>
</nav>

<!-- 콘텐츠 영역 -->
<div class="container mt-4" style = "height: 582px;    overflow-y: scroll;">
    <h2 class="mb-4 text-center">비품 목록</h2>
    <table class="table table-striped text-center">
        <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>이름</th>
                <th>담당자</th>
                <th>구매 날짜</th>
                <th>가격</th>
                <th>위치</th>
                <th>비고</th>
                <th>관리</th>
                <th>입력</th>
            </tr>
        </thead>
        <tbody id="assetTableBody">
            <!-- JavaScript에서 데이터 로드 -->
        </tbody>
    </table>
</div>

<!-- 비품 등록 모달 -->
<div class="modal fade" id="addAssetModal" tabindex="-1" aria-labelledby="addAssetModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addAssetModalLabel">비품 등록</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="assetForm">
                    <div class="mb-3">
                        <label class="form-label">이름</label>
                        <input type="text" class="form-control" id="assetName" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">담당자</label>
                        <input type="text" class="form-control" id="assetManager" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">구매 장소</label>
                        <input type="text" class="form-control" id="assetPlace">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">구매 날짜</label>
                        <input type="date" class="form-control" id="assetDate">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">가격</label>
                        <input type="number" class="form-control" id="assetPrice">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">위치</label>
                        <input type="text" class="form-control" id="assetLocation">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">특이사항</label>
                        <textarea class="form-control" id="assetNotes"></textarea>
                    </div>
                    <button onclick="insertAsset(document.getElementById('editAssetId').value)" type="button" class="btn btn-primary w-100">등록</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- 비품 상세 조회 모달 -->
<div class="modal fade" id="viewAssetModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">비품 상세 조회</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <p><strong>이름:</strong> <span id="viewAssetName"></span></p>
                <p><strong>담당자:</strong> <span id="viewAssetManager"></span></p>
                <p><strong>구매 날짜:</strong> <span id="viewAssetDate"></span></p>
                <p><strong>가격:</strong> <span id="viewAssetPrice"></span></p>
                <p><strong>위치:</strong> <span id="viewAssetLocation"></span></p>
                <p><strong>비고:</strong> <span id="viewAssetNotes"></span></p>
            </div>
        </div>
    </div>
</div>

<!-- 비품 수정 모달 -->
<div class="modal fade" id="editAssetModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">비품 수정</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form id="editAssetForm">
                    <input type="hidden" id="editAssetId">
                    <div class="mb-3">
                        <label class="form-label">이름</label>
                        <input type="text" class="form-control" id="editAssetName" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">담당자</label>
                        <input type="text" class="form-control" id="editAssetManager" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">구매 장소</label>
                        <input type="text" class="form-control" id="editAssetPlace">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">구매 날짜</label>
                        <input type="date" class="form-control" id="editAssetDate">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">가격</label>
                        <input type="number" class="form-control" id="editAssetPrice">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">위치</label>
                        <input type="text" class="form-control" id="editAssetLocation">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">비고</label>
                        <textarea class="form-control" id="editAssetNotes"></textarea>
                    </div>
                    <button onclick="updateAsset(document.getElementById('editAssetId').value)" type="button" class="btn btn-primary w-100">수정 완료</button>
                </form>
            </div>
        </div>
    </div>
</div>
<!-- 푸터 -->
<footer class="bg-dark text-white text-center py-3 mt-4">
    <div class="container">
        <p class="mb-0">&copy; 2025 K-D-T ㏇ </p>
        <p>인천시 부평구 경원대로 1366, (부평동, 스테이션타워 7F) | 전화: 032-521-8889</p>
        <p>사업자번호: 123-45-56789 | 통신판매신고번호: 2025-서울서초-1234</p>
        <p>제휴&마케팅 문의: <a href="mailto:partner@megaclab.com" class="text-white">lelabo7317@gmail.com</a></p>
        <p>
            <a href="#" class="text-white me-3">이용약관</a>
            <a href="#" class="text-white me-3">개인정보취급방침</a>
            <a href="#" class="text-white me-3">연혁</a>
            <a href="#" class="text-white me-3">언론보도</a>
            <a href="#" class="text-white me-3">프랜차이즈문의신청</a>
            
        </p>
        <p>
            <a href="https://www.instagram.com/tjoeun/" class="text-white me-3">Instagram</a>
            <a href="https://www.youtube.com/channel/UCmJ-ked8GqpUR2Ge9TP3S-w" class="text-white me-3">YouTube</a>
            <a href="https://blog.naver.com/tjoeun_web" class="text-white me-3">네이버블로그</a>
        </p>
    </div>
</footer>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- 데이터 로딩용 JavaScript -->
<script src="index.js"></script>

</body>
</html>
