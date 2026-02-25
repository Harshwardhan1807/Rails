class ChannelsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_channel, only: [:show, :edit, :update]

  def index
    @channels = Channel.order(:id).page(params[:page]).per(8)
  end

  def show
  end

  def edit
  end

  def new
    @channel = Channel.new
  end

  def create
    @channel = Channel.new(channel_params)
    if @channel.save
      redirect_to channels_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @channel.update(channel_params)
      redirect_to channel_path(@channel)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def channel_params
    params.require(:channel).permit(:name, :description, :owner_id)
  end

  def set_channel
    @channel = Channel.find(params[:id])
  end
end
