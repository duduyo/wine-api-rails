# Energie vin - API

## Brief initial

Un porteur de projet vous recrute en tant que premier développeur back-end dans sa jeune équipe.

Son pitch :

* Concevoir une plateforme de recherche référençant les vins vendus sur des sites spécialisés. Les données (propriétés de la bouteille, prix et site de vente) pourront être récupérées à partir d’un service externe dont on ne connait pas encore les spécificités.
* Pour se démarquer de la concurrence, la plateforme veut faire la part belle aux experts du domaine avec la possibilité d’intégrer leurs notes de dégustation.La fonctionnalité à forte valeur serait de fournir une évaluation de chacune des bouteilles, basée sur la moyenne des notes attribuées par ces experts.
* Autres fonctionnalités à fort potentiel :
    *	Un système d’alerting où les utilisateurs peuvent sauvegarder leurs recherches et être notifiés si une bouteille nouvellement identifiée correspond.
    * L’accès à l’historisation des prix pour chaque bouteille pour comprendre la tendance.


Quand vous lui parlez d’un MVP, le porteur de projet aimerait pouvoir récupérer facilement les vins vendus, classés par meilleure moyenne des notes de dégustation, dont le prix est compris dans l’intervalle fixé par l’utilisateur.

Vous avez rendez-vous dans quelques jours avec lui. Son souhait, est que vous puissiez mettre en place une première structure du projet avec une prémisse de développement afin que vous et les prochains développeurs puissiez travailler dans de bonnes conditions.
Vous vous engagez à fournir un premier livrable récupérable via un repo git et si besoin, tout document utile à la conception. Vous discuterez avec lui de la stratégie future : des prochains développements, de l’infrastructure et des nouveaux recrutements nécessaires à la bonne réalisation de ce projet ambitieux.

## Install

Prérequis :
* Ruby 3.2.2
* SQLite3

```bash
bundle install
rails db:create
rails db:migrate
rails db:seed
```

## Exécution

Lancer les tests et générer la doc de l'api au format OAS3 :
```bash
rake build
```

Lancer le serveur :
```bash
rails s
```
Puis voir http://127.0.0.1:3000


## Orientations retenues

* On suppose que le front est réalisé par ailleurs, on se concentre sur le back
* Fournir une spec de l'API pour documenter les endpoints => utilisation de rswag + dév en outside-in TDD
* S'appuyer sur l'archi Rails, 
  * mais éviter au maximum de disperses la logique métier dans les différentes couches : certains ActiveRecord "maitres" portent de la logique (ex Wine), et utilisation de Service Objects pour les uses cases qui combinent des actions sur plusieurs modèles
  * et s'assurer de la testabilité : injection de dépendance si nécessaire + test avec mocks + déporter les dépendances au monde exterieur dans des Services Objects dédiés (ex : NotificationService et UserMailer) 



## Backlog

Cas d'usage attendus pour l'utilisateur de l'API :
* [MVP1] OK : Rechercher les vins au catalogue dans un intervalle de prix donné, classés par moyenne des notes de dégustation
* [MVP2] OK : Sauvegarder une recherche et être notifié si une bouteille nouvellement identifiée correspond
* [MVP3] NON REALISE : Consulter l'historique des prix et la tendance pour un vin donné


[MVP1] : 
  * [X] App fonctionnelle avec 1 opération simple GET /wines/:id, retourne le nom, prix, url, et note (vide a ce stade)
  * [X] [OPTION] Page web qui documente permet de tester l'api
  * [X] ajouter une note de dégustation : POST /wines/:id/reviews
[MVP 2] ; 
  * [X] Créer POST et GET /search : cette ressource permet de sauvegarder les critères d'une recherche avec min_price, max_price, et également un paramètre  "notification_email" 
  * [X] Refacto : créer un Service Object responsable de créer un nouveau vin dans le catalogue, avec également un POST /wines au niveau controlleur
  * [X] Créer un Service Object qui pour un vin passé en paramètre, identifie les /search qui matchent, et envoie un email à l'utilisateur

## RAF

* gestion des erreurs et cas non nominaux au niveau de l'api et des service objects, validations des paramètres & attributs des activerecord
* en l'état on a des tests (unitaires) dans test, et des tests API dans spec (voir pour tout basculer sur rspec et ne plus utiliser minitest)
* ne pas envoyer plusieurs mails si plusieurs search matchent (piste : utiliser set + delay dans le notification service)


