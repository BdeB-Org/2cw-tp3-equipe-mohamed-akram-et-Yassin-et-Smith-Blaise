// Fonction pour créer un élément HTML
function createNode(element) {
    return document.createElement(element);
}

// Fonction pour ajouter un élément à un parent
function append(parent, el) {
    return parent.appendChild(el);
}


// Pour la table jeu_video
const jeuxUl = document.getElementById("jeux"); // L'élément UL où les jeux seront affichés
fetch("http://localhost:8080/ords/hr2/jeu_video/")
    .then(response => response.json())
    .then(data => {
        data.items.forEach(jeu => {
            let li = createNode("li"),
                span = createNode("span");
            span.innerHTML = `ID: ${jeu.id_jeu}, Nom: ${jeu.nom}, Genre: ${jeu.genre}, Date de sortie: ${jeu.date_sortie}, Éditeur: ${jeu.editeur}`;
            append(li, span);
            append(jeuxUl, li);
        });
    })
    .catch(error => console.error('Erreur:', error));

// Pour la table client
const clientsUl = document.getElementById("clients"); // L'élément UL où les clients seront affichés
fetch("http://localhost:8080/ords/hr2/client/")
    .then(response => response.json())
    .then(data => {
        data.items.forEach(client => {
            let li = createNode("li"),
                span = createNode("span");
            span.innerHTML = `ID: ${client.id_client}, Nom: ${client.nom}, Prénom: ${client.prenom}, Téléphone: ${client.telephone}, Courriel: ${client.courriel}`;
            append(li, span);
            append(clientsUl, li);
        });
    })
    .catch(error => console.error('Erreur:', error));

// Pour la table reservation
const reservationsUl = document.getElementById("reservations"); // L'élément UL où les réservations seront affichées
fetch("http://localhost:8080/ords/hr2/reservation/")
    .then(response => response.json())
    .then(data => {
        data.items.forEach(reservation => {
            let li = createNode("li"),
                span = createNode("span");
            span.innerHTML = `ID: ${reservation.id_reservation}, Date de réservation: ${reservation.date_reservation}, ID Client: ${reservation.id_client}, ID Jeu: ${reservation.id_jeu}`;
            append(li, span);
            append(reservationsUl, li);
        });
    })
    .catch(error => console.error('Erreur:', error));



//AJOUT CLIENTS
    const ajoutClientForm = document.getElementById('ajoutClientForm');
    ajoutClientForm.addEventListener('submit', function(event) {
        event.preventDefault();

        // Récupérer les valeurs du formulaire
        const nom = document.getElementById('nom').value;
        const prenom = document.getElementById('prenom').value;
        const telephone = document.getElementById('telephone').value;
        const courriel = document.getElementById('courriel').value;

        // Créer un objet client avec les données du formulaire
        const client = {
            nom: nom,
            prenom: prenom,
            telephone: telephone,
            courriel: courriel
        };

        // Enregistrer le client dans le stockage local avec une clé distincte
        localStorage.setItem('nouveauClient', JSON.stringify(client));

        // Rediriger vers la page reservations.html
        window.location.href = 'reservations.html';
    });
 




    