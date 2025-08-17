class EpisodesController < ApplicationController
  before_action :set_podcast
  before_action :set_episode, only: %i[show edit update destroy]

  def index
    @episodes = @podcast.episodes
  end

  def show
  end

  def new
    @episode = @podcast.episodes.build
  end

  def create
    @episode = @podcast.episodes.build(episode_params)
    if @episode.save
      redirect_to [@podcast, @episode], notice: 'Episode was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @episode.update(episode_params)
      redirect_to [@podcast, @episode], notice: 'Episode was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @episode.destroy
    redirect_to podcast_episodes_path(@podcast), notice: 'Episode was successfully destroyed.'
  end

  private

  def set_podcast
    @podcast = Podcast.find(params[:podcast_id])
  end

  def set_episode
    @episode = @podcast.episodes.find(params[:id])
  end

  def episode_params
    params.require(:episode).permit(:title, :number, :released_on, :url, :youtube_url)
  end
end

