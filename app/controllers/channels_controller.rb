class ChannelsController < ApplicationController
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

  def user_role_check
    unless User.find_by(id: params[:owner_id]).role in ["creator", "admin"]
      errors.add(:owner_id, "must belong to a user with creator or admin role")
      throw :abort
    end
  end
end
