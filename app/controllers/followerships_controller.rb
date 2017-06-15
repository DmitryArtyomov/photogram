class FollowershipsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource :user
  load_and_authorize_resource

  def create
    authorize! :create_nested_resource, @user
    if @followership.save
      flash[:success] = "You are now following #{@followership.followed.first_name}"
    else
      flash[:alert] = "Error creating followership"
    end
    redirect_to :back
  end

  def destroy
    if @followership.destroy
      flash[:success] = "You are no longer following #{@followership.followed.first_name}"
    else
      flash[:alert] = "Error deleting followership"
    end
    redirect_to :back
  end

  private

  def followership_params
    permitted_params = params.require(:followership).permit(:followed_id)
  end
end
