class ProductsController < ApplicationController
  before_action :authorize, only: [:new, :create, :edit, :update, :destroy]

  def index
    @products = Product.all.paginate(page: params[:page], per_page: 12)
    render :index
  end

  def new
    @product = Product.new
    render :new
  end
  
  def create
    @product = Product.new(product_params)
    @product.product_photo.attach(params[:product][:product_photo])
    if @product.save
      flash[:notice] = "Product successfully added!"
      redirect_to products_path
    else
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
    render :edit
  end

  def show
    @product = Product.find(params[:id])
    render :show
  end

  def update
    @product= Product.find(params[:id])
    if @product.update(product_params)
      flash[:notice] = "Product successfully updated!"
      redirect_to products_path
    else
      render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    flash[:notice] = "Product successfully removed!"
    redirect_to products_path
  end



  private
    def product_params
      params.require(:product).permit(:name, :price, :country, :product_photo)
    end


end
