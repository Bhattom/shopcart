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
        cart = Cart.find(params[:cart_id])
        user = User.find(params[:user_id])
        @order = Order.new(cart: cart, user: user, total: cart.subtotal)
        respond_to do |format|
            if @order.save!
                format.html { redirect_to orders_path, notice: "Order Sucessfully Created!!!!" }
                format.json { render :show, status: :created, location: @order }
            else
                format.html { render :new }
                format.json { render json: @order.errors, status: :unprocessable_entity }
            end
        end
    end

    def razorpay_order_id
        order = Order.find(params[:id])
        razorpay_order_id = generate_razorpay_order_id(order)
        render json: { razorpay_order_id: razorpay_order_id }
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Order not found' }, status: :not_found
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
