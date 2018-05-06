console.log('main.js loaded');

const signOutButton = document.getElementById('signOut');
if (signOutButton) {
  console.log('signOutButton exists');
  signOutButton.addEventListener('click', () => {
    Location.reload();
  });
}
