class VideosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_channel

  def new
    @video = @channel.videos.new
  end

  def create
    @video = @channel.videos.new(video_params)
    if @video.save
      redirect_to channel_path(@channel), notice: "Video created successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def video_params
    params.require(:video).permit(:title, :description, :duration, :video_url)
  end

  def set_channel
    begin
      @channel = Channel.find(params[:channel_id])
    rescue ActiveRecord::RecordNotFound
      redirect_to channels_path, alert: "Channel not found"
    end
  end
end
