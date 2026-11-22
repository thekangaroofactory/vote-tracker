
// The observer
const scrollObserver = new IntersectionObserver((entries, observer) => {
  
  // looping on all entries of the observer
  entries.forEach(entry => {
    if (entry.isIntersecting) {
      
      // once element is hit: get track value & use as margin
      const value = entry.target.parentElement.getAttribute('aria-valuenow');
      entry.target.style.marginLeft = value + '%';
      observer.unobserve(entry.target); // drop entry from observer
      
    }
  });
  
}, { threshold: 0.5 });


// Shiny custom message
Shiny.addCustomMessageHandler("observeCandRows", function(message) {
  
  // Select elements by class
  const newElements = document.querySelectorAll('.meter-point');
  
  // add observer
  newElements.forEach(el => {
    scrollObserver.observe(el);
  });
  
});
