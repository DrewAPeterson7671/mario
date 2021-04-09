class User < ApplicationRecord
  attr_accessor :password
  validates_confirmation_of :password
  validates :email, :presence => true, :uniqueness => true
  validates :user_name, :presence => true, :uniqueness => true
  before_save :encrypt_password

  attr_accessor :remove_avatar

  has_one_attached :avatar_pic

  after_save :purge_avatar, if: :remove_avatar
  private def purge_avatar
    avatar_pic.purge
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
