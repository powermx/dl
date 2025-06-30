function initCopyButtons() {
  document.querySelectorAll('.codigo').forEach(function (div) {
    if (div.querySelector('.copy-btn')) return; // evitar duplicados

    const btn = document.createElement('button');
    btn.className = 'copy-btn';
    btn.innerHTML = `
      <svg height="20" width="20" viewBox="0 0 24 24" fill="white" xmlns="http://www.w3.org/2000/svg">
        <path d="M0 0h24v24H0z" fill="none"/>
        <path d="M16 1H4c-1.1 0-2 .9-2 2v14h2V3h12V1zm3 
        4H8c-1.1 0-2 .9-2 2v14c0 1.1.9 
        2 2 2h11c1.1 0 2-.9 
        2-2V7c0-1.1-.9-2-2-2zm0 
        16H8V7h11v14z"/>
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
}

// Esperar hasta que .codigo esté disponible
const interval = setInterval(() => {
  if (document.querySelector('.codigo')) {
    clearInterval(interval);
    initCopyButtons();
  }
}, 300);
