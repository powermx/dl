document.addEventListener("DOMContentLoaded", function () {
  document.querySelectorAll('.copy').forEach(function (div) {
    const btn = document.createElement('button');
    btn.className = 'copy-btn';
    btn.innerText = 'Copiar';

    btn.addEventListener('click', function (e) {
      e.stopPropagation(); // prevenir burbujas
      e.preventDefault();

      // Crear un texto solo con los nodos que no son el botón
      let text = '';
      div.childNodes.forEach(node => {
        if (node !== btn) {
          if (node.nodeType === Node.TEXT_NODE) {
            text += node.textContent;
          } else if (node.nodeType === Node.ELEMENT_NODE && node.tagName.toLowerCase() !== 'button') {
            text += node.innerText + '\n';
          }
        }
      });

      const textarea = document.createElement("textarea");
      textarea.value = text.trim();
      document.body.appendChild(textarea);
      textarea.select();
      document.execCommand("copy");
      document.body.removeChild(textarea);

      alert("Texto copiado al portapapeles");
    });

    div.appendChild(btn);
  });
});
