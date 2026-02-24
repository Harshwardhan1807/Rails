class ChannelsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  def index
    @channels = Channel.all
  end

  def show
    @channel = Channel.find(params[:id])
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

  private

  def channel_params
    params.require(:channel).permit(:name, :description, :owner_id)
  end

end
