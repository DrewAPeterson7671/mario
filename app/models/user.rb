class User < ApplicationRecord
  attr_accessor :password
  validates_confirmation_of :password
  validates :email, :presence => true, :uniqueness => true
  validates :user_name, :presence => true, :uniqueness => true
  before_save :encrypt_password

  has_one_attached :avatar_pic
  has_many :reviews

  def self.user_reviews(user_id)
    @user_reviews = Review.where(user_id: user_id).count
  end

  def self.user_ave_rating(user_id)
    _average_reviews = []
    _rev_count = 0
    _new_average = 0.0
    _average_reviews = Review.where(user_id: user_id)
    _average_reviews.each do |average_review|
      _rev_count += average_review.rating
    end
    _new_average = (_rev_count / _average_reviews.length.to_f).round(1)
  end

  def self.user_latest_review(user_id)
    @latest_review = Review.where(user_id: user_id).where('created_at < ? ', Time.now).order('created_at DESC').first
    if @latest_review.nil?
      last_review = {}
      else
        last_review = @latest_review.created_at.strftime('%m-%d-%Y')
    end
  end

  # def self.sort_users(sort_type)
  #   ## I think this must be part of Each controller so I can access each of them

  #   ## date sort
  #   ## @projects = Project.all.sort { |p1, p2| p1.created_at <=> p2.created_at }
  #   ## same as
  #   ## @projects = Project.all.sort_by &:created_at

  #   case sort_type
  #   when "A-Z"
  #     @sorted = @users.sort_by { |user| [user.user_name ? 1 : 0, user.user_name] }
  #   when "Z-A"
  #     @sorted = @users.sort_by { |user| [user.user_name ? 0 : 1, user.user_name] }
  #   when "High Rating"
  #     ## create Hash from average rating with user Id, sort it, then reference each ID to push to a new hash? and display that
  #     "High Rating"
  #   when "Low Rating"
  #     "Low Rating"
  #   when "Most Reviews"
  #     "Most Reviews"
  #   when "Least Reviews"
  #     "Least Reviews"
  #   when "Most Recent"
  #     "Most Recent"
  #   when "Least Recent"
  #     "Least Recent"
  #   end
  # end

  def encrypt_password
    self.password_salt = BCrypt::Engine.generate_salt
    self.password_hash = BCrypt::Engine.hash_secret(password,password_salt)
  end

  def self.authenticate(email, password)
    user = User.find_by "email = ?", email
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end


end
