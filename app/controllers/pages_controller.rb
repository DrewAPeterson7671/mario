class PagesController < ApplicationController
  def home
    @most_reviews = Product.most_reviewed
    @newest_products = Product.newest_product
    @highest_revieweds = Product.highest_reviewed
    render :home
  end

  def search
    if params[:search].blank?
      redirect_to(root_path, alert: "Search Field Was Blank!") and return
    else
      # @parameter = params[:search].downcase
      # @results = Product.all.where("lower(name) LIKE :search", search: "%#{@parameter}%")
      @results = Product.joins(:reviews).search(params[:search]).order("reviews.author DESC")
    end
  end

end