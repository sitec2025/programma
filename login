<!DOCTYPE html>
<html lang="it">
<head>
  <meta charset="UTF-8" />
  <title>Accedi a Sitec Impianti Srl</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <style>
    :root {
      --brand-color: #007bff; /* Blu come colore primario */
      --brand-color-light: rgba(0, 123, 255, 0.25);
      --text-primary: #111827;
      --text-secondary: #4b5563;
      --surface-bg: rgba(255, 255, 255, 0.6); /* Bianco traslucido per l'effetto vetro */
      --surface-border: rgba(255, 255, 255, 0.9);
      --surface-shadow: rgba(44, 62, 80, 0.15);
    }

    @keyframes animated-gradient {
      0% { background-position: 0% 50%; }
      50% { background-position: 100% 50%; }
      100% { background-position: 0% 50%; }
    }

    html {
      min-height: 100%;
    }

    body {
      margin: 0;
      padding: 20px;
      font-family: 'Poppins', sans-serif;
      background: linear-gradient(135deg, #f3e8ff, #dbeafe, #e0f2fe);
      background-size: 400% 400%;
      animation: animated-gradient 15s ease infinite;
      display: flex;
      justify-content: center;
      align-items: center; /* Centra verticalmente il contenuto */
      min-height: 100vh; /* Fa in modo che il body occupi l'intera altezza della viewport */
      box-sizing: border-box;
    }

    main {
      width: 100%;
      max-width: 500px; /* Larghezza massima per il contenitore di login */
      padding: 40px 50px;
      text-align: center;
      background: var(--surface-bg);
      border-radius: 24px;
      border: 1px solid var(--surface-border);
      box-shadow: 0 20px 50px var(--surface-shadow);
      backdrop-filter: blur(12px);
      -webkit-backdrop-filter: blur(12px); /* Supporto per Safari */
    }

    #logo-container {
      margin-bottom: 30px;
    }

    #logo-container img {
      max-width: 100%;
      height: auto;
      display: block;
      margin: 0 auto;
    }

    #auth-container h2 {
        color: var(--text-primary);
        margin-bottom: 25px;
        font-size: 1.8rem;
    }
    #auth-container input[type="email"],
    #auth-container input[type="password"] {
        width: calc(100% - 20px);
        padding: 12px 10px;
        margin-bottom: 15px;
        border: 1px solid #e5e7eb;
        border-radius: 8px;
        font-family: 'Poppins', sans-serif;
        font-size: 1rem;
        color: var(--text-primary);
        background-color: rgba(249, 250, 251, 0.8);
        transition: border-color 0.3s ease, box-shadow 0.3s ease;
    }
    #auth-container input[type="email"]:focus,
    #auth-container input[type="password"]:focus {
        outline: none;
        border-color: var(--brand-color);
        box-shadow: 0 0 0 3px var(--brand-color-light);
    }
    #auth-container button {
        width: 100%;
        padding: 12px;
        margin-bottom: 10px;
        background-color: var(--brand-color);
        color: white;
        border: none;
        border-radius: 8px;
        font-family: 'Poppins', sans-serif;
        font-size: 1rem;
        font-weight: 600;
        cursor: pointer;
        transition: background-color 0.3s ease, transform 0.2s ease;
    }
    #auth-container button:hover {
        background-color: #0056b3;
        transform: translateY(-1px);
    }
    #auth-container #auth-status {
        margin-top: 15px;
        font-size: 0.9rem;
        color: var(--text-secondary);
    }
    #auth-container #google-login-btn {
        background-color: #DB4437; /* Google Red */
    }
    #auth-container #google-login-btn:hover {
        background-color: #C33D2E;
    }

    @media (max-width: 768px) {
      body { padding: 0; }
      main {
        padding: 25px 20px;
        background: none;
        border: none;
        box-shadow: none;
        backdrop-filter: none;
        -webkit-backdrop-filter: none;
        border-radius: 0;
      }
      #auth-container {
        padding: 20px;
      }
      #auth-container h2 {
        font-size: 1.5rem;
      }
    }
  </style>
