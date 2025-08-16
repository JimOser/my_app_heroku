class PodcastsController < ApplicationController
  before_action :set_podcast, only: %i[show edit update destroy]

  def index
    @podcasts = Podcast.all
  end

  def show; end

  def new
    @podcast = Podcast.new
  end

  def create
    @podcast = Podcast.new(podcast_params)
    if @podcast.save
      redirect_to @podcast, notice: "Podcast created successfully."
    else
      render :new
    end
  end

  def edit; end

  def update
    if @podcast.update(podcast_params)
      redirect_to @podcast, notice: "Podcast updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @podcast.destroy
    redirect_to podcasts_path, notice: "Podcast deleted successfully."
  end

  private

  def set_podcast
    @podcast = Podcast.find(params[:id])
  end

  def podcast_params
    params.require(:podcast).permit(:title, :description, :person_id)
  end
end

