(function() {
  if('serviceWorker' in navigator) {
    window.addEventListener('load', () => {
      navigator.serviceWorker.register('/sw.js').then(function(registration) {
        console.log('Service Worker Registered');
        return registration;
      })
      .catch(function(err) {
        console.error('Unable to register service worker.', err);
      });
      navigator.serviceWorker.ready.then(function(registration) {
        console.log('Service Worker Ready');
      });
    });
  }
})();

$(document).ready(function() {
  url = location.pathname.split("/")[1]
  $(".navbar-burger").click(function() {
    $(".navbar-burger").toggleClass("is-active");
    $(".navbar-menu").toggleClass("is-active");
  });
  if(url != ""){
    $(`.navbar-menu a[href^="/${url}"]`).addClass('is-active');
  }
});

$(document).on('click', '.notification > button.delete', function() {
  $(this).parent().addClass('is-hidden');
  return false;
});

function showToast(text, type){
  swal({});
  const toast = swal.mixin({
    toast: true,
    position: 'top-right',
    showConfirmButton: false,
    timer: 3000
  });
  toast({
    type: type,
    title: text
  });
}

function showSwLink(title, type, showCancel, textConfirm, colorConfirm, link){
  swal({
    title: title,
    type: type,
    showCancelButton: showCancel,
    confirmButtonText: textConfirm,
    confirmButtonColor: colorConfirm,
  }).then((result) => {
    if (result.value){
      window.location.href = link;
    }
  });
}

function toggle(){
  let darkLink = document.getElementById('dark-sheet');
  if(darkLink){
    darkLink.remove();
    window.localStorage.setItem('theme', 'light');
  }else{
    darkLink = document.createElement('link');
    darkLink.rel = 'stylesheet';
    darkLink.id = 'dark-sheet';
    darkLink.href = '/css/bulma-prefers-dark.min.css'
    document.head.appendChild(darkLink);
    window.localStorage.setItem('theme', 'dark');
  }
}
