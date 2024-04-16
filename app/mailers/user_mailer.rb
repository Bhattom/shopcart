class UserMailer < ApplicationMailer
    def order_confirmation_email(order, user)
        @order = order
        @user = user
        mail(to: @user.email, subject: 'Order Confirmation')
      end
end
