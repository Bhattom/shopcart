class ApplicationController < ActionController::Base
    layout :set_layout
    include CurrentCart
    before_action :set_cart
    include Pundit::Authorization
      rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
      before_action :authenticate_user!
      before_action :configure_permitted_parameters, if: :devise_controller?
    private
      def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:role, :email, :password, :password_confirmation)}
      end
      def user_not_authorized
        flash[:danger] = 'You are not authorized to perform this action.'
        redirect_to root_path
      end
      def set_layout
         if user_signed_in?
            if current_user.admin? 
             "admin" 
            elsif current_user.guest?
                "application"
            end
        end
    end
end
