require 'rails_helper'
require_relative 'shared'

RSpec.describe PhotosController, type: :controller do
  login_user

  describe "DELETE #destroy" do
    let(:user)  { current_user }
    let(:album) { create(:album, user: user) }
    let!(:photo) { create(:photo, album: album) }
    let(:request_exec) { delete :destroy, params: { user_id: user.id, album_id: album.id, id: photo.id } }

    context 'successful destroy' do
      include_examples "assign_vars", :user, :album, :photo

      it "destroys the photo" do
        expect{ request_exec }.to change{ Photo.count }.by(-1)
        expect(assigns(:photo).destroyed?).to eq(true)
      end

      it "redirects to album page with a success flash" do
        request_exec
        expect(flash[:success]).to_not eq(nil)
        expect(response).to redirect_to(user_album_path(id: album.id))
      end
    end

    context 'unsuccessful destroy' do
      before(:example) { allow_any_instance_of(Photo).to receive(:destroy).and_return(false) }

      include_examples "assign_vars", :user, :album, :photo

      it "doesn't destroy the photo" do
        expect{ request_exec }.to_not change{ Photo.count }
        expect(assigns(:photo).destroyed?).to eq(false)
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
