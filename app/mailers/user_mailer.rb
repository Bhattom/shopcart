class UserMailer < ApplicationMailer
    include Rails.application.routes.url_helpers

    def order_confirmation_email(order, user)
        @order = order
        @user = user
        mail(to: @user.email, subject: 'Order Confirmation')
      end

      def verification_code_email(user, verification_code)
        @verification_code = verification_code
        @verification_url = verify_user_url(verification_code: verification_code)
        @user = user
        mail(to: @user.email, subject: 'Verification Code')
      end
end
