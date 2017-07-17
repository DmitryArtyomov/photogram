require 'rails_helper'

RSpec.describe AlbumsController, type: :controller do
  login_user

  shared_examples "assign_var" do |var|
    it "assigns @#{var.to_s}" do
      expect(assigns(var)).to eq(send(var))
    end
  end

  shared_examples "assigns album with attributes" do
    it "assigns @album" do
      expect(assigns(:album).attributes.except('created_at', 'updated_at', 'id'))
        .to eq(user.albums.build(album_attributes.except('tags')).attributes.except('created_at', 'updated_at', 'id'))
    end
  end

  shared_examples "saves tags" do
    it "saves @album tags" do
      expect(assigns(:album).tags.map { |t| t.text }).to eq(album_attributes['tags'])
    end
  end

  describe "GET #new" do
    let(:user) { current_user }
    before(:example) { get :new, params: { user_id: user.id } }
    include_examples "assign_var", :user

    it "assigns new @album" do
      expect(assigns(:album)).to be_a_new(Album).with(user_id: user.id)
    end

    it "renders the 'new' template" do
      expect(response).to render_template("new")
    end
  end


  describe "POST #create" do
    let(:user) { current_user }
    before(:example) { post :create, params: { user_id: user.id, album: album_attributes } }
    let(:album_attributes) do
      FactoryGirl.attributes_for(:album).tap do |attr|
        attr['tags'] = 5.times.map { FactoryGirl.attributes_for(:tag)[:text] }.uniq
      end
    end

    context 'with valid params' do
      include_examples "assign_var", :user
      include_examples "assigns album with attributes"

      it "saves @album" do
        expect(assigns(:album)).to_not be_new_record
      end

      include_examples "saves tags"

      it "redirects to show with a success flash" do
        expect(flash[:success]).to_not eq(nil)
        expect(response).to redirect_to(user_album_path(id: assigns(:album).id))
      end
    end

    context 'with invalid params' do
      let(:album_attributes) { FactoryGirl.attributes_for(:album).tap { |attr| attr[:name] = '' } }
      include_examples "assign_var", :user
      include_examples "assigns album with attributes"

      it "doesn't save @album" do
        expect(assigns(:album)).to be_new_record
      end

      it "renders 'new' with an alert flash" do
        expect(flash[:alert]).to_not eq(nil)
        expect(response).to render_template("new")
      end
    end
  end


  describe "GET #show" do
    let(:album) { create(:album_with_photos) }
    let(:user) { album.user }
    before(:example) { get :show, params: { user_id: user.id, id: album.id } }

    include_examples "assign_var", :user
    include_examples "assign_var", :album

    it "assigns @followership" do
      expect(assigns(:followership)).to eq(user.passive_followerships.find_by(follower_id: current_user.id))
    end

    it "assigns @photos" do
      expect(assigns(:photos)).to eq(album.photos.order(created_at: :desc))
    end

    it "renders 'show' template" do
      expect(response).to render_template("show")
    end
  end


  describe "GET #edit" do
    let(:user) { current_user }
    let(:album) { create(:album, user: user) }
    before(:example) { get :edit, params: { user_id: user.id, id: album.id } }

    include_examples "assign_var", :user
    include_examples "assign_var", :album

    it "renders 'edit' template" do
      expect(response).to render_template("edit")
    end
  end

  describe "PATCH #update" do
    let(:user) { current_user }
    let(:album) { create(:album, user: user) }
    let(:album_attributes) do
      FactoryGirl.attributes_for(:album).tap do |attr|
        attr['tags'] = 5.times.map { FactoryGirl.attributes_for(:tag)[:text] }.uniq
      end
    end

    before(:example) { patch :update, params: { user_id: user.id, id: album.id, album: album_attributes } }

    context 'with valid params' do
      include_examples "assign_var", :user
      include_examples "assigns album with attributes"

      it "saves @album" do
        expect(assigns(:album).changed?).to eq(false)
      end

      include_examples "saves tags"

      it "redirects to show with a success flash" do
        expect(flash[:success]).to_not eq(nil)
        expect(response).to redirect_to(user_album_path(id: assigns(:album).id))
      end
    end

    context 'with invalid params' do
      let(:album_attributes) { FactoryGirl.attributes_for(:album).tap { |attr| attr[:name] = '' } }
      include_examples "assign_var", :user
      include_examples "assigns album with attributes"

      it "doesn't save @album" do
        expect(assigns(:album).changed?).to eq(true)
      end

      it "renders 'edit' with an alert flash" do
        expect(flash[:alert]).to_not eq(nil)
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    let(:user) { current_user }
    let(:album) { create(:album, user: user) }

    context 'successful destroy' do
      before(:example) { delete :destroy, params: { user_id: user.id, id: album.id } }
      include_examples "assign_var", :user
      include_examples "assign_var", :album

      it "destroys the album" do
        expect(assigns(:album).destroyed?).to eq(true)
      end

      it "redirects to user show with a success flash" do
        expect(flash[:success]).to_not eq(nil)
        expect(response).to redirect_to(user_path(id: user.id))
      end
    end

    context 'unsuccessful destroy' do
      before(:example) { allow_any_instance_of(Album).to receive(:destroy).and_return(false) }
      before(:example) { delete :destroy, params: { user_id: user.id, id: album.id } }

      include_examples "assign_var", :user
      include_examples "assign_var", :album

      it "doesn't destroy the album" do
        expect(assigns(:album).destroyed?).to eq(false)
      end

      it "renders 'edit' with an alert flash" do
        expect(flash[:alert]).to_not eq(nil)
        expect(response).to render_template("edit")
      end
    end
  end
end
