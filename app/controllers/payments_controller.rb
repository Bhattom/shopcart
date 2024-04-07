class PaymentsController < ApplicationController
    def new
        @payment = Payment.new
    end
    def create
       
        Razorpay.setup('rzp_test_DeXPCIrBNCQc32', 'lY9cRXuTNcryb4nebgR17BSF')
    
        cart_subtotal = current_user.cart.lineitems.sum(:price)

        razorpay_order = Razorpay::Order.create(amount: cart_subtotal, currency: 'INR', receipt: 'Test')

    
        Rails.logger.info("Razorpay order created successfully: #{razorpay_order.inspect}")
        
        redirect_to razorpay_order_path(razorpay_order.id)
      end

      def create_payment
        Razorpay.setup('rzp_test_DeXPCIrBNCQc32', 'lY9cRXuTNcryb4nebgR17BSF')
        cart_subtotal = @cart.subtotal
        razorpay_order = Razorpay::Order.create(amount: cart_subtotal, currency: 'INR', receipt: 'TEST1')
        Rails.logger.info("Razorpay order created successfully: #{razorpay_order.inspect}")
        payment_link = "#{request.base_url}/payments/#{razorpay_order.id}" 
        p payment_link
        p 'wwwww'
        p 'wwwww'
        redirect_to create_payment_payments_path(razorpay_order.id)
      end

    def payment_callback
      razorpay_payment_id = params[:razorpay_payment_id]
      razorpay_order_id = params[:razorpay_order_id]
      payment_signature = params[:razorpay_signature]

      payment = Razorpay::Payment.fetch(razorpay_payment_id)
      verified = payment.verify_payment_signature({
        order_id: razorpay_order_id,
        payment_id: razorpay_payment_id,
        signature: payment_signature
      })
  
      if verified
        render json: { status: 'success', message: 'Payment successful' }
      else
        render json: { status: 'error', message: 'Payment verification failed' }, status: :unprocessable_entity
      end
    end
  end