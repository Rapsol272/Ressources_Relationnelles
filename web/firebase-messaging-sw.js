
importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js");

firebase.initializeApp({
  apiKey: "AIzaSyCiPHPmxFyIkQwcOUk7eI63LHTllTEzzJk",
  authDomain: "formfirebase-e7d6e.firebaseapp.com",
  databaseURL: "https://formfirebase-e7d6e-default-rtdb.europe-west1.firebasedatabase.app",
  projectId: "formfirebase-e7d6e",
  storageBucket: "formfirebase-e7d6e.appspot.com",
  messagingSenderId: "945171425010",
  appId: "1:945171425010:web:87787301a2d95437a7126b",
  measurementId: "G-EFST4CDZCP"
});
// Necessary to receive background messages:
const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((m) => {
  console.log("onBackgroundMessage", m);
});