window.addEventListener("scroll", function () {
  var header = document.querySelector("header");
  header.classList.toggle("scroll-nav", window.scrollY > 0);
});