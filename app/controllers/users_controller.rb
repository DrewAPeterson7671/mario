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

  def index
    case
    when params[:az]
      @users = User.order('user_name').paginate(page: params[:page], per_page: 20)
    when params[:za]
      @users = User.order('user_name DESC').paginate(page: params[:page], per_page: 20)
    when params[:high_rating]
      "High Rating"
    when params[:low_rating]
      "Low Rating"
    when params[:most_reviews]
      @users = User.user_most_reviewed.paginate(page: params[:page], per_page: 20)
    when params[:least_reviews]
      @users = User.user_most_reviewed.reverse_order.paginate(page: params[:page], per_page: 20)
    when params[:most_recent]
      @users = User.users_most_recent.paginate(page: params[:page], per_page: 20)
    when params[:least_recent]
      @users = User.users_most_recent.reverse_order.paginate(page: params[:page], per_page: 20)
    else
      @users = User.all.paginate(page: params[:page], per_page: 20)
    end
    render :index
  end
  
  

  private
  
  def user_params
    params.require(:user).permit(:email, :user_name, :password, :password_confirmation, :admin, :avatar_pic)
  end
end
