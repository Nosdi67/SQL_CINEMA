-- Informations d’un film (id_film) : titre, année, durée (au format HH:MM) et réalisateur
SELECT film.nom_film,film.annee,personne.prenom,personne.nom,
CONCAT(FLOOR(film.duree/ 60), ' Heures et ', MOD(film.duree, 60),'minutes') AS temps_convert
FROM film
INNER JOIN realisateur ON film.id_realisateur = realisateur.id_realisateur
INNER JOIN personne ON personne.id_personne = realisateur.id_personne

--Liste des films dont la durée excède 2h15 classés par durée (du + long au + court)
SELECT film.nom_film,film.annee,personne.prenom,personne.nom,
CONCAT(FLOOR(film.duree/ 60), ' Heures et ', MOD(film.duree, 60),'minutes') AS temps_convert
FROM film
INNER JOIN realisateur ON film.id_realisateur = realisateur.id_realisateur
INNER JOIN personne ON personne.id_personne = realisateur.id_personne
WHERE film.duree >= 130
ORDER BY temps_convert DESC 

--Liste des films d’un réalisateur (en précisant l’année de sortie)
SELECT film.nom_film,film.annee,personne.prenom,personne.nom
FROM film
INNER JOIN realisateur ON film.id_realisateur = realisateur.id_realisateur
INNER JOIN personne ON personne.id_personne = realisateur.id_personne

--Nombre de films par genre (classés dans l’ordre décroissant)
SELECT genre.nom_genre, COUNT(genre.id_genre) AS nbFilm 
FROM genre
INNER JOIN identifier ON identifier.id_genre = genre.id_genre
GROUP BY genre.id_genre
ORDER BY nbFilm DESC 

--Nombre de films par réalisateur (classés dans l’ordre décroissant)
SELECT personne.nom,personne.prenom,COUNT(id_film) AS NbFilm
FROM realisateur
INNER JOIN film ON film.id_realisateur = realisateur.id_realisateur
INNER JOIN personne ON personne.id_personne = realisateur.id_personne
GROUP BY personne.id_personne
ORDER BY nbFilm DESC 

--Casting d’un film en particulier (id_film) : nom, prénom des acteurs + sexe
SELECT personne.nom,personne.prenom,personne.sexe, nom_role,film.nom_film
FROM personne
INNER JOIN acteur ON acteur.id_personne = personne.id_personne
INNER JOIN jouer ON jouer.id_acteur = acteur.id_acteur
INNER JOIN film ON film.id_film = jouer.id_film
INNER JOIN role ON role.id_role = jouer.id_role
WHERE film.id_film=5

--Films tournés par un acteur en particulier (id_acteur) avec leur rôle et l’année de sortie (du film le plus récent au plus ancien)
SELECT personne.nom, personne.prenom,film.nom_film,film.annee, role.nom_role
FROM personne 
INNER JOIN acteur ON acteur.id_personne = personne.id_personne
INNER JOIN jouer ON acteur.id_acteur = jouer.id_acteur
INNER JOIN role ON role.id_role = jouer.id_role
INNER JOIN film ON film.id_film = jouer.id_film
WHERE acteur.id_acteur = 9
ORDER BY film.annee DESC

--Liste des personnes qui sont à la fois acteurs et réalisateurs
SELECT personne.nom,personne.prenom
FROM personne
INNER JOIN acteur ON acteur.id_personne = personne.id_personne
INNER JOIN realisateur ON realisateur.id_personne = personne.id_personne;

--Liste des films qui ont moins de 5 ans (classés du plus récent au plus ancien)
SELECT nom_film, annee
FROM film
WHERE DATEDIFF(CURRENT_DATE(), annee) <= 1825 -- 365 jours * 5 ans
ORDER BY annee DESC

--Nombre d’hommes et de femmes parmi les acteurs
SELECT personne.sexe,COUNT(acteur.id_acteur) AS nombre_acteurs
FROM personne
INNER JOIN acteur ON acteur.id_personne = personne.id_personne
GROUP BY personne.sexe

--Liste des acteurs ayant plus de 50 ans (âge révolu et non révolu)
SELECT personne.nom,personne.prenom,FLOOR(DATEDIFF(CURRENT_DATE(), personne.naissance) / 365) AS age
FROM personne
INNER JOIN acteur ON acteur.id_personne = personne.id_personne
WHERE DATEDIFF(CURRENT_DATE(), personne.naissance) >= 50 * 365 -- 50 ans * 365 jours
ORDER BY age DESC

--Acteurs ayant joué dans 3 films ou plus
SELECT personne.nom,personne.prenom,COUNT(jouer.id_film) AS nombre_films
FROM personne
INNER JOIN acteur ON acteur.id_personne = personne.id_personne
INNER JOIN jouer ON jouer.id_acteur = acteur.id_acteur
GROUP BY personne.nom, personne.prenom
HAVING COUNT(jouer.id_film) >= 3



