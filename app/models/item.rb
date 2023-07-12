class Item < ApplicationRecord
  # attr_accessor :name, 
  #               :description,
  #               :unit_price,
  #               :merchant_id
  belongs_to :merchant
end