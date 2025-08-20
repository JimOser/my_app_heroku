class SongsController < ApplicationController
  before_action :set_song, only: %i[show edit update destroy]

  def index
    @songs = Song.order(created_at: :desc)
  end

  def show; end

  def new
    @song = Song.new
  end

  def edit; end

  def create
    @song = Song.new(song_params.to_h)
    if @song.save
      redirect_to @song, notice: "Song created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @song.update(song_params.to_h)
      redirect_to @song, notice: "Song updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @song.destroy
    redirect_to songs_path, notice: "Song deleted successfully."
  end

  private

  def set_song
    @song = Song.find(params[:id])
  end

  def song_params
    params.require(:song).permit(:title, :released_on, :youtube_url, :spotify_url, singer_ids: [])
  end
end
