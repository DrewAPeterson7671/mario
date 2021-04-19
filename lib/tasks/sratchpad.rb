



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





