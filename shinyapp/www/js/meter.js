
Shiny.addCustomMessageHandler('updateMeter', function(message) {
  var bar = document.getElementById(message.id + '-bar');
    if (bar) {
      bar.style.width = message.value + '%';
      bar.parentElement.setAttribute('aria-valuenow', message.value);
    }
    var value = document.getElementById(message.id + '-value');
    if (value) {
      value.textContent = message.value + '%';
    }
  });
  