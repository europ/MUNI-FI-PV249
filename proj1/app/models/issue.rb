class Issue < ApplicationRecord
  has_one :users, through: :repository
  belongs_to :repository
end
