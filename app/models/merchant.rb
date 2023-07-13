class Merchant < ApplicationRecord
  has_many :items

  validates_presence_of :name
  # validates :name, presence: true
  
end