</head>
<body>
  <main>
    <div id="logo-container">
      <img src="sitec_logo_nuovo[1] (2)_page-0001.jpg" alt="Logo Sitec Impianti Srl">
    </div>

    <div id="auth-container">
        <h2>Accedi o Registrati</h2>
        <input type="email" id="email" placeholder="Email" required><br>
        <input type="password" id="password" placeholder="Password" required><br>
        <button id="login-btn">Accedi</button>
        <button id="register-btn">Registrati</button>
        <button id="google-login-btn">Accedi con Google</button>
        <p id="auth-status"></p>
    </div>
  </main>

  <script type="module">
    // Importa le funzioni necessarie dall'SDK di Firebase
    import { initializeApp } from "https://www.gstatic.com/firebasejs/12.0.0/firebase-app.js";
    import { getAnalytics } from "https://www.gstatic.com/firebasejs/12.0.0/firebase-analytics.js";
    import { 
        getAuth, 
        createUserWithEmailAndPassword, 
        signInWithEmailAndPassword, 
        GoogleAuthProvider, 
        signInWithPopup, 
        onAuthStateChanged 
    } from "https://www.gstatic.com/firebasejs/12.0.0/firebase-auth.js";

    // La tua configurazione Firebase (assicurati che sia corretta)
    const firebaseConfig = {
      apiKey: "AIzaSyCDs7iMJjJYFh8qc7LASNwFYSyFAJDJrQ8",
      authDomain: "programma-sitec-impianti.firebaseapp.com",
      projectId: "programma-sitec-impianti",
      storageBucket: "programma-sitec-impianti.firebasestorage.app",
      messagingSenderId: "87076748220",
      appId: "1:87076748220:web:351e6806174f18307dc9b9",
      measurementId: "G-XSSHYE58MD"
    };

    // Inizializza Firebase
    const app = initializeApp(firebaseConfig);
    const analytics = getAnalytics(app); // Puoi rimuovere questa riga se non usi Analytics
    const auth = getAuth(app); // Ottieni l'istanza di Auth

    // Riferimenti agli elementi HTML per l'autenticazione
    const emailInput = document.getElementById('email');
    const passwordInput = document.getElementById('password');
    const loginBtn = document.getElementById('login-btn');
    const registerBtn = document.getElementById('register-btn');
    const googleLoginBtn = document.getElementById('google-login-btn');
    const authStatus = document.getElementById('auth-status');

    // Registrazione Utente
    registerBtn.addEventListener('click', () => {
        const email = emailInput.value;
        const password = passwordInput.value;

        createUserWithEmailAndPassword(auth, email, password)
            .then((userCredential) => {
                const user = userCredential.user;
                authStatus.textContent = `Registrazione riuscita per: ${user.email}. Reindirizzamento...`;
                console.log('Utente registrato:', user);
            })
            .catch((error) => {
                authStatus.textContent = `Errore registrazione: ${error.message}`;
                console.error('Errore registrazione:', error);
            });
    });

    // Login Utente
    loginBtn.addEventListener('click', () => {
        const email = emailInput.value;
        const password = passwordInput.value;

        signInWithEmailAndPassword(auth, email, password)
            .then((userCredential) => {
                const user = userCredential.user;
                authStatus.textContent = `Login riuscito per: ${user.email}. Reindirizzamento...`;
                console.log('Utente loggato:', user);
            })
            .catch((error) => {
                authStatus.textContent = `Errore login: ${error.message}`;
                console.error('Errore login:', error);
            });
    });

    // Metodo Google (Pop-up)
    googleLoginBtn.addEventListener('click', () => {
        const provider = new GoogleAuthProvider();
        signInWithPopup(auth, provider)
            .then((result) => {
                const user = result.user;
                authStatus.textContent = `Login Google riuscito per: ${user.displayName || user.email}. Reindirizzamento...`;
                console.log('Utente Google loggato:', user);
            })
            .catch((error) => {
                authStatus.textContent = `Errore login Google: ${error.message}`;
                console.error('Errore login Google:', error);
            });
    });

    // Monitoraggio dello Stato di Autenticazione
    onAuthStateChanged(auth, (user) => {
        if (user) {
            // Utente loggato, reindirizza alla pagina principale del programma
            console.log('Utente loggato, reindirizzo a index.html:', user);
            window.location.href = 'index.html'; // Reindirizza a index.html
        } else {
            // Nessun utente loggato, mostra il form di login
            console.log('Nessun utente loggato, visualizzo il form di login.');
            authStatus.textContent = 'Effettua l\'accesso o registrati.';
        }
    });

  </script>
</body>
</html>
