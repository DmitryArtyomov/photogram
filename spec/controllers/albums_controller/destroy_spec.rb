require 'rails_helper'
require_relative 'shared'

RSpec.describe AlbumsController, type: :controller do
  login_user

  describe "DELETE #destroy" do
    let(:user) { current_user }
    let!(:album) { create(:album, user: user) }
    let(:request_exec) { delete :destroy, params: { user_id: user.id, id: album.id } }

    context 'successful destroy' do
      include_examples "assign_vars", :user, :album

      it "destroys the album" do
        expect{ request_exec }.to change{ Album.count }.by(-1)
        expect(assigns(:album).destroyed?).to eq(true)
      end

      it "redirects to user show with a success flash" do
        request_exec
        expect(flash[:success]).to_not eq(nil)
        expect(response).to redirect_to(user_path(id: user.id))
      end
    end

    context 'unsuccessful destroy' do
      before(:example) { allow_any_instance_of(Album).to receive(:destroy).and_return(false) }

      include_examples "assign_vars", :user, :album

      it "doesn't destroy the album" do
        expect{ request_exec }.to_not change{ Album.count }
        expect(assigns(:album).destroyed?).to eq(false)
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
