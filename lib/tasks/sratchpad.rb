@review = Review.find(params[:id]).paginate(page: params[:page], per_page: 10)

# should go in products>show 


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







@review_ids = @reviews.where(author: author)
@review_ids.each do |review_id|
  _user_new_id = User.find_by(user_name: author).pluck(:id)
  review_id.update_attributea(user_id: _user_new_id)
end

r = Review.find_by(author: "Mayor \"Diamond Joe\" Quimby")
r.update_attributes(author: "Mayor Diamond Joe Quimby")

r = Review.find_by(author: "I Mojo Jojo@Yahoo.Com")
r.update_attributes(author: "I Mojo Jojo")





