class ReviewsController < ApplicationController
  before_action :authorize, only: [:new, :create, :edit, :update, :destroy]

  def index
    case
    when params[:az]
      @reviews_sort = Review.order('author ASC')
    when params[:za]
      @reviews_sort = Review.order('author DESC')
    when params[:product_az]
      @reviews_sort = Review.review_product_name
    when params[:product_za]
      @reviews_sort = Review.review_product_name.reverse_order
    when params[:high_rating]  
      @reviews_sort = Review.order('rating::integer DESC')
    when params[:low_rating]  
      @reviews_sort = Review.order('rating::integer ASC')
    when params[:most_recent]
      @reviews_sort = Review.order('created_at DESC')
    when params[:least_recent]
      @reviews_sort = Review.order('created_at ASC')
    else
      @reviews_sort = Review.all
    end
    @reviews = @reviews_sort.paginate(page: params[:page], per_page: 30)
    @users = User.all
    @products = Product.all
    render :index
  end
  
  def new
    @product = Product.find(params[:product_id])
    @review = @product.reviews.new
    render :new
  end

  def create
    @product = Product.find(params[:product_id])
    @review = @product.reviews.new(review_params.merge(:author => current_user.user_name, :user_id => current_user.id))
    if @review.save
      flash[:notice] = "Review successfully added!"
      redirect_to product_path(@product)
    else
      render :new
    end
  end

  def show
    @product = Product.find(params[:product_id])
    @review = Review.find(params[:id])
    @user = User.find_by(id: @review.user_id)
    render :show
  end

  def edit
    @product = Product.find(params[:product_id])
    @review = Review.find(params[:id])
    render :edit
  end

  def update
    @review = Review.find(params[:id])
    if @review.update(review_params)
      flash[:notice] = "Review successfully updated!"
      redirect_to product_path(@review.product)
    else
      render :edit
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    flash[:notice] = "Review successfully removed!"
    redirect_to product_path(@review.product)
  end

  private
    def review_params
      params.require(:review).permit(:author, :content_body, :rating, :product_id, :user_id)
    end

end
