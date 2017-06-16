class FeedsController < ApplicationController
  before_action :authenticate_user!

  def show
    @feed = current_user.feed_photos.order(created_at: :desc).includes(album: :user)
    if request.xhr? && params[:last]
      render @feed.where("photos.id < #{params[:last].to_i}").first(5)
    else
      @feed = @feed.first(10)
    end
  end
end
