<!DOCTYPE html>
<html lang="ko">
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

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- 데이터 로딩용 JavaScript -->
<script>
    document.addEventListener("DOMContentLoaded", function () {
        fetch("/asset")  // REST API 호출
            .then(response => response.json())
            .then(data => {
                let tableBody = document.getElementById("assetTableBody");
                tableBody.innerHTML = "";
                data.forEach(item => {
                    let row = `<tr>
                        <td>${item.id}</td>
                        <td>${item.name}</td>
                        <td>${item.manager}</td>
                        <td>${item.purchaseDate}</td>
                        <td>${item.purchasePrice.toLocaleString()}원</td>
                        <td>${item.currentLocation}</td>
                        <td>${item.specialNotes}</td>
                    </tr>`;
                    tableBody.innerHTML += row;
                });
            });
    });
</script>

</body>
</html>