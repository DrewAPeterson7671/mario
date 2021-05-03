class ProductsController < ApplicationController
  before_action :authorize, only: [:new, :create, :edit, :update, :destroy]

  after_action :set_product_sort, only: [:index, :show, :next, :previous]


  def index
    @products = set_product_sort.paginate(page: params[:page], per_page: 12)
    render :index
  end

  def new
    @product = Product.new
    render :new
  end
  
  def create
    @product = Product.new(product_params)
    @product.product_photo.attach(params[:product][:product_photo])
    if @product.save
      flash[:notice] = "Product successfully added!"
      redirect_to products_path
    else
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
    render :edit
  end

  def show
    @product = Product.find(params[:id])
    average_review(@product.id)
    case
    when params[:prod_az]
      @product_reviews_sort = @product.reviews.order('author ASC')
    when params[:prod_za]
      @product_reviews_sort = @product.reviews.order('author DESC')
    when params[:prod_high_rating]  
      @product_reviews_sort = @product.reviews.order('rating::integer DESC')
    when params[:prod_low_rating]  
      @product_reviews_sort = @product.reviews.order('rating::integer ASC')
    when params[:prod_most_recent]
      @product_reviews_sort = @product.reviews.order('created_at DESC')
    when params[:prod_least_recent]
      @product_reviews_sort = @product.reviews.order('created_at ASC')
    else
      @product_reviews_sort = @product.reviews
    end
    @product_reviews = @product_reviews_sort.paginate(page: params[:page], per_page: 10)
    @number_reviews = number_reviews(@product)
    render :show
  end

  def update
    @product= Product.find(params[:id])
    if @product.update(product_params)
      flash[:notice] = "Product successfully updated!"
      redirect_to products_path
    else
      render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    flash[:notice] = "Product successfully removed!"
    redirect_to products_path
  end

  def average_review(product_id)
    _average_reviews = []
    _rev_count = 0
    _new_average = 0.0
    _average_reviews = Review.where(product_id: @product.id)
    _average_reviews.each do |average_review|
      _rev_count += average_review.rating
    end
    _new_average = (_rev_count / _average_reviews.length.to_f).round(1)
    @product.update_attributes(average_review: _new_average)
  end

  def number_reviews(product_id)
    _gather_reviews = Review.where(product_id: @product.id).count
  end

  private
    def product_params
      params.require(:product).permit(:name, :price, :country, :product_photo, :average_review)
    end

    def set_product_sort
      case
      when params[:highest_price]
        @products_sort = Product.order('price::float DESC')
      when params[:lowest_price]
        @products_sort = Product.order('price::float ASC')
      when params[:az]
        @products_sort = Product.order('name ASC')
      when params[:za]
        @products_sort = Product.order('name DESC')
      when params[:highest_rated]
        @products_sort = Product.order('average_review::float DESC')
      when params[:lowest_rated]
        @products_sort = Product.order('average_review::float ASC')
      when params[:most_reviews]
        @products_sort = Product.most_reviewed
      when params[:least_reviews]
        @products_sort = Product.most_reviewed.reverse_order
      when params[:most_recent]
        @products_sort = Product.products_most_recent
      when params[:least_recent]
        @products_sort = Product.products_most_recent.reverse_order
      when params[:most_recent_added]
        @products_sort = Product.order('created_at DESC')
      when params[:least_recent_added]
        @products_sort = Product.order('created_at DESC')
      else
        @products_sort = Product.all
      end
      @@product_sort = @products_sort
    end
      

end
