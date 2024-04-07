class AddressesController < ApplicationController
    def index
        @addresses = Address.all
    end

    def new
        @address = Address.new
    end

    def create
        @address = Address.new(address_params)
        if @address.save
            redirect_to payment_callback , notice: 'Address Added Successfully!!!'
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
