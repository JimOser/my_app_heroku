class PodcastsController < ApplicationController
  before_action :set_podcast, only: %i[show edit update destroy]

  def index
    @podcasts = Podcast.order(created_at: :desc).includes(:hosts, :episodes)
  end

  def show; end

  def new
    @podcast = Podcast.new
  end

  def edit; end

  def create
    @podcast = Podcast.new(podcast_params.to_h)
    if @podcast.save
      redirect_to @podcast, notice: "Podcast created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @podcast.update(podcast_params.to_h)
      redirect_to @podcast, notice: "Podcast updated successfully."
    else
      render :edit, status: :unprocessable_entity
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
    params.require(:podcast).permit(:title, :description, host_ids: [])
  end
end
