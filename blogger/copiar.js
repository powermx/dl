document.addEventListener("DOMContentLoaded", function () {
  document.querySelectorAll('.copy').forEach(function (div) {
    const btn = document.createElement('button');
    btn.className = 'copy-btn';
    btn.innerText = 'Copiar';

    btn.addEventListener('click', function (e) {
      e.stopPropagation();
      e.preventDefault();

      // Obtener solo los elementos que NO sean el botón
      const lines = Array.from(div.children)
        .filter(child => child.tagName !== 'BUTTON')
        .map(child => child.innerText.trim())
        .join('\n');

      const textarea = document.createElement("textarea");
      textarea.value = lines;
      document.body.appendChild(textarea);
      textarea.select();
      document.execCommand("copy");
      document.body.removeChild(textarea);

      alert("Texto copiado al portapapeles");
    });

    div.appendChild(btn);
  });
});
