document.addEventListener("DOMContentLoaded", function () {
  document.querySelectorAll('.copy').forEach(function (div) {
    const btn = div.querySelector('.copy-btn');
    const code = div.querySelector('pre code');

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
  });
});
