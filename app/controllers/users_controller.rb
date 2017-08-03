class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]
  load_and_authorize_resource

  def show
    @followership = @user.passive_followerships.find_by(follower_id: current_user.id) if user_signed_in?
    @albums = @user.albums.includes(:photos).order(updated_at: :desc)
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile succesfully updated"
      redirect_to @user
    else
      flash[:alert] = "Error updating profile"
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :address, :avatar, :follower_email_notification,
      :comment_email_notificaton, :remove_avatar)
  end
end
