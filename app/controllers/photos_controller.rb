class PhotosController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  load_and_authorize_resource :user
  load_and_authorize_resource :album, through: :user
  load_and_authorize_resource through: :album

  def new
    authorize! :create_nested_resource, @user
  end

  def create
    if @photo.save
      flash[:success] = "Photo was successfully uploaded"
      @album.touch
      redirect_to user_album_path(@user, @album)
    else
      flash[:alert] = "Error uploading photo"
      render "new"
    end
  end

  def show
    render action: 'show', layout: false if request.xhr?
  end

  def edit
  end

  def update
    if @photo.update_attributes(photo_params)
      flash[:success] = "Photo was successfully updated"
      redirect_to user_album_path(@user, @album)
    else
      flash[:alert] = "Error updating photo"
      render "edit"
    end
  end

  def destroy
    if @photo.destroy
      flash[:success] = "Photo was successfully deleted"
      redirect_to user_album_path(@user, @album)
    else
      flash[:alert] = "Error deleting photo"
      render "edit"
    end
  end

  private

  def photo_params
    permitted_params = params.require(:photo).permit(:description, :image, tags: [])
    permitted_params[:tags] = TagService.new(permitted_params[:tags]).tags
    permitted_params
  end
end