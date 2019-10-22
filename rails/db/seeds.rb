# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

User.create(id: 1, name: 'asd', email: Faker::Internet.unique.safe_email, password: 'asd')
2.upto(10) { |i| User.create(id: i, name: Faker::Name.unique.first_name.downcase, email: Faker::Internet.unique.safe_email, password: 'pswd') }

1.upto(9)   { |i| Repository.create(id: i, name: Faker::Lorem.unique.word, user_id: i) }
10.upto(14) { |i| Repository.create(id: i, name: Faker::Lorem.unique.word, user_id: 1) }
15.upto(20) { |i| Repository.create(id: i, name: Faker::Lorem.unique.word, user_id: 2) }

1.upto(9)   { |i| Issue.create(id: i, subject: Faker::Lorem.unique.word, text: Faker::Lorem.unique.sentence, repository_id: i,    user_id: i % 10) }
10.upto(14) { |i| Issue.create(id: i, subject: Faker::Lorem.unique.word, text: Faker::Lorem.unique.sentence, repository_id: 1,    user_id: i % 10) }
15.upto(20) { |i| Issue.create(id: i, subject: Faker::Lorem.unique.word, text: Faker::Lorem.unique.sentence, repository_id: i-14, user_id: i % 10) }
