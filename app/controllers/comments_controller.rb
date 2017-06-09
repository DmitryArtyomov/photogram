class CommentsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource :user
  load_and_authorize_resource :album, through: :user
  load_and_authorize_resource :photo, through: :album
  load_and_authorize_resource through: :photo

  def create
    @comment.user = current_user
    if @comment.save
      respond_to do |format|
        format.js
        format.html { redirect_to [@user, @album, @photo] }
      end
    end
  end

  def destroy
    if @comment.destroy
      respond_to do |format|
        format.js
        format.html { redirect_to [@user, @album, @photo] }
      end
    end
  end

  private

  def comment_params
    permitted_params = params.require(:comment).permit(:text)
  end
end
