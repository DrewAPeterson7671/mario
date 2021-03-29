class PagesController < ApplicationController
  def home
    @most_reviews = Product.most_reviewed
    @newest_products = Product.newest_product
    @made_usas = Product.made_usa
    render :home
  end
end