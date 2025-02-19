document.addEventListener("DOMContentLoaded", function () {
    getAllAssets();
    document.getElementById("assetForm").addEventListener("submit", handleInsertFormSubmit);
    document.getElementById("editAssetForm").addEventListener("submit", handleEditFormSubmit);
});

// 🚀 [1] 비품 전체 조회 (GET 요청)
function getAllAssets() {
    fetch('/AssetKeeper/asset')
        .then(response => response.json())
        .then(data => {
            let tableBody = document.getElementById("assetTableBody");
            tableBody.innerHTML = "";
            data.forEach(item => {
                tableBody.innerHTML += `
                    <tr>
                        <td>${item.id}</td>
                        <td>${item.name}</td>
                        <td>${item.manager}</td>
                        <td>${item.purchasePlace}</td>
                        <td>${item.purchaseDate}</td>
                        <td>${item.purchasePrice.toLocaleString()}원</td>
                        <td>${item.currentLocation}</td>
                        <td>${item.specialNotes}</td>
                        <td>
                            <button class="btn btn-info btn-sm view-btn" data-id="${item.id}">조회</button>
                            <button class="btn btn-warning btn-sm edit-btn" data-id="${item.id}">수정</button>
                            <button class="btn btn-danger btn-sm delete-btn" data-id="${item.id}">삭제</button>
                        </td>
                    </tr>`;
            });
        })
        .catch(error => console.error("❌ 데이터 불러오기 실패: ", error));
}

// 🚀 [2] 비품 개별 조회 (GET 요청)
function getReadAsset(id) {
    return fetch(`/AssetKeeper/asset/view?id=${id}`)
        .then(response => response.json());
}

// 🚀 [3] 비품 등록 처리 (POST 요청)
function insertAsset() {
    let assetData = getAssetFormData();
    console.log("📌 비품 등록 데이터:", assetData);

    fetch('/AssetKeeper/asset', {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(assetData)
    })
    .then(response => response.json())
    .then(data => {
        console.log("✅ 서버 응답:", data);
        if (data.message === "비품 등록 성공") {
            getAllAssets();
            bootstrap.Modal.getInstance(document.getElementById("insertAssetModal")).hide();
        } else {
            alert("등록 실패: " + data.message);
        }
    })
    .catch(error => console.error("❌ 비품 등록 요청 실패:", error));
}

// 🚀 [4] 비품 수정 처리 (PUT 요청)
function updateAsset(id) {
    let assetData = {
        id: id,
        name: document.getElementById("editAssetName").value,
        manager: document.getElementById("editAssetManager").value,
        purchasePlace: document.getElementById("editAssetPlace").value,
        purchaseDate: document.getElementById("editAssetDate").value,
        purchasePrice: document.getElementById("editAssetPrice").value,
        currentLocation: document.getElementById("editAssetLocation").value,
        specialNotes: document.getElementById("editAssetNotes").value
    };

    console.log("📌 비품 수정 요청 데이터:", assetData);

    fetch('/AssetKeeper/asset', {
        method: "PUT",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(assetData)
    })
    .then(response => response.json())
    .then(data => {
        console.log("✅ 서버 응답:", data);
        if (data.message === "비품 수정 성공") {
            getAllAssets();
            bootstrap.Modal.getInstance(document.getElementById("editAssetModal")).hide();
        } else {
            alert("수정 실패: " + data.message);
        }
    })
    .catch(error => console.error("❌ 비품 수정 요청 실패:", error));
}

// 🚀 [5] 비품 삭제 처리 (DELETE 요청)
function deleteAsset(id) {
    fetch(`/AssetKeeper/asset?id=${id}`, { method: "DELETE" })
        .then(() => getAllAssets());
}

// 🚀 [6] 버튼 이벤트 처리 (조회, 수정, 삭제)
document.addEventListener("click", function (event) {
    let assetId = event.target.getAttribute("data-id");

    if (event.target.classList.contains("delete-btn")) {
        if (confirm("정말 삭제하시겠습니까?")) deleteAsset(assetId);
    } else if (event.target.classList.contains("view-btn")) {
        viewAsset(assetId);
    } else if (event.target.classList.contains("edit-btn")) {
        editAsset(assetId);
    }
});

// 🚀 [7] 비품 상세 조회 모달 표시
function viewAsset(id) {
    getReadAsset(id).then(data => {
        document.getElementById("viewAssetName").innerText = data.name;
        document.getElementById("viewAssetManager").innerText = data.manager;
        document.getElementById("viewAssetDate").innerText = data.purchaseDate;
        document.getElementById("viewAssetPrice").innerText = data.purchasePrice;
        document.getElementById("viewAssetLocation").innerText = data.currentLocation;
        document.getElementById("viewAssetNotes").innerText = data.specialNotes;
        new bootstrap.Modal(document.getElementById("viewAssetModal")).show();
    });
}

// 🚀 [8] 비품 수정 모달 표시
function editAsset(id) {
    getReadAsset(id).then(data => {
        document.getElementById("editAssetId").value = data.id;
        document.getElementById("editAssetName").value = data.name;
        document.getElementById("editAssetManager").value = data.manager;
        document.getElementById("editAssetPlace").value = data.purchasePlace;
        document.getElementById("editAssetDate").value = data.purchaseDate;
        document.getElementById("editAssetPrice").value = data.purchasePrice;
        document.getElementById("editAssetLocation").value = data.currentLocation;
        document.getElementById("editAssetNotes").value = data.specialNotes;
        new bootstrap.Modal(document.getElementById("editAssetModal")).show();
    });
}

// 🚀 [9] 등록 폼 제출 핸들러
function handleInsertFormSubmit(event) {
    event.preventDefault();
    insertAsset();
}

// 🚀 [10] 수정 폼 제출 핸들러
function handleEditFormSubmit(event) {
    event.preventDefault();
    let assetId = document.getElementById("editAssetId").value;
    updateAsset(assetId);
}

// 🚀 [11] 공통: 폼 데이터 가져오기
function getAssetFormData() {
    return {
        name: document.getElementById("assetName").value,
        manager: document.getElementById("assetManager").value,
        purchasePlace: document.getElementById("assetPlace").value,
        purchaseDate: document.getElementById("assetDate").value,
        purchasePrice: document.getElementById("assetPrice").value,
        currentLocation: document.getElementById("assetLocation").value,
        specialNotes: document.getElementById("assetNotes").value
    };
}

// 🚀 [12] 공통: 폼 초기화 함수
function resetForm() {
    document.getElementById("assetForm").reset();
    document.getElementById("editAssetForm").reset();
}

