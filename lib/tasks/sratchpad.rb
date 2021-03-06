



## turning authors into users
r = Review.find_by(author: "Birchibald \"Birch\" T. Barlow")
r.update_attributes(author: "Birchibald T Barlow")



@birchs = Review.where(author: "Birchibald \"Birch\" T. Barlow")
@birchs.each do |birch|
  birch.update_attributes(author: "Birchibald T Barlow")
  birch.save
end

@diamonds = Review.where(author: "Mayor \"Diamond Joe\" Quimby")
@diamonds.each do |diamond|
  diamond.update_attributes(author: "Mayor Diamond Joe Quimby")
  diamond.save
end


@authors_unfiltered = []
@authors = []
@reviews = Review.all
@reviews.each do |review|
  @authors_unfiltered.push(review.author)
end
@authors = @authors_unfiltered.uniq

@review_id = []
_fix_author = ""
_user_new_id = 0

@authors.each do |author|
  _fix_author = author.downcase.gsub(" ", "_")
  User.create!(user_name: author, email: _fix_author + "@springfield.net", password:"pass", password_confirmation: "pass")
end

@reviews = Reviews.all
@reviews.each do |review|
  _user_new_id = User.find_by(user_name: review.author)
  review.update_attributes(user_id: _user_new_id.id)
end


## average review test

_average_reviews = []
_rev_count = 0
_new_average = 0.0
@product = Product.find_by(id: 75)

_average_reviews = Review.where(product_id: @product.id)
_average_reviews.each do |average_review|
  _rev_count += average_review.rating
end
_new_average = (_rev_count / _average_reviews.length.to_f).round(1)
@product.update_attributes(average_review: _new_average)


class UserList
  def self.order_users_by(order_value)
    case order_value
    when :az
      User.order('user_name ASC')
    when :za
      User.order('user_name DESC')
    when :high_rating
      User.all.sort_by(&:average_rating).reverse
    when :low_rating
      User.all.sort_by(&:average_rating)
    when :most_reviews
      User.all.sort_by(&:review_count).reverse
    when :least_reviews
      User.all.sort_by(&:review_count)
    when :most_recent
      User.all.sort_by(&:last_updated_review)
    when :least_recent
      User.all.sort_by(&:last_updated_review).reverse
    else
      User.all
    end
  end
end  

class User
  def average_rating
    (BigDecimal(reviews.sum(:rating).to_s) / BigDecimal(reviews.count.to_s)).round(1)
  end

  def review_count
    reviews.count
  end

  def last_updated_review
    reviews.order('updated_at')
  end
end


def index
  @users = UserList.order_users_by(params).paginate(page: params[:page], per_page: 20)
  # render :index
end



def self.next1()
  ## first get the current id
  ## then get the current collection?
  p = @products
      # need to define id
      # @products = Product.most_reviewed WORKED
      
      # @product = p.find_by(id: 61) WORKED
      # @most = Product.most_reviewed.find(@product.id) WORKED
      # @most = p.find(@product.id) WORKED
  
      
      
      # _index_find = @products.index { |p| p[:id] == @product.id }
      # _next_index = _index_find + 1
      # @products[_next_index]
      # _total_length = @products.length - 1
      # if _next_index  == _total_length
      #   @products[0]
      # else 
      #   @products[_next_index]
      # end


end 