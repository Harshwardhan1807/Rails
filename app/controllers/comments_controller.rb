class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_video

  def create
    @comment = @video.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to channel_path(@channel), notice: "Comment added."
    else
      redirect_to channel_path(@channel), alert: "Comment can't be blank."
    end
  end

  def destroy
    @comment = @video.comments.find(params[:id])

    if current_user == @comment.user || current_user.admin?
      @comment.destroy
      redirect_to channel_path(@channel), notice: "Comment deleted."
    else
      redirect_to channel_path(@channel), alert: "Not authorized."
    end
  end

  private

  def set_video
    @channel = Channel.find(params[:channel_id])
    @video = Video.find(params[:video_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
