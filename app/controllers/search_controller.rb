class SearchController < ApplicationController
  def search
    result = SearchService.new(params[:q]).search
    respond_to do |format|
      format.json { render json: result }
    end
  end

  def index
    if @tag = Tag.find_by(text: "##{params[:tag]}")
      @photos = @tag.photos.includes(album: :user)
      @albums = @tag.albums.includes(:photos, :user)
    end
  end
end
