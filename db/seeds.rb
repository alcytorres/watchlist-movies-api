# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


movie = Movie.new(
  name: "Once Upon a Time in the West",
  image_url: "https://cdn.shopify.com/s/files/1/0057/3728/3618/products/oncedec20_500x749.jpg?v=1647437643",
  description: "A mysterious stranger with a harmonica joins forces with a notorious desperado to protect a beautiful widow from a ruthless assassin working for the railroad.",
  director: "Sergio Leone",
  release_year: 1968
)
movie.save

movie = Movie.new(
  name: "2001: A Space Odyssey",
  image_url: "https://cdn.shopify.com/s/files/1/0057/3728/3618/products/ItemR85337_500x749.jpg?v=1605904174",
  description: "After uncovering a mysterious artifact buried beneath the Lunar surface, a spacecraft is sent to Jupiter to find its origins: a spacecraft manned by two men and the supercomputer HAL 9000.",
  director: "Stanley Kubrick",
  release_year: 1968
)
movie.save


movie = Movie.new(
  name: "Heat",
  image_url: "https://cdn.shopify.com/s/files/1/0057/3728/3618/files/heat.mpw.119090_500x749.jpg?v=1708452299",
  description: "A group of high-end professional thieves start to feel the heat from the LAPD when they unknowingly leave a verbal clue at their latest heist.",
  director: "Michael Mann",
  release_year: 1995
)
movie.save


movie = Movie.new(
  name: "Inception",
  image_url: "https://cdn.shopify.com/s/files/1/0057/3728/3618/files/inception.mpw.123395_9e0000d1-bc7f-400a-b488-15fa9e60a10c_500x749.jpg?v=1708527589",
  description: "A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a C.E.O., but his tragic past may doom the project and his team to disaster.",
  director: "Christopher Nolan",
  release_year: 2010
)
movie.save
