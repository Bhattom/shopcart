class AddressesController < ApplicationController
    def index
        @addresses = Address.all
        add_breadcrumb "index", new_address_path
    end

    def new
        @address = Address.new
        @cart = current_user.carts.last
        add_breadcrumb('<div style="text-align: center;"><img src="https://cdn-icons-png.flaticon.com/128/10595/10595791.png" style="width: 20px; height: 20px;"><br>Cart</div>'.html_safe, cart_path(@cart), class: 'breadcrumb-item',style:"text-decoration:none;", data: { index: 1 })
        add_breadcrumb('<div style="text-align: center;"><img src="https://cdn-icons-png.flaticon.com/128/10595/10595792.png" style="width: 20px; height: 20px;"><br>Order</div>'.html_safe, orders_path, class: 'breadcrumb-item',style:"text-decoration:none;", data: { index: 2 })
        add_breadcrumb('<div style="text-align: center;"><img src="https://cdn-icons-png.flaticon.com/128/10595/10595793.png" style="width: 20px; height: 20px;"><br>Address</div>'.html_safe, new_address_path, class: 'breadcrumb-item', data: { index: 3 })
        add_breadcrumb('<div style="text-align: center;"><img src="https://cdn-icons-png.flaticon.com/128/10595/10595794.png" style="width: 20px; height: 20px;"><br>Payment</div>'.html_safe, new_payment_path(cart_id: @cart.id), class: 'breadcrumb-item',style:"color:blue;", data: { index: 4 })

    end

    def create
        @address = Address.new(address_params)
        if @address.save
            redirect_to new_payment_path , notice: 'Address Added Successfully!!!'
        else
            render :new, status: :unprocessable_entity
        end
      end

    def show
        @address = Address.find(params[:id])
    end

    def edit
    end

    def update
    end

    def destroy
    end

    private

    def address_params
        params.require(:address).permit(:id, :email, :name, :phone_no, :address, :user_id, :pincode, :city)
    end
end
