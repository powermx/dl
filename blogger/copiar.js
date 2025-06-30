document.addEventListener("DOMContentLoaded", function () {
  document.querySelectorAll('.copy').forEach(function (div) {
    // No añadir botón si ya existe
    if (div.querySelector('.copy-btn')) return;

    const btn = document.createElement('button');
    btn.className = 'copy-btn';
    btn.innerText = 'Copiar';

    const code = div.querySelector('pre code') || div.querySelector('code') || div;

    btn.addEventListener('click', function (e) {
      e.preventDefault();
      const text = code.innerText;

      const textarea = document.createElement("textarea");
      textarea.value = text;
      document.body.appendChild(textarea);
      textarea.select();
      document.execCommand("copy");
      document.body.removeChild(textarea);

      alert("Texto copiado al portapapeles");
    });

    div.appendChild(btn);
  });
});
