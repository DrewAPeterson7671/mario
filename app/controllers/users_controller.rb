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
      @users_sort = User.order('user_name ASC NULLS LAST')
    when params[:za]
      @users_sort = User.order('user_name DESC NULLS LAST')
    when params[:most_reviews]
      @users_sort = User.user_most_reviewed
    when params[:least_reviews]
      @users_sort = User.user_most_reviewed.reverse_order
    when params[:most_recent]
      @users_sort = User.users_most_recent
    when params[:least_recent]
      @users_sort = User.users_most_recent.reverse_order
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
