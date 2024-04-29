class PaymentsController < ApplicationController
  require 'prawn'
  skip_before_action :verify_authenticity_token
    def new
        @payment = Payment.new
        @cart = current_user.carts.last
        add_breadcrumb('<div style="text-align: center;"><img src="https://cdn-icons-png.flaticon.com/128/10595/10595791.png" style="width: 20px; height: 20px;"><br>Cart</div>'.html_safe, cart_path(@cart), class: 'breadcrumb-item',style:"text-decoration:none;", data: { index: 1 })
        add_breadcrumb('<div style="text-align: center;"><img src="https://cdn-icons-png.flaticon.com/128/10595/10595792.png" style="width: 20px; height: 20px;"><br>Order</div>'.html_safe, orders_path, class: 'breadcrumb-item',style:"text-decoration:none;", data: { index: 2 })
        add_breadcrumb('<div style="text-align: center;"><img src="https://cdn-icons-png.flaticon.com/128/10595/10595793.png" style="width: 20px; height: 20px;"><br>Address</div>'.html_safe, new_address_path, class: 'breadcrumb-item', style:"text-decoration:none;", data: { index: 3 })
        add_breadcrumb('<div style="text-align: center;"><img src="https://cdn-icons-png.flaticon.com/128/10595/10595794.png" style="width: 20px; height: 20px;"><br>Payment</div>'.html_safe, new_payment_path, class: 'breadcrumb-item', data: { index: 4 })    
    end
    def create
        Razorpay.setup('rzp_test_DeXPCIrBNCQc32', 'lY9cRXuTNcryb4nebgR17BSF')
        cart_subtotal = current_user.cart.lineitems.sum(:price)
        razorpay_order = Razorpay::Order.create(amount: cart_subtotal * 100, currency: 'INR', receipt: 'Test')
        Rails.logger.info("Razorpay order created successfully: #{razorpay_order.inspect}")
        
      end

      def create_payment
        Razorpay.setup('rzp_test_DeXPCIrBNCQc32', 'lY9cRXuTNcryb4nebgR17BSF')
        cart_subtotal = @cart.subtotal
        razorpay_order = Razorpay::Order.create(amount: cart_subtotal * 100, currency: 'INR', receipt: 'TEST1')
        Rails.logger.info("Razorpay order created successfully: #{razorpay_order.inspect}")
        payment_link = "#{request.base_url}/payments/#{razorpay_order.id}" 
        p payment_link
        if current_user.carts.last.payment == true
            redirect_to success_payments_path
        else
            redirect_to create_payment_payments_path(razorpay_order.id)
            current_user.carts.update(payment: true)
        end
      end 

    def payment_callback
      razorpay_payment_id = params[:razorpay_payment_id]
      razorpay_order_id = params[:razorpay_order_id]
      payment_signature = params[:razorpay_signature]

        payment = Razorpay::Payment.fetch(razorpay_payment_id)
        if payment && payment["status"] == 'captured'
            redirect_to success_payments_path
        else
            redirect_to create_payment_payments_path(razorpay_order.id)
        end
      verified = payment.verify_payment_signature({
        order_id: razorpay_order_id,
        payment_id: razorpay_payment_id,
        signature: payment_signature
      })
  
      if verified
        render json: { status: 'success', message: 'Payment Successfully Done !!' }
      else
        render json: { status: 'error', message: 'Payment verification failed' }, status: :unprocessable_entity
      end
    end

    def success
      payment_mode = params[:payment_mode]
      render 'success'
      end
      
      def offline_payment
        @cart = current_user.carts.last 
        @cart_items = @cart.lineitems 
        @total_amount = @cart.subtotal
        
        respond_to do |format|
          format.html { render 'offline_payment' } # Render HTML view
          format.json do
            tracks_data = Order.tracks.map { |t| [t[0], t[1]] }
            render json: tracks_data # Return JSON data
          end
        end
      end

      def update_status
        track_id = params[:track_id]
        status = params[:status]
        p track_id
        p status
        order = current_user.orders.last
        p order
        p 'wwwwww'
        p 'wwwwww'
        if order
          if order.update(track: track_id.to_i)
            render json: { message: "Status updated successfully." }, status: :ok
          else
            render json: { error: track.errors.full_messages.join(", ") }, status: :unprocessable_entity
          end
        else
          render json: { error: "Track not found." }, status: :not_found
        end
      end

        def invoice_print
          user = current_user 
          items = @cart.lineitems
          @cart = current_user.carts.last
          payment_mode = params[:payment_mode]
          p payment_mode
          p 'wwwww'
          p 'wwwww'
          p 'wwwww'
          p 'wwwww'
          p 'wwwww'
          pdf_content = generate_pdf(user, items, payment_mode)
          send_data pdf_content, filename: "Invoice Bill.pdf", type: "application/pdf"
        end

        
    private

    def generate_pdf(user, items, payment_mode)
      Prawn::Document.new do |pdf|
        pdf.text "Invoice", align: :center, size: 18, style: :bold
        pdf.move_down 20
        pdf.text "ShopCart", align: :right, style: :italic
        pdf.text "Email: #{user.email}"
        pdf.text "Date: #{Date.today.strftime('%B %d, %Y')}"
        pdf.text "Payment Mode: #{payment_mode}", style: :bold if payment_mode.present?
        pdf.move_down 20
        pdf.text "Items Purchased", style: :bold
        pdf.move_down 10
    
        table_data = [["Name", "Description", "Quantity", "Unit Price", "Total"]]
        items.each do |lineitem|
          table_data << [lineitem.product.name, lineitem.product.desc, lineitem.quantity, "#{'%.2f' % lineitem.unit_price}", "#{'%.2f' % (lineitem.quantity * lineitem.unit_price)}"]
        end
        pdf.table(table_data) 
        total_amount = items.sum { |item| item.quantity * item.unit_price }
        pdf.move_down 20
        pdf.text "Total Amount: #{'%.2f' % total_amount}", align: :right, style: :bold
      end.render
    end
    
  end