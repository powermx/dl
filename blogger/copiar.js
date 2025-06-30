document.addEventListener("DOMContentLoaded", function () {
  document.querySelectorAll('.copy').forEach(function (div) {
    const btn = document.createElement('button');
    btn.className = 'copy-btn';
    btn.innerText = 'Copiar';
    btn.onclick = function () {
      const text = div.innerText;
      const textarea = document.createElement("textarea");
      textarea.value = text;
      document.body.appendChild(textarea);
      textarea.select();
      document.execCommand("copy");
      document.body.removeChild(textarea);
      alert("Texto copiado al portapapeles");
    };
    div.appendChild(btn);
  });
});
