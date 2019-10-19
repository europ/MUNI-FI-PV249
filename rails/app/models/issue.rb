class Issue < ApplicationRecord
  validates :subject, presence: true
  validates :text, presence: true

  belongs_to :repository

  has_one :user, through: :repository
end
