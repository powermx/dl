document.addEventListener("DOMContentLoaded", function () {
  document.querySelectorAll('.codigo').forEach(function (div) {
    // Evita duplicar el botón
    if (div.querySelector('.codigo-btn')) return;

    const btn = document.createElement('button');
    btn.className = 'codigo-btn';

    // Solo ícono, sin texto
    btn.innerHTML = `
      <svg height="24" width="24" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
        <path d="M0 0h24v24H0z" fill="none"></path>
        <path d="M14 3H4c-1.1 0-2 .9-2 2v14a2
                 2 0 002 2h10a2 2 0 002-2V5a2
                 2 0 00-2-2zm0 16H4V5h10v14zM20
                 7h-2v12H8v2h10a2 2 0 002-2V7z"/>
      </svg>
    `;

    btn.onclick = function () {
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
