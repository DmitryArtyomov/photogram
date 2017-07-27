require 'rails_helper'
require_relative 'shared'

RSpec.describe PhotosController, type: :controller do
  login_user

  describe "POST #create" do
    let(:user) { current_user }
    let(:album) { create(:album, user: user) }
    let(:request_exec) { post :create, params: { user_id: user.id, album_id: album.id, photo: photo_attributes } }
    let(:photo_attributes) do
      FactoryGirl.attributes_for(:photo).tap do |attr|
        attr['tags'] = 5.times.map { FactoryGirl.attributes_for(:tag)[:text] }.uniq
      end
    end

    context 'with valid params' do
      include_examples "assign_vars", :user, :album
      include_examples "assigns photo with attributes"

      it "saves @photo" do
        expect{ request_exec }.to change{ Photo.count }.by(1)
        expect(assigns(:photo)).to_not be_new_record
      end

      include_examples "saves photo tags"

      it "touches @album" do
        expect{ request_exec }.to change{ album.reload.updated_at }
      end

      it "redirects to album page with a success flash" do
        request_exec
        expect(flash[:success]).to_not eq(nil)
        expect(response).to redirect_to(user_album_path(id: album.id))
      end
    end

    context 'with invalid params' do
      let(:photo_attributes) { FactoryGirl.attributes_for(:photo).tap { |attr| attr[:image] = nil } }
      include_examples "assign_vars", :user, :album
      include_examples "assigns photo with attributes"

      it "doesn't save @photo" do
        expect{ request_exec }.to_not change{ Photo.count }
        expect(assigns(:photo)).to be_new_record
      end

      it "doesn't touch @album" do
        expect{ request_exec }.to_not change{ album.reload.updated_at }
      end

      it "renders 'new' with an alert flash" do
        request_exec
        expect(flash[:alert]).to_not eq(nil)
        expect(response).to render_template("new")
      end
    end

    include_examples "requires authentication"
    include_examples 'cancancan_used'
  end
end
