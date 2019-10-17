class Repository < ApplicationRecord
  validates :name, presence: true

  has_many :issues

  belongs_to :user
end
