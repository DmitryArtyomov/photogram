require 'rails_helper'

describe ApplicationController, type: :controller do

  controller do
    def index
      access_denied(nil)
    end
  end

  describe "#access_denied" do
    it "redirects to root_path with danger flash" do
      get :index
      expect(flash[:danger]).to_not eq(nil)
      expect(response).to redirect_to(root_path)
    end
  end
end
