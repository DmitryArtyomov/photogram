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
      render 'edit'
    end
  end

  def search
    @users = User.search_by_full_name(params[:q]).limit(10)
    respond_to do |format|
      format.json { render json: @users.map{ |u| "#{u.first_name} #{u.last_name}"}.to_json }
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :address, :avatar, :follower_email_notification,
      :comment_email_notificaton)
  end
end
