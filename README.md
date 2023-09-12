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

## Hypothèses

* On suppose que le front est réalisé par ailleurs, on se concentre sur le back. Nice to have => une UI pour faire une démo
* Stack technique : Ruby on Rails
* TDD


## 1ere analyse domaine et cas d'usage

Domaine :

* Wine : name, price, note, webstore_url
  * 1 wine has many prices
  * 1 wine has many reviews
  * note : average of reviews notes
  * price : last price
* Reviews : comment, note
  * 1 wine has many reviews
* Price : price, date
  * 1 wine has many prices

Cas d'usage attendus pour l'utilisateur de l'API :
* [MVP1] : Rechercher les vins au catalogue dans un intervalle de prix donné, classés par moyenne des notes de dégustation
* [MVP2] : Sauvegarder une recherche et être notifié si une bouteille nouvellement identifiée correspond
* [MVP3] : Consulter l'historique des prix et la tendance pour un vin donné  

## Design API

GET /wines?min_price=10&max_price=20&sort_by=note
GET /wines?min_price=10&max_price=20&sort_by=note.asc
GET /wines?min_price=10&max_price=20&sort_by=note.desc


## Backlog

[MVP1] : 
  * [X] App fonctionnelle avec 1 opération simple GET /wines/:id, retourne le nom, prix, url, et note (vide a ce stade)
  * [X] [OPTION] Page web qui documente permet de tester l'api
  * [X] ajouter une note de dégustation : POST /wines/:id/reviews
[MVP 2] ; 
  * [X] Créer POST et GET /search : cette ressource permet de sauvegarder les critères d'une recherche avec min_price, max_price, et également un paramètre  "notification_email" 
  * [ ] Refacto : créer un Service Object responsable de créer un nouveau vin dans le catalogue, avec également un POST /wines au niveau controlleur
  * [ ] Créer un Service Object qui pour un vin passé en paramètre, identifie les /search qui matchent, et envoie un email à l'utilisateur



## Notes en vrac

### Ressources

https://levelup.gitconnected.com/7-steps-to-create-an-api-in-rails-2f984c7c4286
https://medium.com/@oliver.seq/creating-a-rest-api-with-rails-2a07f548e5dc
https://medium.com/swlh/how-to-build-an-api-with-ruby-on-rails-28e27d47455a
https://guides.rubyonrails.org/api_app.html

rails new EnergieVinApi --api
cd EnergieVinApi/
rails g resource Wine name:string price:float store_url:string note:float

rails g controller api/v1/wines

### Commandes

    rake rswag  # génère la doc swagger
    rake test:all  # exec tous les tests (yc rswag)
    rails s # lance le serveur

