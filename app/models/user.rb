class User < ApplicationRecord
  attr_accessor :password
  validates_confirmation_of :password
  validates :email, :presence => true, :uniqueness => true
  validates :user_name, :presence => true, :uniqueness => true
  before_save :encrypt_password
  
  has_many :reviews
  has_one_attached :avatar_pic


  scope :users_most_recent, -> {(
    select('users.id, users.user_name, max(reviews.updated_at) as reviews_updated_at')
    .joins(:reviews)
    .group('users.id')
    .order('reviews_updated_at DESC')
    )}

  scope :user_most_reviewed, -> {(
    select("users.id, users.user_name, count(reviews.user_id) as reviews_count")
    .joins(:reviews)
    .group("users.id")
    .order("reviews_count DESC")
    )}
    
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
