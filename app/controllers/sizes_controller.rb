class SizesController < ApplicationController
    def update_stock_quantity
        product = Product.find(params[:product_id])
        size = product.sizes.find(params[:size_id])
        quantity_to_reduce = params[:quantity].to_i
        size.update(stock_quantity: size.stock_quantity - quantity_to_reduce)
        head :ok
      rescue ActiveRecord::RecordNotFound => e
        render json: { error: e.message }, status: :not_found
      end
end
