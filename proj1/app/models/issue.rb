class Issue < ApplicationRecord
  belongs_to :repository

  has_one :user, through: :repository
end
