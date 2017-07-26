require 'rails_helper'
require_relative 'shared'

RSpec.describe CommentsController, type: :controller do
  login_user

  describe "DELETE #destroy" do
    let(:request_exec) { delete :destroy, params: { user_id: user.id, album_id: album.id, photo_id: photo.id,
      id: comment.id } }
    shared_context "XHR_destroy" do
      let(:request_exec) { delete :destroy, xhr: true, params: { user_id: user.id, album_id: album.id,
        photo_id: photo.id, id: comment.id } }
    end

    let(:user) { current_user }
    let(:album) { create(:album, user: user) }
    let(:photo) { create(:photo, album: album) }
    let!(:comment) { create(:comment, photo: photo, user: user) }

    context 'successful destroy' do
      include_examples "assign_varss", :user, :album, :photo, :comment

      it "destroys the comment" do
        expect{ request_exec }.to change{ Comment.count }.by(-1)
        expect(assigns(:comment).destroyed?).to eq(true)
      end

      context 'default request' do
        it "redirects to photo page" do
          request_exec
          expect(response).to redirect_to(user_album_photo_path(id: assigns(:photo).id))
        end
      end

      context "XHR request" do
        include_context "XHR_destroy" do
          it "responds with JS" do
            request_exec
            expect(response).to render_template("destroy")
          end
        end
      end
    end

    context 'unsuccessful destroy' do
      before(:example) { allow_any_instance_of(Comment).to receive(:destroy).and_return(false) }

      include_examples "assign_varss", :user, :album, :photo, :comment

      it "doesn't destroy the comment" do
        expect{ request_exec }.to_not change{ Comment.count }
        expect(assigns(:comment).destroyed?).to eq(false)
      end

      context 'default request' do
        it "redirects to photo page with an alert flash" do
          request_exec
          expect(flash[:alert]).to_not eq(nil)
          expect(response).to redirect_to(user_album_photo_path(id: assigns(:photo).id))
        end
      end

      context "XHR request" do
        include_context "XHR_destroy" do
          it "redirects to photo page" do
            request_exec
            expect(flash[:alert]).to_not eq(nil)
            expect(response.body).to match(user_album_photo_path(id: assigns(:photo).id))
          end
        end
      end
    end

    include_examples "requires authentication"
    include_examples 'cancancan_used'
  end
end
