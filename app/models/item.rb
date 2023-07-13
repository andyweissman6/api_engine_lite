class Item < ApplicationRecord
  belongs_to :merchant

  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :unit_price
  validates_presence_of :merchant_id

  # validates :name, 
  #           :description,
  #           :unit_price,
  #           :merchant_id
  # presence: true

end