class CommentsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource :user
  load_and_authorize_resource :album, through: :user
  load_and_authorize_resource :photo, through: :album
  load_and_authorize_resource through: :photo

  def create
    @comment.user = current_user
    respond_to do |format|
      if @comment.save
        Notifications::NewComment.new(@comment).notify
        format.js
        format.html { redirect_to [@user, @album, @photo] }
      else
        format.html do
          flash[:alert] = "Error creating comment"
          redirect_to [@user, @album, @photo]
        end
      end
    end
  end

  def destroy
    respond_to do |format|
      if @comment.destroy
        format.js
        format.html { redirect_to [@user, @album, @photo] }
       else
        format.html do
          flash[:alert] = "Error deleting comment"
          redirect_to [@user, @album, @photo]
        end
      end
    end
  end

  private

  def comment_params
    permitted_params = params.require(:comment).permit(:text)
  end
end
