class VideosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_channel
  before_action :set_video, only: [:edit, :update, :destroy]
  before_action :authorize_video, except: [:new, :create]

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

  def edit
  end

  def update
    if @video.update(video_params)
      redirect_to channel_path(@channel), notice: "Video updated successfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @video.destroy
    redirect_to channel_path(@channel), notice: "Video deleted successfully"
  end

  private

  def video_params
    params.require(:video).permit(:title, :description, :duration, :video_file)
  end

  def set_channel
    begin
      @channel = Channel.find(params[:channel_id])
    rescue ActiveRecord::RecordNotFound
      redirect_to channels_path, alert: "Channel not found"
    end
  end

  def set_video
    @video = @channel.videos.find(params[:id])
  end

  def authorize_video
    authorize @video
  end
end
