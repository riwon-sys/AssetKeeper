<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>비품 관리 시스템</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>



<!-- 네비게이션 바 -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="#">비품 관리 시스템</a>
        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addAssetModal">비품 등록</button>
    </div>
</nav>

<!-- 콘텐츠 영역 -->
<div class="container mt-4">
    <h2 class="mb-4">비품 목록</h2>

    <!-- 테이블 -->
    <table class="table table-striped">
        <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>이름</th>
                <th>담당자</th>
                <th>구매 날짜</th>
                <th>가격</th>
                <th>위치</th>
                <th>비고</th>
            </tr>
        </thead>
        <tbody id="assetTableBody">
            <!-- JavaScript로 데이터 로드 -->
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
                        <label class="form-label">비고</label>
                        <textarea class="form-control" id="assetNotes"></textarea>
                    </div>
                    <button type="submit" class="btn btn-primary w-100">등록</button>
                </form>
            </div>
        </div>
    </div>
</div>


<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- 데이터 로딩용 JavaScript -->
<script src ="index.js">
  
</script>


</body>
</html>