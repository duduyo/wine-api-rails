# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Wine.destroy_all

wine1 = Wine.create(
  name: "Chateau Montelena",
  price_euros: 60,
  store_url: "https://www.vinmonopolet.no/Land/USA/Chateau-Montelena-Chardonnay/p/1187501",
  note: nil
)

Review.create(wine: wine1, note: 4, comment: "Cool")
Review.create(wine: wine1, note: 5, comment: "Great wine!")
Review.create(wine: wine1, note: 1, comment: "Not my taste")

wine2 = Wine.create(
  name: "Chateau Montelena Cabernet Sauvignon",
  price_euros: 50,
  store_url: "https://www.vinmonopolet.no/Land/USA/Chateau-Montelena-Cabernet-Sauvignon/p/1187502",
  note: nil
)

wine3 = Wine.create(
  name: "Chateau Montelena Zinfandel",
  price_euros: 40,
  store_url: "https://www.vinmonopolet.no/Land/USA/Chateau-Montelena-Zinfandel/p/1187503",
  note: nil
)
