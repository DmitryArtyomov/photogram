class HomepageController < ApplicationController
  def index
    redirect_to :feed if user_signed_in?
  end
end
