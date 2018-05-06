console.log('main.js loaded');

// const signOutButton = document.getElementById('signOut');
// if (signOutButton) {
//   console.log('signOutButton exists');
//   signOutButton.addEventListener('click', () => {
//     Location.reload();
//   });
// }

// When the user scrolls the page, execute myFunction
window.onscroll = function () {
  myFunction();
};

// Get the navbar
const navbar = document.getElementById('navbar');

// Get the offset position of the navbar
const sticky = navbar.offsetTop;

// Add the sticky class to the navbar when you reach its scroll position. Remove "sticky" when you leave the scroll position
function myFunction() {
  console.log('sticky: ', sticky);
  if (window.pageYOffset >= sticky - 50) {
    navbar.classList.add('sticky');
  } else {
    navbar.classList.remove('sticky');
  }
}
