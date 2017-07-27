class PhotosController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  load_and_authorize_resource :user
  load_and_authorize_resource :album, through: :user
  load_and_authorize_resource through: :album

  def new
    authorize! :create_nested_resource, @user
  end

  def create
    if @photo.save && @photo.tags = TagService.new(params[:photo][:tags]).tags
      flash[:success] = "Photo was successfully uploaded"
      @album.touch
      redirect_to [@user, @album]
    else
      flash[:alert] = "Error uploading photo"
      render "new"
    end
  end

  def show
    @comments = @photo.comments.includes(:user).order(created_at: :asc)
    render action: 'show', layout: false if request.xhr?
  end

  def edit
  end

  def update
    if @photo.update_attributes(photo_params) && @photo.tags = TagService.new(params[:photo][:tags]).tags
      flash[:success] = "Photo was successfully updated"
      redirect_to [@user, @album, @photo]
    else
      flash[:alert] = "Error updating photo"
      render "edit"
    end
  end

  def destroy
    if @photo.destroy
      flash[:success] = "Photo was successfully deleted"
      redirect_to [@user, @album]
    else
      flash[:alert] = "Error deleting photo"
      render "edit"
    end
  end

  private

  def photo_params
    params.require(:photo).permit(:description, :image)
  end
end
