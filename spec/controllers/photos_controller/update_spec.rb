require 'rails_helper'
require_relative 'shared'

RSpec.describe PhotosController, type: :controller do
  login_user

  describe "PATCH #update" do
    let(:user)  { current_user }
    let(:album) { create(:album, user: user) }
    let(:photo) { create(:photo, album: album) }
    let(:photo_attributes) do
      FactoryGirl.attributes_for(:photo).tap do |attr|
        attr['tags'] = 5.times.map { FactoryGirl.attributes_for(:tag)[:text] }.uniq
      end
    end

    let(:request_exec) { patch :update, params: { user_id: user.id, album_id: album.id, id: photo.id, photo: photo_attributes } }

    context 'with valid params' do
      include_examples "assign_vars", :user, :album
      include_examples "assigns photo with attributes"

      it "saves @photo" do
        request_exec
        expect(assigns(:photo).changed?).to eq(false)
      end

      include_examples "saves photo tags"

      it "redirects to show with a success flash" do
        request_exec
        expect(flash[:success]).to_not eq(nil)
        expect(response).to redirect_to(user_album_photo_path(id: assigns(:photo).id))
      end
    end

    context 'with invalid params' do
      let(:photo_attributes) { FactoryGirl.attributes_for(:photo).tap { |attr| attr[:image] = nil } }
      include_examples "assign_vars", :user, :album
      include_examples "assigns photo with attributes"

      it "doesn't save @photo" do
        request_exec
        expect(assigns(:photo).changed?).to eq(true)
      end

      it "renders 'edit' with an alert flash" do
        request_exec
        expect(flash[:alert]).to_not eq(nil)
        expect(response).to render_template("edit")
      end
    end

    include_examples "requires authentication"
    include_examples 'cancancan_used'
  end
end
