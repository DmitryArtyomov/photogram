require 'rails_helper'
require_relative 'shared'

RSpec.describe AlbumsController, type: :controller do
  login_user

  describe "POST #create" do
    let(:user) { current_user }
    let(:request_exec) { post :create, params: { user_id: user.id, album: album_attributes } }
    let(:album_attributes) do
      FactoryGirl.attributes_for(:album).tap do |attr|
        attr['tags'] = 5.times.map { FactoryGirl.attributes_for(:tag)[:text] }.uniq
      end
    end

    context 'with valid params' do
      include_examples "assign_var", :user
      include_examples "assigns album with attributes"

      it "saves @album" do
        expect{ request_exec }.to change{ Album.count }.by(1)
        expect(assigns(:album)).to_not be_new_record
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
        expect(assigns(:album)).to be_new_record
      end

      it "renders 'new' with an alert flash" do
        expect{ request_exec }.to_not change{ Album.count }
        expect(flash[:alert]).to_not eq(nil)
        expect(response).to render_template("new")
      end
    end

    include_examples "requires authentication"
  end
end
