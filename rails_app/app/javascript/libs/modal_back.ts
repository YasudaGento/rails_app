export default {
  lock: function() {
      document.body.style.overflow = 'hidden';
  },
  
  unlock: function() {
      document.body.style.overflow = 'auto';
  }
}