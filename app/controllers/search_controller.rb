class SearchController < ApplicationController
  def search
    @tags = Tag.search_by_text(params[:q]).limit(20)
    @users = User.search_by_full_name(params[:q]).limit(10)
    result = {
      tags: ActiveModel::SerializableResource.new(@tags),
      users: ActiveModel::SerializableResource.new(@users)
    }
    respond_to do |format|
      format.json { render json: result }
    end
  end

  def index
    if @tag = Tag.find_by(text: "##{params[:tag]}")
      @photos = @tag.photos.includes(album: :user)
      @albums = @tag.albums
    end
  end
end
