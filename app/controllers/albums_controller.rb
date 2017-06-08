class AlbumsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  load_and_authorize_resource :user
  load_and_authorize_resource through: :user

  def new
    authorize! :create_nested_resource, @user
  end

  def create
    if @album.save
      flash[:success] = "Album was successfully created"
      redirect_to user_album_path(@user, @album)
    else
      flash[:alert] = "Error creating album"
      render "new"
    end
  end

  def show
    @photos = @album.photos.order(created_at: :desc)
    if photo = session[:current_photo]
      @current_photo = photo['id']
      session.delete(:current_photo)
    end
  end

  def edit
  end

  def update
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
    permitted_params = params.require(:album).permit(:name, :description, tags: [])
    permitted_params[:tags] = TagService.new(permitted_params[:tags]).tags
    permitted_params
  end
end
