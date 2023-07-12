class Merchant < ApplicationRecord
  # attr_accessor :name
  has_many :items
end