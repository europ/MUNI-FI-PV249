class Issue < ApplicationRecord
  validates :subject, presence: true
  validates :text, presence: true

  belongs_to :repository
  belongs_to :user
end
