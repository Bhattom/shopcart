class ProductsController < ApplicationController
  def index
    @products = Product.all
    @categories = Category.all
    @products = @category ? @category.products : Product.all
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
    @product.category_ids = params[:product][:category_id]
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

  def filtered
    @category = Category.find_by(name: params[:category])
    if @category
      @products = @category.products
    else
      redirect_to products_path, alert: "Category not found"
    end
  end

  def product
    @category = Category.find_by(id: params[:category])
    if @category
      @products = @category.products if @category.present?
    else
      @products = Product.all
    end
  end
  private

  def product_params
    params.require(:product).permit(:name, :desc, :price, :size, :quantity, :id, images: [])
  end
end
