class TagsController < ApplicationController
  def search
    @all_tags = Tag.all
    @tags = Tag.search_by_text(params[:q]).limit(20)
    respond_to do |format|
      format.json { render json: @tags.to_json( only: [:id, :text] ) }
      format.html {}
    end
  end
end
