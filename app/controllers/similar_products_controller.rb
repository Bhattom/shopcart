class SimilarProductsController < ApplicationController
    before_action :set_product
    before_action :authenticate_user!, only: [:create]

    def index
        @similar_products = @product.similar_products
    end

    def new
        @similar_product = @product.similar_products.build
    end

    def create
        @similar_product = @product.similar_products.build(similar_product_params)
    if @similar_product.save
      redirect_to product_path(@product, @similar_product), notice: 'Similar product was successfully created.'
    else
      render :new
    end
    end

    def show
        @product= Product.find(params[:product_id])
        @similar_product = SimilarProduct.find(params[:id])
    end

    private

    def set_product
        @product = Product.find(params[:product_id])
      end
    def similar_product_params
        params.require(:similar_product).permit(:name, :price, :desc, :size, :quantity, images: [])
      end
end
