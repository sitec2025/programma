// Import Firebase
import { initializeApp } from "https://www.gstatic.com/firebasejs/10.12.0/firebase-app.js";
import { getAuth, onAuthStateChanged, signInWithPopup, GoogleAuthProvider, signOut } from "https://www.gstatic.com/firebasejs/10.12.0/firebase-auth.js";

// Configurazione Firebase
const firebaseConfig = {
  apiKey: "AIzaSyCDs7iMJjJYFh8qc7LASNwFYSyFAJDJrQ8",
  authDomain: "programma-sitec-impianti.firebaseapp.com",
  projectId: "programma-sitec-impianti",
  storageBucket: "programma-sitec-impianti.appspot.com",
  messagingSenderId: "87076748220",
  appId: "1:87076748220:web:351e6806174f18307dc9b9",
  measurementId: "G-XSSHYE58MD"
};

// Inizializza Firebase
const app = initializeApp(firebaseConfig);
const auth = getAuth(app);
const provider = new GoogleAuthProvider();

// Elementi DOM
const loginBtn = document.getElementById("loginBtn");
const logoutBtn = document.getElementById("logoutBtn");
const contentDiv = document.getElementById("content");

// Dati fissi (puoi poi spostarli su Firestore se vuoi)
const dataProgramma = [
  {
    cantiere: "Cantiere A",
    luogo: "Torino",
    lavorazioni: "Montaggio ponteggi",
    collaboratori: "Anna, Luca"
  },
  {
    cantiere: "Cantiere B",
    luogo: "Milano",
    lavorazioni: "Installazione impianti",
    collaboratori: "Marco, Giulia"
  },
  {
    cantiere: "Cantiere C",
    luogo: "Firenze",
    lavorazioni: "Ristrutturazione interna",
    collaboratori: "Luca, Elena, Matteo"
  },
  {
    cantiere: "Cantiere D",
    luogo: "Bologna",
    lavorazioni: "Manutenzione elettrica",
    collaboratori: "Sara, Davide"
  }
];

// Mostra dati se loggato
function mostraProgramma() {
  contentDiv.innerHTML = "<h2>Programma Lavori</h2>";
  dataProgramma.forEach(item => {
    const div = document.createElement("div");
    div.innerHTML = `
      <h3>${item.cantiere}</h3>
      <p><strong>Luogo:</strong> ${item.luogo}</p>
      <p><strong>Lavorazioni:</strong> ${item.lavorazioni}</p>
      <p><strong>Collaboratori:</strong> ${item.collaboratori}</p>
    `;
    contentDiv.appendChild(div);
  });
}

// Eventi login/logout
loginBtn.addEventListener("click", () => {
  signInWithPopup(auth, provider).catch(error => {
    alert("Errore login: " + error.message);
  });
});

logoutBtn.addEventListener("click", () => {
  signOut(auth);
});

// Osserva stato autenticazione
onAuthStateChanged(auth, user => {
  if (user) {
    loginBtn.style.display = "none";
    logoutBtn.style.display = "inline-block";
    mostraProgramma();
  } else {
    loginBtn.style.display = "inline-block";
    logoutBtn.style.display = "none";
    contentDiv.innerHTML = "<p>Effettua il login per visualizzare il programma.</p>";
  }
});
