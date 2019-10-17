class User < ApplicationRecord
  validates :name, presence: true, uniqueness: true, format: { with: /\A[a-z]+\z/, message: "must be '\\A[a-z]+\\z'!" }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be email!" }

  has_secure_password

  has_many :repositories
  has_many :issues, through: :repositories

  def password_digest
    "#{password_salt}#{password_hash}"
  end

  def password_digest=(digest)
    self.password_salt = digest.salt
    self.password_hash = digest.checksum
  end
end
