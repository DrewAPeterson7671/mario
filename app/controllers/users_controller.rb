class UsersController < ApplicationController
  before_action :current_user, only: [:show, :edit, :update, :destroy]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    @user.avatar_pic.attach(params[:user][:avatar_pic])
    if @user.save
      flash[:notice] = "You've successfully signed up!"
      session[:user_id] = @user.id
      redirect_to "/"
    else
      flash[:alert] = "There was a problem signing up."
      redirect_to '/signup'
    end
  end

  def show
    @user = current_user
    render :show
  end  

  def edit
    @user = current_user
    render :edit
  end  

  def update
    @user = current_user

    if @user.update(user_params)
      flash[:notice] = "Profile successfully updated!"
      redirect_to user_path(@user)
    else
      render :edit
      flash[:notice] = "Something went wrong. Please contact Mario's technical assistance staff."
    end
  end

  ## was this just reference and not verbatim?
  
  def average_rating
    (BigDecimal(reviews.sum(:rating).to_s) / BigDecimal(reviews.count.to_s)).round(1)
  end

  def review_count
    reviews.count
  end

  def last_updated_review
    reviews.order('updated_at')
  end

  def index
    case
    when params[:az]
      @users_sort = User.order('user_name ASC')
    when params[:za]
      @users_sort = User.order('user_name DESC')
    when params[:high_rating]
      @users_sort = User.all.sort_by(&:average_rating).reverse
    when params[:low_rating]
      @users_sort = User.all.sort_by(&:average_rating)
    when params[:most_reviews]
      @users_sort = User.all.sort_by(&:review_count)
    when params[:least_reviews]
      @users_sort = User.all.sort_by(&:review_count)
    when params[:most_recent]
      @users_sort = User.all.sort_by(&:last_updated_review)
    when params[:least_recent]
      @users_sort = User.all.sort_by(&:last_updated_review).reverse.reverse_order
    else
      @users_sort = User.all
    end
    @users = @users_sort.paginate(page: params[:page], per_page: 20)
    render :index
  end

  private
  
  def user_params
    params.require(:user).permit(:email, :user_name, :password, :password_confirmation, :admin, :avatar_pic)
  end
end
