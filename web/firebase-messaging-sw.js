importScripts('https://www.gstatic.com/firebasejs/8.6.8/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/8.6.8/firebase-messaging.js');

//aqui vienen mis project credentials!!
firebase.initializeApp({
    apiKey: "AIzaSyA09ojOTBY4zNrmpWKzlLINMfBUD6e8GN4",
    authDomain: "flutter-push-e2d7a.firebaseapp.com",
    projectId: "flutter-push-e2d7a",
    storageBucket: "flutter-push-e2d7a.appspot.com",
    messagingSenderId: "865800931938",
    appId: "1:865800931938:web:fa2b739d6b36e279d19f3b",
    measurementId: "G-DY0KXE6JDG"
});

const messaging = firebase.messaging();