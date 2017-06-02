class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]
  load_and_authorize_resource

  def show
    @albums = @user.albums
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

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :address, :avatar)
  end
end
