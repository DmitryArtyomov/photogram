class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]
  before_action :load_current_user_followerships, only: [:followers, :following]
  load_and_authorize_resource

  def show
    @followership = @user.passive_followerships.find_by(follower_id: current_user.id)
    @albums = @user.albums.includes(:photos).order(updated_at: :desc)
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile succesfully updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def followers
    @followers = @user.followers
  end

  def following
    @following = @user.following
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :address, :avatar)
  end

  def load_current_user_followerships
    @current_followerships = current_user.active_followerships if user_signed_in?
  end
end
