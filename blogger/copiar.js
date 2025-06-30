document.addEventListener("DOMContentLoaded", function () {
  document.querySelectorAll('.copy').forEach(function (div) {
    const btn = document.createElement('button');
    btn.className = 'copy-btn';
    btn.innerText = ' ';

    btn.onclick = function () {
      const cloned = div.cloneNode(true);
      const btnInClone = cloned.querySelector('button');
      if (btnInClone) btnInClone.remove();

      const text = cloned.innerText;

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
