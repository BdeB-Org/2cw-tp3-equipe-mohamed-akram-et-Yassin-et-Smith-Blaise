

CREATE TABLE jeu_video (
    id_jeu NUMBER NOT NULL,
    nom VARCHAR2(100) NOT NULL,
    genre VARCHAR2(50) NOT NULL,
    date_sortie DATE NOT NULL,
    editeur VARCHAR2(100) NOT NULL,
    PRIMARY KEY (id_jeu)
);

-- Insertion des données dans la table jeu_video
INSERT INTO jeu_video (id_jeu, nom, genre, date_sortie, editeur) VALUES (1, 'The Legend of Zelda', 'Action-Adventure', TO_DATE('1986-02-21', 'YYYY-MM-DD'), 'Nintendo');
INSERT INTO jeu_video (id_jeu, nom, genre, date_sortie, editeur) VALUES (2, 'Super Mario Bros.', 'Platformer', TO_DATE('1985-09-13', 'YYYY-MM-DD'), 'Nintendo');
COMMIT;

CREATE TABLE client (
    id_client NUMBER NOT NULL,
    nom VARCHAR2(100) NOT NULL,
    prenom VARCHAR2(100) NOT NULL,
    telephone VARCHAR2(15) NOT NULL,
    courriel VARCHAR2(100) NOT NULL,
    PRIMARY KEY (id_client)
);

-- Insertion des données dans la table client
INSERT INTO client (id_client, nom, prenom, telephone, courriel) VALUES (1, 'Dupont', 'Jean', '123-456-7890', 'jean.dupont@example.com');
INSERT INTO client (id_client, nom, prenom, telephone, courriel) VALUES (2, 'Martin', 'Marie', '987-654-3210', 'marie.martin@example.com');
COMMIT;

CREATE TABLE categories (
    id_categorie NUMBER NOT NULL,
    nom_categorie VARCHAR2(100) NOT NULL,
    PRIMARY KEY (id_categorie)
);

-- Insertion des données dans la table categorie
INSERT INTO categories (id_categorie, nom_categorie) VALUES (1, 'Action-Adventure');
INSERT INTO categories (id_categorie, nom_categorie) VALUES (2, 'Platformer');
INSERT INTO categories (id_categorie, nom_categorie) VALUES (3, 'RPG');
INSERT INTO categories (id_categorie, nom_categorie) VALUES (4, 'Shooter');
INSERT INTO categories (id_categorie, nom_categorie) VALUES (5, 'Puzzle');
COMMIT;

CREATE TABLE reservation (
    id_reservation NUMBER NOT NULL,
    date_reservation DATE NOT NULL,
    id_client NUMBER NOT NULL,
    id_jeu NUMBER NOT NULL,
    PRIMARY KEY (id_reservation),
    FOREIGN KEY (id_client) REFERENCES client (id_client),
    FOREIGN KEY (id_jeu) REFERENCES jeu_video (id_jeu)
);
INSERT INTO reservation (id_reservation, date_reservation, id_client, id_jeu) VALUES (1, TO_DATE('2023-05-01', 'YYYY-MM-DD'), 1, 1);
INSERT INTO reservation (id_reservation, date_reservation, id_client, id_jeu) VALUES (2, TO_DATE('2023-05-02', 'YYYY-MM-DD'), 2, 2);
COMMIT;

-- Activation du schéma pour accès REST
BEGIN
  ORDS.enable_schema(
    p_enabled             => TRUE,
    p_schema              => 'SCOTT', -- Remplacez par le nom de votre schéma
    p_url_mapping_type    => 'BASE_PATH',
    p_url_mapping_pattern => 'hr2', -- Vous pouvez définir le chemin de base de votre API
    p_auto_rest_auth      => FALSE
  );
  COMMIT;
END;
/

-- Activation de la table jeu_video pour accès REST
BEGIN
  ORDS.enable_object (
    p_enabled      => TRUE,
    p_schema       => 'SCOTT',
    p_object       => 'JEU_VIDEO',
    p_object_type  => 'TABLE',
    p_object_alias => 'jeu'
  );
  COMMIT;
END;
/

-- Activation de la table client pour accès REST
BEGIN
  ORDS.enable_object (
    p_enabled      => TRUE,
    p_schema       => 'SCOTT', 
    p_object       => 'CLIENT',
    p_object_type  => 'TABLE',
    p_object_alias => 'client' 
  );
  COMMIT;
END;
/


-- Activation de la table categories pour accès REST
BEGIN
  ORDS.enable_object (
    p_enabled      => TRUE,
    p_schema       => 'SCOTT',
    p_object       => 'CATEGORIES',
    p_object_type  => 'TABLE',
    p_object_alias => 'categories'
  );
  COMMIT;
END;
/

-- Activation de la table reservation pour accès REST
BEGIN
  ORDS.enable_object (
    p_enabled      => TRUE,
    p_schema       => 'SCOTT', 
    p_object       => 'RESERVATION',
    p_object_type  => 'TABLE',
    p_object_alias => 'reservations'
  );
  COMMIT;
END;
/

-- Vérification de l'activation du schéma
SELECT *
FROM user_ords_schemas;

