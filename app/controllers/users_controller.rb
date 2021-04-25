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

    ## link_to 'Name', casinos_path(:sort_param => "name")

    ## @users = User.all.paginate(page: params[:page], per_page: 20)
    
    case
    when params[:az]
      # @sorted = @users.sort_by { |user| [user.user_name ? 1 : 0, user.user_name] }
      @users = User.order('user_name').paginate(page: params[:page], per_page: 20)
    when params[:za]
      # @sorted = @users.sort_by { |user| [user.user_name ? 1 : 0, user.user_name] }
      @users = User.order('user_name DESC').paginate(page: params[:page], per_page: 20)
    when params[:high_rating]
      ## create Hash from average rating with user Id, sort it, then reference each ID to push to a new hash? and display that
      "High Rating"
    when params[:low_rating]
      "Low Rating"
    when params[:most_reviews]
      "Most Reviews"
    when params[:least_reviews]
      "Least Reviews"
    when params[:most_recent]
      "Most Recent"
    when params[:least_recent]
      "Least Recent"
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
