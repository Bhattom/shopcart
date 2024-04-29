class UsersController < ApplicationController
  before_action :authenticate_user!, except: %i[show_otp verify_otp]
  def index
    @users = User.all
   
  end

  def new 
    @user = User.new
  end

  def create
    authorize @user
    super do |user|
      user.role = 'guest' 
      user.save
    end
    @user = User.new(user_params)
    if @user.save!
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to @user
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.first
    @user.destroy
    redirect_to root_path
  end

  def user
    if user_signed_in? && current_user.admin?
      @users = User.all
      @users = User.all.page params[:page]
    else
      redirect_to root_path, alert: "You have not access this page."
    end
  end

  def userinfo
   @users = User.all
  end

  def disable_otp
    if current_user.validate_and_consume_otp!(params[:otp_attempt])
      current_user.otp_required_for_login = false
      current_user.save!
      redirect_to root_path, notice: 'Two-factor authentication disabled successfully.'
    else
      flash[:alert] = 'Invalid OTP code.'
      redirect_back(fallback_location: root_path)
    end
  end

  def show_otp
    # Render the OTP entry page
  end

  def verify_otp
    verifier = Rails.application.message_verifier(:otp_session)
    user_id = verifier.verify(session[:otp_token])
    user = User.find(user_id)

    if user.validate_and_consume_otp!(params[:otp_attempt])
      sign_in(:user, user)
      redirect_to root_path, notice: 'Logged in successfully!'
    else
      flash[:alert] = 'Invalid OTP code.'
      redirect_to new_user_session_path
    end
  end

  def enable_otp_show_qr
    if current_user.otp_required_for_login
      redirect_to edit_user_registration_path, alert: '2FA is already enabled.'
    else
      current_user.otp_secret = User.generate_otp_secret
      issuer = 'Your App'
      label = "#{issuer}:#{current_user.email}"

      @provisioning_uri = current_user.otp_provisioning_uri(label, issuer:)
      current_user.save!
    end
  end

  def enable_otp_verify
    if current_user.validate_and_consume_otp!(params[:otp_attempt])
      current_user.otp_required_for_login = true
      current_user.save!
      redirect_to edit_user_registration_path, notice: '2FA enabled successfully.'
    else
      redirect_to enable_otp_show_qr_path, alert: 'Invalid OTP code.'
    end
  end
  private

  def user_params
    params.require(:user).permit(:email, :role)
  end

  
end
