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
   end

   def new
    @lineitem = Lineitem.new
   end

   def edit
    @lineitem = Lineitem.find(params[:id]) 
   end

   def create
        product = Product.find(params[:product_id])
        lineitem = @cart.lineitems.find_or_initialize_by(product_id: product.id)
        size_ids = params[:lineitem][:size_ids].reject(&:empty?)
        quantity = params[:quantity].to_i
        size_id = params[:size_ids].to_i
        size_ids.each do |size_id|
            @lineitem = @cart.lineitems.find_or_initialize_by(product_id: product.id)
            if @lineitem.present?
              @lineitem = @cart.add_product(product, quantity, size_id)
            else
             @lineitem = Lineitem.new(product: product, quantity: params[:quantity], size_id: params[:size_ids])
            end

          end
        total_qty =  product.quantity - params[:quantity].to_i
        product.update(quantity: total_qty)
       
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
        size = lineitem.sizes # Assuming there's a size associated with the line item
        if size
            size.update(stock_quantity: size.stock_quantity - 1)
        end
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
        add_stk = lineitem.sizes.stock_quantity + 1
        lineitem.sizes.update(stock_quantity: add_stk)
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
