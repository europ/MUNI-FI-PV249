class Issue < ApplicationRecord
  belongs_to :users
  belongs_to :repositories
end
