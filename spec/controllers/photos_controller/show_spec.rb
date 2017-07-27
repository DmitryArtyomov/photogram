require 'rails_helper'
require_relative 'shared'

RSpec.describe PhotosController, type: :controller do
  login_user

  describe "GET #show" do
    let(:photo) { create(:photo_with_comments) }
    let(:album) { photo.album }
    let(:user)  { album.user }
    let(:request_exec) { get :show, params: { user_id: user.id, album_id: album.id, id: photo.id} }

    include_examples "assign_vars", :user, :album, :photo

    it "assigns @comments" do
      request_exec
      expect(assigns(:comments)).to eq(photo.comments.order(created_at: :asc))
    end

    context "default request" do
      it "renders 'show' template with layout" do
        request_exec
        expect(response).to render_template("show")
        expect(response).to render_template(layout: "application")
      end
    end

    context "XHR request" do
      let(:request_exec) { get :show, xhr: true, params: { user_id: user.id, album_id: album.id, id: photo.id} }

      it "renders 'show' template without layout" do
        request_exec
        expect(response).to render_template("show")
        expect(response).to_not render_template(layout: "application")
      end
    end

    include_examples "does not require authentication"
    include_examples 'cancancan_used'
  end
end
