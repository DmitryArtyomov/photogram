require 'rails_helper'
require_relative 'shared'

RSpec.describe PhotosController, type: :controller do
  login_user

  describe "GET #new" do
    let(:user) { current_user }
    let(:album) { create(:album, user: user) }
    let(:request_exec) { get :new, params: { user_id: user.id, album_id: album.id } }
    include_examples "assign_vars", :user, :album

    it "assigns new @photo" do
      request_exec
      expect(assigns(:photo)).to be_a_new(Photo).with(album_id: album.id)
    end

    it "renders the 'new' template" do
      request_exec
      expect(response).to render_template("new")
    end

    include_examples "requires authentication"
    include_examples 'cancancan_used'
  end
end
