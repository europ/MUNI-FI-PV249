class Repository < ApplicationRecord
  has_many :issues

  belongs_to :users
end
