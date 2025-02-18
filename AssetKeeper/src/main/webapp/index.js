
  fetch("/AssetKeeper/asset")  // REST API 호출
      .then(response => response.json())
      .then(data => {
		console.log(1);
          let tableBody = document.getElementById("assetTableBody");
		  console.log(2);
		    tableBody.innerHTML = "";
			console.log(3);
			 data.forEach(item => {
				console.log(4);
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
      })
	  .catch(e => console.log(e) )

	  document.addEventListener("DOMContentLoaded", function () {
	       

	       // 폼 제출 이벤트
	       document.getElementById("assetForm").addEventListener("submit", function (event) {
	           event.preventDefault(); // 기본 동작 방지
	           addAsset(); // 비품 등록 함수 호출
	       });
	   });
	   
	   function addAsset() {
	           let assetData = {
	               name: document.getElementById("assetName").value,
	               manager: document.getElementById("assetManager").value,
	               purchasePlace: document.getElementById("assetPlace").value,
	               purchaseDate: document.getElementById("assetDate").value,
	               purchasePrice: document.getElementById("assetPrice").value,
	               currentLocation: document.getElementById("assetLocation").value,
	               specialNotes: document.getElementById("assetNotes").value
	           };

	           fetch("/asset", {
	               method: "POST",
	               headers: { "Content-Type": "application/json" },
	               body: JSON.stringify(assetData)
	           })
	           .then(response => response.json())
	           .then(result => {
	               if (result.success) {
	                   alert("비품이 등록되었습니다!");
	                   document.getElementById("assetForm").reset();
	                   loadAssets(); // 새로고침
	                   var modal = bootstrap.Modal.getInstance(document.getElementById("addAssetModal"));
	                   modal.hide();
	               } else {
	                   alert("등록 실패!");
	               }
	           });
	       }