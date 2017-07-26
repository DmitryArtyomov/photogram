require 'rails_helper'
require_relative 'shared'

RSpec.describe AlbumsController, type: :controller do
  login_user

  describe "GET #show" do
    let(:album) { create(:album_with_photos) }
    let(:user) { album.user }
    let(:request_exec) { get :show, params: { user_id: user.id, id: album.id } }

    include_examples "assign_vars", :user, :album

    it "assigns @followership" do
      request_exec
      expect(assigns(:followership)).to eq(user.passive_followerships.find_by(follower_id: current_user.id))
    end

    it "assigns @photos" do
      request_exec
      expect(assigns(:photos)).to eq(album.photos.order(created_at: :desc))
    end

    it "renders 'show' template" do
      request_exec
      expect(response).to render_template("show")
    end

    include_examples "does not require authentication"
    include_examples 'cancancan_used'
  end
end
