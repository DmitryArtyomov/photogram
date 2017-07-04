class SearchController < ApplicationController
  def search
    @tags = Tag.search_by_text(params[:q]).limit(20)
    @users = User.search_by_full_name(params[:q])
      .reorder('')
      .left_joins(:followers)
      .group(:id)
      .order('COUNT(followerships.id) DESC')
      .limit(10)
    @albums = Album.search_by_name(params[:q])
      .reorder('')
      .left_joins(:photos)
      .group(:id)
      .order('COUNT(photos.id) DESC')
      .limit(20)
    result = {
      tags: ActiveModel::SerializableResource.new(@tags),
      users: ActiveModel::SerializableResource.new(@users),
      albums: ActiveModel::SerializableResource.new(@albums)
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
