class Product < ApplicationRecord
  has_many :reviews, dependent: :destroy
  validates :name, presence: true
  validates_length_of :name, maximum: 30
  validates :price, presence: true
  validates_length_of :price, maximum: 8
  validates :country, presence: true
  validates_length_of :country, maximum: 50

  has_one_attached :product_photo

  after_initialize do
    if self.new_record?
      self.average_review = 0.0001
    end
  end
  

  before_save(:titleize_product)

  scope :most_reviewed, -> {(
    select("products.id, products.name, products.average_review,products.price, products.country, count(reviews.id) as reviews_count")
    .joins(:reviews)
    .group("products.id")
    .order("reviews_count DESC")
    )}

  scope :newest_product, -> {  order(created_at: :desc).limit(6) }

  scope :highest_reviewed, -> {(
    select("products.id, products.name, products.price, products.country, products.average_review as average_review")
    .joins(:reviews)
    .group("products.id")
    .order("average_review DESC")
    )}

  scope :products_most_recent, -> {(
    select('products.id, products.name, products.price, products.average_review, products.country, max(reviews.updated_at) as reviews_updated_at')
    .joins(:reviews)
    .group('products.id')
    .order('reviews_updated_at DESC')
    )}


  def self.search(search)
    where("lower(reviews.author) LIKE :search OR lower(products.name) LIKE :search OR lower(reviews.content_body) LIKE :search", search: "%#{search.downcase}%").uniq
  end

  def next
    # _next_index = @products_sort.map(&:id).index(id) + 1
    # _total_length = @products_sort.length
    # if _next_index  == _total_length
    #   @products_sort[0]
    # else 
    #   @products_sort[_next_index]
    # end
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
