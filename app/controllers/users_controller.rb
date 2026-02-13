class UsersController < ApplicationController
  before_action :set_user
  def home
  end

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :age, :role)
  end

  def set_user
    @user = User.find_by(id: session[:user_id])
  end
end
