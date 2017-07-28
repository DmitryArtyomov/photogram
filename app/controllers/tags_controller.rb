class TagsController < ApplicationController
  def show
    if @tag = Tag.find_by(text: "##{params[:id]}")
      @photos = @tag.photos.includes(album: :user)
      @albums = @tag.albums.includes(:photos, :user)
    end
  end

  def fetch
    @tags = ActiveModelSerializers::SerializableResource.new( Tag.search_by_text(params[:q]).limit(20) )
    respond_to do |format|
      format.json { render json: @tags.to_json }
    end
  end
end
