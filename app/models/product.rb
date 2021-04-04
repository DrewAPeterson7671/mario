class Product < ApplicationRecord
  has_many :reviews, dependent: :destroy
  validates :name, presence: true
  validates_length_of :name, maximum: 30
  validates :price, presence: true
  validates_length_of :price, maximum: 8
  validates :country, presence: true
  validates_length_of :country, maximum: 50

  has_one_attached :product_photo

  before_save(:titleize_product)

  scope :most_reviewed, -> {(
    select("products.id, products.name, products.price, products.country, count(reviews.id) as reviews_count")
    .joins(:reviews)
    .group("products.id")
    .order("reviews_count DESC")
    .limit(6)
    )}

  scope :newest_product, -> {  order(created_at: :desc).limit(6) }

  scope :made_usa, -> { where(country: "United States Of America").limit(6) }

  scope :search, -> (name_parameter) { where("name like ?", "%#{name_parameter}%").limit(6) }

  private
    def titleize_product
      self.name = self.name.titleize
      self.country = self.country.titleize
    end
end
