class FeedsController < ApplicationController
  before_action :authenticate_user!

  def show
    @feed = current_user.feed_photos.order(created_at: :desc).includes(album: :user)
    if request.xhr? && params[:last]
      render @feed.where("photos.id < #{params[:last]}").first(2)
    else
      @feed = @feed.first(2)
    end
  end
end
