class RazorpayController < ApplicationController
    def create_payment
      razorpay_order = Razorpay::Order.create(amount: 25000, currency: 'INR', receipt: 'TEST1')
      payment_link = "#{request.base_url}/payments/#{razorpay_order.id}" 

      render json: { payment_link: payment_link }
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