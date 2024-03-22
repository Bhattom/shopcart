class LineitemsController < ApplicationController
 include CurrentCart
#  before_action :set_lineitem, only: [:show, :update, :edit]
 before_action :set_cart, only: [:create] 


   def index
    @lineitems = Lineitem.all
   end

   def show
    @lineitem = Lineitem.find(params[:id])
    @product = @lineitem.product
    @size = Size.find(params[:id])
   end

   def new
    @lineitem = Lineitem.new
   end

   def edit
    @lineitem = Lineitem.find(params[:id]) 
   end

   def create
        product = Product.find(params[:product_id])
        size = Size.find(params["lineitem"]["size_id"])
        @lineitem = @cart.add_product(product, params[:quantity], params[:size_id])
        total_qty =  product.quantity - params[:quantity].to_i
        product.update(quantity: total_qty)
        stock = size.stock_quantity - params[:quantity].to_i
        size.update(stock_quantity: stock)
        p stock
        # hash = { "lineitem" => { "size_id" => "54" } }
        # p hash["lineitem"]["size_id"] 
        update_qty = @lineitem.quantity.to_i + params[:quantiy].to_i
        @lineitem.update(quantity: update_qty)
        respond_to do |format|
            if @lineitem.save
                format.html { redirect_to @lineitem.cart, notice: "Item Added to cart" }
                format.json { render :show, status: :created, location: @lineitem }
            else
                format.html { render :new }
                format.json { render json: @lineitem.errors, status: :unprocessable_entity }
            end
        end
    end
    def increase_quantity
        lineitem = Lineitem.find(params[:id])
        @cart = lineitem.cart
        lineitem.increment!(:quantity)
        add_qty = lineitem.product.quantity - 1
        add_qty = 0 if add_qty < 0
        p add_qty
        lineitem.product.update(quantity: add_qty)
        unit = lineitem.product.price.to_i * lineitem.quantity.to_i
        lineitem.update(unit_price: unit)
        p unit

        respond_to do |format|
            format.js { @lineitem = lineitem } 
            format.json { render json: { success: true, quantity: @lineitem.quantity } }
            format.html { redirect_to cart_path(lineitem.cart), notice: "Quantity increased successfully." }
        end
      end
    
      def decrease_quantity
        lineitem = Lineitem.find(params[:id])
        @cart = lineitem.cart
        lineitem.decrement!(:quantity)
        add_qty = lineitem.product.quantity + 1
        p add_qty
        lineitem.product.update(quantity: add_qty)
        unit = lineitem.product.price.to_i * lineitem.quantity.to_i
        lineitem.update(unit_price: unit)
        p unit

        respond_to do |format|
            format.js { @lineitem = lineitem } 
            format.json { render json: { success: true, quantity: @lineitem.quantity } }
            format.html { redirect_to cart_path(lineitem.cart), notice: "Quantity decreased successfully." }
        end
      end

    def destroy
        @cart = Cart.find(session[:cart_id])
        @lineitem.destroy

        respond_to do |format|
            format.html { redirect_to cart_path(@cart), notice: "Lineitem was succesfully destroyed." }
            format.json { head :no_content }
        end
    end
    def update
    end
    private

    def lineitem_params
        params.require(:lineitem).permit(:size_id, :product_id)
    end

    def set_lineitem
        @lineitem = Lineitem.find(params[:id])
    end
end
