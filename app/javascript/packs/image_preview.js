document.addEventListener("DOMContentLoaded", () => {
  const imageInput = document.getElementById("image-input");
  const imagePreview = document.getElementById("image-preview");

  if (imageInput) {
    imageInput.addEventListener("change", (event) => {
      // プレビューをリセット
      imagePreview.innerHTML = "";

      // ファイルリストを取得
      const files = event.target.files;

      // 各ファイルを処理
      Array.from(files).forEach((file) => {
        // 画像のみ処理
        if (!file.type.startsWith("image/")) return;

        // FileReaderで画像を読み込み
        const reader = new FileReader();
        reader.onload = (e) => {
          // 画像のプレビューを表示
          const img = document.createElement("img");
          img.src = e.target.result;
          img.classList.add("img-thumbnail", "me-2", "mb-2");
          img.style.maxWidth = "150px";
          img.style.maxHeight = "150px";
          imagePreview.appendChild(img);
        };
        reader.readAsDataURL(file);
      });
    });
  }
});