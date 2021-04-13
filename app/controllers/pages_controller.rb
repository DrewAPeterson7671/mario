class PagesController < ApplicationController
  def home
    @most_reviews = Product.most_reviewed
    @newest_products = Product.newest_product
    @highest_revieweds = Product.highest_reviewed
    render :home
  end
end