class ChannelsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_channel, only: [:show, :edit, :update]
  before_action :authorize_channel, only: [:edit, :update]

  def index
    @channels = Channel.order(:id).page(params[:page]).per(7)
  end

  def show
  end

  def edit
  end

  def new
    @channel = Channel.new
  end

  def create
    @channel = current_user.owned_channels.build(channel_params)
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
    params.require(:channel).permit(:name, :description)
  end

  def set_channel
    begin
      @channel = Channel.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to channels_path, alert: "Channel not found"
    end
  end

  def authorize_channel
    authorize @channel
  end
end
