class OrdersController < ApplicationController
    def index
        @orders = Order.all
    end

    def new
        @order = Order.new
    end

    def show
        @order = Order.find(params[:id])
    end

    def create
    end

    def edit
    end

    def update
    end

    def destroy
    end

    private

    def order_params
    params.require(:order).permit(:id, :cart_id, :user_id)
    end
end
