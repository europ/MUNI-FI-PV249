class Repository < ApplicationRecord
  validates :name, presence: true

  has_many :issues, :dependent => :destroy

  belongs_to :user
end
