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
  products.push(Product.create!(name: Faker::Food.fruits, price: Faker::Number.decimal(l_digits: 2), country: Faker::Address.country))
  products
  50.times do |review|
    products.each do |product|
    Review.create! :author => Faker::TvShows::Simpsons.character,
                    :content_body => Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 4),
                    :rating => rand(1..5),
                    :product_id => product.id
    end
  end
end

p "Created #{Product.count} products"
