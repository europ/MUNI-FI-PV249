class User < ApplicationRecord
  validates :name, presence: true, uniqueness: true, format: { with: /\A[a-z]+\z/, message: "User name must be '\\A[a-z]+\\z'!" }

  has_secure_password

  has_many :repositories
  has_many :issues
end
