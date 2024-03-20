class CartsController < ApplicationController
    include CurrentCart
    rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart
    before_action :set_cart, only: [:show, :edit, :update, :destroy]
    def index
      @carts = Cart.all
    end

    def show
      @subtotal = @cart.lineitems.sum(&:unit_price)
      @cart.update(subtotal: @cart.subtotal)
    end

    def new
        @cart = Cart.new
    end

    def create
        @cart = Cart.new(cart_params)

    end

    def destroy
        @cart.destroy if @cart.id == session[:cart_id]
        session[:cart_id] = nil
        respond_to do |format|
            format.html { redirect_to root_path, notice: 'Cart Was Succesfully Destroyed.'}
            format.json { head :no_content }
        end
    end

    def edit
        @cart = Cart.find(params[:id])
    end

    def update
        @cart = Cart.find(params[:id])

        if @cart.update(cart_params)
          redirect_to @cart
        else
          render :edit, status: :unprocessable_entity
        end
    end
    

      def remove_item
        lineitem = Lineitem.find(params[:id])
        lineitem.destroy
        redirect_to cart_path(lineitem.cart)
      end

    private

    def set_cart
        @cart = Cart.find(params[:id])
    end

    def cart_params
        params.fetch(:cart, {})
    end

    def invalid_cart
        logger.error "Attempt to access invalid cart#{params[:id]}"
        redirect_to root_path, notice: "That cart doesn't exists"
    end
end
