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
  end

  def edit
  end

  def update
  end

  def remove
  end

  private

  def album_params
    params.require(:album).permit(:name, :description)
  end
end
