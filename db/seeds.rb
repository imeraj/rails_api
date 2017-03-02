# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
50.times do
     email = Faker::Internet.email
     password = "password"
     User.create!(email: email,
                  password: password,
				  password_confirmation: password)
end

users = User.all
users.each do |user|
    50.times do |i|
        title = Faker::Commerce.product_name
        price = Faker::Commerce.price
        published = i.even? ? true: false

        user.products.create!(title: title, price: price, published: published)
    end
end
