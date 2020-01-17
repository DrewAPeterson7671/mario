class Review < ApplicationRecord
  belongs_to :product
  validates :author, presence: true
  validates_length_of :author, maximum: 30
  validates :content_body, presence: true
  validates_length_of :content_body, minimum: 50
  validates_length_of :content_body, maximum: 250
end
