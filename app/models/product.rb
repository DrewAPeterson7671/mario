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

  def self.check_product_scopes(id)
    @product = Product.find_by(id: id)
    case 
    when Product.highest_reviewed.first(6).any? { |h| h[:id] == @product.id }
      return ('<div class="arrow-top-reviewed"><span>Top Rated</span></div>').html_safe
    when Product.most_reviewed.first(6).any? { |h| h[:id] == @product.id }
      @most = Product.most_reviewed.find(@product.id)
      return ('<div class="arrow-most-reviewed"><span>' + (@most.reviews_count.to_s) + ' Reviews</span></div>').html_safe
    when Product.newest_product.any? { |h| h[:id] == @product.id }
      return ('<div class="arrow-new"><span>New!</span></div>').html_safe
    end
  end

  def self.search(search)
    where("lower(reviews.author) LIKE :search OR lower(products.name) LIKE :search OR lower(reviews.content_body) LIKE :search", search: "%#{search.downcase}%").uniq
  end

  def self.next1()
    ## first get the current id
    ## then get the current collection?
    p = @products
        # need to define id
        # @products = Product.most_reviewed WORKED
        
        # @product = p.find_by(id: 61) WORKED
        # @most = Product.most_reviewed.find(@product.id) WORKED
        # @most = p.find(@product.id) WORKED
    
        
        
        # _index_find = @products.index { |p| p[:id] == @product.id }
        # _next_index = _index_find + 1
        # @products[_next_index]
        # _total_length = @products.length - 1
        # if _next_index  == _total_length
        #   @products[0]
        # else 
        #   @products[_next_index]
        # end


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
