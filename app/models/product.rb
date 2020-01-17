class Product < ApplicationRecord
  has_many :reviews, dependent: :destroy
  validates :name, presence: true
  validates_length_of :name, maximum: 30
  validates :price, presence: true
  validates_length_of :name, maximum: 8
  
end
