class EpisodesController < ApplicationController
  before_action :set_episode, only: %i[show edit update destroy]

  def index
    @episodes = Episode.all
  end

  def show; end

  def new
    @episode = Episode.new
  end

  def create
    @episode = Episode.new(episode_params)
    if @episode.save
      redirect_to @episode, notice: "Episode created successfully."
    else
      render :new
    end
  end

  def edit; end

  def update
    if @episode.update(episode_params)
      redirect_to @episode, notice: "Episode updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @episode.destroy
    redirect_to episodes_path, notice: "Episode deleted successfully."
  end

  private

  def set_episode
    @episode = Episode.find(params[:id])
  end

  def episode_params
    params.require(:episode).permit(:podcast_id, :number, :title, :url, :youtube_url, :released_on)
  end
end

