class ProductsController < ApplicationController
  before_action :authorize, only: [:new, :create, :edit, :update, :destroy]

  def index
    @products = Product.all.paginate(page: params[:page], per_page: 12)
    @most_reviews = Product.most_reviewed
    @newest_products = Product.newest_product
    @highest_revieweds = Product.highest_reviewed
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
    @product_reviews = @product.reviews.paginate(page: params[:page], per_page: 10)
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


end
