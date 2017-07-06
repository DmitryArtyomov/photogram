class AlbumsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  load_and_authorize_resource :user
  load_and_authorize_resource through: :user

  def new
    authorize! :create_nested_resource, @user
  end

  def create
    @album.tags = TagService.new(params[:album][:tags]).tags
    if @album.save
      flash[:success] = "Album was successfully created"
      redirect_to user_album_path(@user, @album)
    else
      flash[:alert] = "Error creating album"
      render "new"
    end
  end

  def show
    @followership = @user.passive_followerships.find_by(follower_id: current_user.id) if user_signed_in?
    @photos = @album.photos.order(created_at: :desc)
  end

  def edit
  end

  def update
    @album.tags = TagService.new(params[:album][:tags]).tags
    if @album.update_attributes(album_params)
      flash[:success] = "Album was successfully updated"
      redirect_to user_album_path(@user, @album)
    else
      flash[:alert] = "Error updating album"
      render "edit"
    end
  end

  def destroy
    if @album.destroy
      flash[:success] = "Album was successfully deleted"
      redirect_to @user
    else
      flash[:alert] = "Error deleting album"
      render "edit"
    end
  end

  private

  def album_params
    params.require(:album).permit(:name, :description)
  end
end
