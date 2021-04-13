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
    select("products.id, products.name, products.average_review,products.price, products.country, count(reviews.id) as reviews_count")
    .joins(:reviews)
    .group("products.id")
    .order("reviews_count DESC")
    .limit(6)
    )}

  scope :newest_product, -> {  order(created_at: :desc).limit(6) }

  scope :highest_reviewed, -> {(
    select("products.id, products.name, products.price, products.country, products.average_review as average_review")
    .joins(:reviews)
    .group("products.id")
    .order("average_review DESC")
    .limit(6)
    )}

  # scope :search, -> (name_parameter) { where("name like ?", "%#{name_parameter}%").limit(100) }

  def self.search(search)
    where("lower(reviews.author) LIKE :search OR lower(products.name) LIKE :search OR lower(reviews.content_body) LIKE :search", search: "%#{search.downcase}%").uniq
  end

  def next
    Product.where("id > ?", id).order("id ASC").first || Product.first
  end

  def previous
    Product.where("id < ?", id).order("id DESC").first || Product.last
  end

  private
    def titleize_product
      self.name = self.name.titleize
      self.country = self.country.titleize
    end
end
