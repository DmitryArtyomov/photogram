class SearchController < ApplicationController
  def search
    result = SearchService.new(params[:q]).search
    respond_to do |format|
      format.json { render json: result }
    end
  end
end
