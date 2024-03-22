class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
    @sizes = @product.sizes
    @products = Product.all
    @total_quantity = @product.quantity
    @similar_products = @product.similar_products
    @size = Size.find(params[:id])
  end

  def edit
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
        redirect_to @product
    else
        render :new, status: :unprocessable_entity
    end
  end

  def update
    @product = Product.find(params[:id])

    if @product.update(product_params)
      redirect_to @product
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product = Product.find( params[:id])
    @product.destroy
    redirect_to root_path
  end

  def add_to_cart
    @product = Product.find(params[:id])
    quantity = params[:quantity].to_i
    current_cart.add_item(@product, quantity)
    redirect_to cart_path(current_cart), notice: "Added #{quantity} #{'item'.pluralize(quantity)} to cart."
  end
  private

  def product_params
    params.require(:product).permit(:name, :desc, :price, :size, :quantity, images: [])
  end
end
