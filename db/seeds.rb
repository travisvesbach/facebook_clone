# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(name: "Dan Branson", first_name: "Dan", last_name: "Branson", email: "dan.branson@example.com", password: "foobar", password_confirmation: "foobar")

User.create!(name: "Guy Johnson", first_name: "Guy", last_name: "Johnson", email: "guy.johnson@example.com", password: "foobar", password_confirmation: "foobar")

User.create!(name: "Jerry Maliker", first_name: "Jerry", last_name: "Maliker", email: "jerry.maliker@example.com", password: "foobar", password_confirmation: "foobar")

User.create!(name: "Sarah Weber", first_name: "Sarah", last_name: "Weber", email: "sarah.weber@example.com", password: "foobar", password_confirmation: "foobar")

User.create!(name: "Lucy Grey", first_name: "Lucy", last_name: "Grey", email: "lucy.grey@example.com", password: "foobar", password_confirmation: "foobar")

User.all.each do |user|
	5.times do |n|
		Friendship.create!(user: user, friend: User.find_by(id: n+1), accepted: true) unless user == User.find_by(id: n+1)
	end
end

comments_array = ["wow!", "hmmmm", "We need to meet soon!", "crazy, just crazy...", "This makes me happy :)", ":D", "^_^", "What is this from?", "agree", "I like this"]

25.times do 
	Post.create!(user: User.find_by(id: 1), content: Faker::StarWars.quote, created_at: Faker::Time.between(15.days.ago, 1.days.ago))
end

5.times do |n|
	5.times do
		Comment.create!(user: User.find_by(id: n+1), post: Post.find_by(id: 1 + rand(25)), content: comments_array[rand(10)])
	end
end

25.times do 
	Post.create!(user: User.find_by(id: 2), content: Faker::Food.ingredient, created_at: Faker::Time.between(15.days.ago, 1.days.ago))
end

5.times do |n|
	5.times do
		Comment.create!(user: User.find_by(id: n+1), post: Post.find_by(id: 26 + rand(25)), content: comments_array[rand(10)])
	end
end

25.times do 
	Post.create!(user: User.find_by(id: 3), content: Faker::HarryPotter.quote, created_at: Faker::Time.between(15.days.ago, 1.days.ago))
end

5.times do |n|
	5.times do 
		Comment.create!(user: User.find_by(id: n+1), post: Post.find_by(id: 51 + rand(25)), content: comments_array[rand(10)])
	end
end

25.times do 
	Post.create!(user: User.find_by(id: 4), content: Faker::GameOfThrones.city, created_at: Faker::Time.between(15.days.ago, 1.days.ago))
end

5.times do |n|
	5.times do 
		Comment.create!(user: User.find_by(id: n+1), post: Post.find_by(id: 76 + rand(25)), content: comments_array[rand(10)])
	end
end

25.times do 
	Post.create!(user: User.find_by(id: 5), content: Faker::Book.title, created_at: Faker::Time.between(15.days.ago, 1.days.ago))
end

5.times do |n|
	5.times do 
		Comment.create!(user: User.find_by(id: n+1), post: Post.find_by(id: 101 + rand(25)), content: comments_array[rand(10)])
	end
end



