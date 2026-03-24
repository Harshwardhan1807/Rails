class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:home, :create]
  before_action :set_user, only: [:show, :update, :destroy]
  before_action :authorize_user, only: [:show, :update, :destroy]

  def home
  end

  def index
    authorize User
    @users = User.all.order(:id).page(params[:page]).per(7)
  end

  def show
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
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path, notice: "User was successfully deleted."
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :age, :role)
  end

  def set_user
    begin
      @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to users_path, alert: "You are not authorized to access this page."
    end
  end

  def authorize_user
    authorize @user
  end
end
