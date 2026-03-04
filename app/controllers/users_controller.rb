class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:home, :create]

  def home
  end

  def index
    @users = User.all.order(:id)
    if current_user.role != "admin"
      redirect_to root_path, alert: "You are not authorized to access this page."
    end
  end

  def show
    @user = User.find(params[:id])
    if current_user.role != "admin" && current_user != @user
      redirect_to root_path, alert: "You are not authorized to access this page."
    end
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to users_path, notice: "User was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path, notice: "User was successfully deleted."
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :age, :role)
  end
end
