class Repository < ApplicationRecord
  has_many :issues

  belongs_to :user
end
