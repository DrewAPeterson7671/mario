class Review < ApplicationRecord
  belongs_to :product
  belongs_to :user
  validates :author, presence: true
  validates_length_of :author, maximum: 40
  validates :content_body, presence: true
  validates_length_of :content_body, maximum: 250
  validates :rating, presence: true
  validates :rating, presence: true
  validates_numericality_of :rating, only_integer: true
  validates_numericality_of :rating, less_than_or_equal_to: 5
  validates_numericality_of :rating, greater_than_or_equal_to: 1

  before_save(:titleize_review)

  scope :review_product_name, -> {(
    select("reviews.*, products.name as products_name")
    .joins(:product)
    .group("reviews.id, products.name")
    .order("products_name ASC")
    )}
 
  def next
    Review.where("id > ?", id).order("id ASC").first || Review.first
  end

  def previous
    Review.where("id < ?", id).order("id DESC").first || Review.last
  end
  
  private
    def titleize_review
      self.author = self.author.titleize
    end
end
