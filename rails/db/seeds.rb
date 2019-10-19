# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

=begin
User(id=1):
    - Repo(id=1)
      - Issue(id=1)
      - Issue(id=7)
      - Issue(id=8)
      - Issue(id=9)
    - Repo(id=7)
    - Repo(id=8)
    - Repo(id=9)

User(id=2):
    - Repo(id=2)
      - Issue(id=2)
      - Issue(id=10)
      - Issue(id=11)
      - Issue(id=12)
    - Repo(id=10)
    - Repo(id=11)
    - Repo(id=12)

Other users has one repository with one issue.
=end

User.create(id: 1, name: 'asd', email: Faker::Internet.unique.safe_email, password: 'asd')
User.create(id: 2, name: Faker::Name.unique.first_name.downcase, email: Faker::Internet.unique.safe_email, password: 'pswd')
User.create(id: 3, name: Faker::Name.unique.first_name.downcase, email: Faker::Internet.unique.safe_email, password: 'pswd')
User.create(id: 4, name: Faker::Name.unique.first_name.downcase, email: Faker::Internet.unique.safe_email, password: 'pswd')
User.create(id: 5, name: Faker::Name.unique.first_name.downcase, email: Faker::Internet.unique.safe_email, password: 'pswd')
User.create(id: 6, name: Faker::Name.unique.first_name.downcase, email: Faker::Internet.unique.safe_email, password: 'pswd')

Repository.create(id: 1, name: Faker::Lorem.unique.word, user_id: 1)
Repository.create(id: 2, name: Faker::Lorem.unique.word, user_id: 2)
Repository.create(id: 3, name: Faker::Lorem.unique.word, user_id: 3)
Repository.create(id: 4, name: Faker::Lorem.unique.word, user_id: 4)
Repository.create(id: 5, name: Faker::Lorem.unique.word, user_id: 5)
Repository.create(id: 6, name: Faker::Lorem.unique.word, user_id: 6)

Repository.create(id: 7, name: Faker::Lorem.unique.word, user_id: 1)
Repository.create(id: 8, name: Faker::Lorem.unique.word, user_id: 1)
Repository.create(id: 9, name: Faker::Lorem.unique.word, user_id: 1)

Repository.create(id: 10, name: Faker::Lorem.unique.word, user_id: 2)
Repository.create(id: 11, name: Faker::Lorem.unique.word, user_id: 2)
Repository.create(id: 12, name: Faker::Lorem.unique.word, user_id: 2)

Issue.create(id: 1, subject: Faker::Lorem.unique.word, text: Faker::Lorem.unique.sentence, repository_id: 1)
Issue.create(id: 2, subject: Faker::Lorem.unique.word, text: Faker::Lorem.unique.sentence, repository_id: 2)
Issue.create(id: 3, subject: Faker::Lorem.unique.word, text: Faker::Lorem.unique.sentence, repository_id: 3)
Issue.create(id: 4, subject: Faker::Lorem.unique.word, text: Faker::Lorem.unique.sentence, repository_id: 4)
Issue.create(id: 5, subject: Faker::Lorem.unique.word, text: Faker::Lorem.unique.sentence, repository_id: 5)
Issue.create(id: 6, subject: Faker::Lorem.unique.word, text: Faker::Lorem.unique.sentence, repository_id: 6)

Issue.create(id: 7, subject: Faker::Lorem.unique.word, text: Faker::Lorem.unique.sentence, repository_id: 1)
Issue.create(id: 8, subject: Faker::Lorem.unique.word, text: Faker::Lorem.unique.sentence, repository_id: 1)
Issue.create(id: 9, subject: Faker::Lorem.unique.word, text: Faker::Lorem.unique.sentence, repository_id: 1)

Issue.create(id: 10, subject: Faker::Lorem.unique.word, text: Faker::Lorem.unique.sentence, repository_id: 10)
Issue.create(id: 11, subject: Faker::Lorem.unique.word, text: Faker::Lorem.unique.sentence, repository_id: 11)
Issue.create(id: 12, subject: Faker::Lorem.unique.word, text: Faker::Lorem.unique.sentence, repository_id: 12)
