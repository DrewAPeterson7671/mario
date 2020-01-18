# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Product.destroy_all
Review.destroy_all

50.times do |index|
  products = []
  products.push(Product.create!(name: Faker::TvShows::BreakingBad.episode, price: Faker::Superhero.name, country: Faker::Superhero.name))
  products
  50.times do |review|
    products.each do |product|
    Review.create! :name => Faker::Superhero.name,
                    :author => Faker::ChuckNorris.fact,
                    :rating => rand(1..5),
                    :product_id => product.id
    end
  end
end

p "Created #{Product.count} products"
