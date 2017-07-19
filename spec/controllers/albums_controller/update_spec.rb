require 'rails_helper'
require_relative 'shared'

RSpec.describe AlbumsController, type: :controller do
  login_user

  describe "PATCH #update" do
    let(:user) { current_user }
    let(:album) { create(:album, user: user) }
    let(:album_attributes) do
      FactoryGirl.attributes_for(:album).tap do |attr|
        attr['tags'] = 5.times.map { FactoryGirl.attributes_for(:tag)[:text] }.uniq
      end
    end

    let(:request_exec) { patch :update, params: { user_id: user.id, id: album.id, album: album_attributes } }

    context 'with valid params' do
      include_examples "assign_var", :user
      include_examples "assigns album with attributes"

      it "saves @album" do
        request_exec
        expect(assigns(:album).changed?).to eq(false)
      end

      include_examples "saves tags"

      it "redirects to show with a success flash" do
        request_exec
        expect(flash[:success]).to_not eq(nil)
        expect(response).to redirect_to(user_album_path(id: assigns(:album).id))
      end
    end

    context 'with invalid params' do
      let(:album_attributes) { FactoryGirl.attributes_for(:album).tap { |attr| attr[:name] = '' } }
      include_examples "assign_var", :user
      include_examples "assigns album with attributes"

      it "doesn't save @album" do
        request_exec
        expect(assigns(:album).changed?).to eq(true)
      end

      it "renders 'edit' with an alert flash" do
        request_exec
        expect(flash[:alert]).to_not eq(nil)
        expect(response).to render_template("edit")
      end
    end

    include_examples "requires authentication"
  end
end
