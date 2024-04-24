# class SessionsController < Devise::SessionsController
#   skip_before_action :verify_authenticity_token
#   def create
#     super do |resource|
#       if resource.persisted?
#         verification_code = resource.generate_verification_code
#         UserMailer.verification_code_email(resource, verification_code).deliver_now
#         flash[:notice] = 'Verification code sent. Please check your email.'
#         redirect_to verify_user_path(verification_code: verification_code), notice: 'Please Verify Your Account Here'
#         if resource.verified == true
#           p "ccccccccccccccccccccccccccccccc"
#           sign_in(resource)
#         end 
#         return
#       end
#     end
#   end

#   def new
#     super do |resource|
#       if resource.verified?
#         render 'verify', notice: 'Please Verify Your Account Here'
#         return
#       end
#     end
#   end

#   def verify
#     @user = User.find_by(verification_code: params[:verification_code])
#     p @user
#     p 'wwwwww'
#     p 'wwwwww'
#     p 'wwwwww'
#     p 'wwwwww'
#     if @user
#       if @user && @user.verification_code == params[:verification_code]
#         render 'verify', notice: 'please enter the code here!'
#       end
#     else
#       redirect_to new_user_session_path, alert: 'Invalid verification code.'
#     end
#   end

#   private

#   def user_verification_code_valid?(user, verification_code)
#     user && user.verification_code == verification_code
#   end

# end
