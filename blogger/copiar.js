document.addEventListener("DOMContentLoaded", function () {
  document.querySelectorAll('.copy').forEach(function (div) {
    // Evita agregar más de un botón
    if (div.querySelector('.copy-btn')) return;

    const btn = document.createElement('button');
    btn.className = 'copy-btn';

    // Insertar solo el ícono SVG, sin texto "Copiar"
    btn.innerHTML = `
      <svg height="24" viewBox="0 0 24 24" width="24" xmlns="http://www.w3.org/2000/svg">
        <path d="M0 0h24v24H0z" fill="none"></path>
        <path d="M14 3H4c-1.1 0-1.99.9-1.99 2L2 19
          c0 1.1.89 2 1.99 2H14c1.1 0 2-.9
          2-2V5c0-1.1-.9-2-2-2zm-1 14H5v-1h8v1zm0-3H5v-1h8v1zm0-3H5V10h8v1zm3-7h-2V2H8v2H6
          c-1.11 0-1.99.89-1.99 2L4 20c0 1.11.88 2 1.99
          2h12c1.1 0 2-.89 2-2V7c0-1.11-.9-2-2-2zm0
          15H6V7h2v2h8V7h2v8h2v5z"/>
      </svg>
    `;

    btn.onclick = function () {
      // Clonar el bloque para excluir el botón
      const cloned = div.cloneNode(true);
      const btnInClone = cloned.querySelector('button');
      if (btnInClone) btnInClone.remove();

      const text = cloned.innerText.trim();

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
