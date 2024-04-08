class PaymentsController < ApplicationController
    def new
        @payment = Payment.new
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
        razorpay_payment_id = params[:razorpay_payment_id]
    
        begin
          @payment = Razorpay::Payment.fetch(razorpay_payment_id)
    
          # Check if payment details are fetched successfully
          if @payment.present?
            render 'success'
          else
            # Handle the case where payment details cannot be fetched
            flash[:error] = "Error retrieving payment details."
            redirect_to root_path
          end
        rescue Razorpay::BadRequestError => e
          # Handle the case where the payment ID provided does not exist
          flash[:error] = "Error fetching payment details: #{e.message}"
          redirect_to root_path
        end
      end
  end