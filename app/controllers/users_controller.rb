class UsersController < ApplicationController
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
    @users = User.all
    @users = User.all.page params[:page]
  end

  def userinfo
   @users = User.all
  end

  private

  def user_params
    params.require(:user).permit(:email, :role)
  end

  
end
