class Api::MoviesController < ApplicationController
  def index
    movies = Movie.all
    render json: movies
  end
  def show
    movie = Movie.find_by!(slug: params[:slug])
    render json: movie
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Filme não encontrado" }, status: :not_found
  end

  def create
    ActiveRecord::Base.transaction do
      @movie = Movie.new(movie_params)
      if @movie.save
        render json: @movie, status: :created
      else
        render json: { errors: @movie.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end

  def new; end
  def edit; end
  def update; end
  def destroy; end

  private

  def movie_params
    params.require(:movie).permit(:title, :video_master_url, :description, :thumbnail_url)
  end
end
