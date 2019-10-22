# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

User.create(id: 0, name: 'asd', email: Faker::Internet.unique.safe_email, password: 'asd')

for i in 1..3
  user = User.create(name: Faker::Name.unique.first_name.downcase, email: Faker::Internet.unique.safe_email, password: 'pswd')
  for j in 1..3
    repo = Repository.create(name: Faker::Lorem.unique.word, user_id: user.id)
    for k in 1..3
      Issue.create(subject: Faker::Lorem.unique.word, text: Faker::Lorem.unique.sentence, repository_id: repo.id, user_id: user.id)
    end
  end
end
