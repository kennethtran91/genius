class Api::SongsController < ApplicationController
  def index
    if params[:query] == "alphabetical"
      @songs = Song.order(:title, :artist)
    else
      # Upgrade this to select top 10 songs by upvotes
      @songs = Song.all.limit(10)
    end
  end

  def create
    @song = Song.new(song_params)
    if @song.save
      render :show
    else
      render json: @song.errors, status: 422
    end
  end

  def show
    render json: Song.find(params[:id])
  end

  private
  def song_params
    params.require(:song).permit(
      :artist,
      :title,
      :lyrics,
      :youtube_url,
      :soundcloud_url,
      :featuring,
      :produced_by,
      :written_by,
      :release_date,
      :about
    )
  end
end