class OrdersController < ApplicationController
    def index
        @orders = Order.all
        @cart = current_user.carts.last
        add_breadcrumb('<div style="text-align: center;"><img src="https://cdn-icons-png.flaticon.com/128/10595/10595791.png" style="width: 20px; height: 20px;"><br>Cart</div>'.html_safe, cart_path(@cart), class: 'breadcrumb-item',style:"text-decoration:none;", data: { index: 1 })
        add_breadcrumb('<div style="text-align: center;"><img src="https://cdn-icons-png.flaticon.com/128/10595/10595792.png" style="width: 20px; height: 20px;"><br>Order</div>'.html_safe, orders_path, class: 'breadcrumb-item', data: { index: 2 })
        add_breadcrumb('<div style="text-align: center;"><img src="https://cdn-icons-png.flaticon.com/128/10595/10595793.png" style="width: 20px; height: 20px;"><br>Address</div>'.html_safe, new_address_path(cart_id: @cart.id), class: 'breadcrumb-item',style:"color:blue;", data: { index: 3 })
        add_breadcrumb('<div style="text-align: center;"><img src="https://cdn-icons-png.flaticon.com/128/10595/10595794.png" style="width: 20px; height: 20px;"><br>Payment</div>'.html_safe, new_payment_path(cart_id: @cart.id), class: 'breadcrumb-item',style:"color:blue;", data: { index: 4 })

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
                UserMailer.order_confirmation_email(@order, current_user).deliver_now
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

    def confirm
        @order = Order.find(params[:id])
        @order.update(confirmed: true)
        UserMailer.order_confirmation_email(@order, current_user).deliver_now
        redirect_to @order, notice: 'Order confirmed.'
      end

      def status
        order = Order.find_by(id: params[:order_id])
        if order
          render json: { status: order.track }
        else
          render json: { error: 'Order not found' }, status: :not_found
        end
      end
    private

    def order_params
      params.require(:order).permit(:id, :cart_id, :user_id, :track)
    end
end
