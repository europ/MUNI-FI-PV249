class User < ApplicationRecord
  validates :name, presence: true, uniqueness: true, format: { with: /\A[a-z]+\z/, message: "User name must be '\\A[a-z]+\\z'!" }
end
