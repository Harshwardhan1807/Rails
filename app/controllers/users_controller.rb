class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:home, :index, :new, :create]

  def home
  end

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all.order(:id)
  end

  # def new
  #   @user = User.new
  # end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path, notice: "User was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find(params[:id])
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
