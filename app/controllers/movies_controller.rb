class MoviesController < ApplicationController
  before_action :authenticate_user!

  def index
    if params[:query].present?
      @movies = Movie.where("title ILIKE ? OR description ILIKE ?", "%#{params[:query]}%", "%#{params[:query]}%")
    else
      @movies = Movie.all.order(rating: :desc)
    end
  end

  def top
    @movies = Movie.all.order(rating: :desc).limit(8)
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path, notice: "Movie deleted successfully"
  end
end
