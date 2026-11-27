

Shiny.addCustomMessageHandler('updateLoader', function(message) {

  const loader = document.querySelector('.top-loader');
  
  // Chech visible
  if(loader.style.opacity == '0'){
    loader.style.opacity = '1';
  }
  
  // Update progress
  loader.style.width = message.value + '%';
  
  // When reaching 100% hide loader after CSS transition
  if(message.value == 100){
      setTimeout(() => {
        loader.style.opacity = '0';
        loader.style.width = '0%';
      }, 500);
  }
  
});
