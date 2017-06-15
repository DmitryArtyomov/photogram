class FollowingController < ApplicationController
  load_and_authorize_resource :user
  before_action :current_user_following

  def index
    @following = @user.following
  end

  private

  def current_user_following
    @current_following = FollowershipsService.new(current_user).get
  end
end
