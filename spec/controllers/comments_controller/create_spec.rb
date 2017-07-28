require 'rails_helper'
require_relative 'shared'

RSpec.describe CommentsController, type: :controller do
  login_user

  describe "POST #create" do
    let(:request_exec) { post :create, params: { user_id: user.id, album_id: album.id, photo_id: photo.id,
      comment: comment_attributes } }
    shared_context "XHR_create" do
      let(:request_exec) { post :create, xhr: true, params: { user_id: user.id, album_id: album.id, photo_id: photo.id,
        comment: comment_attributes } }
    end

    let(:ncs) { class_double("Notifications::NewComment").as_stubbed_const }

    let(:user) { current_user }
    let(:album) { create(:album, user: user) }
    let(:photo) { create(:photo, album: album) }
    let(:comment_attributes) { FactoryGirl.attributes_for(:comment) }

    context 'with valid params' do
      include_examples "assign_vars", :user, :album, :photo
      include_examples "assigns comment with attributes"

      it "saves @comment" do
        expect{ request_exec }.to change{ Comment.count }.by(1)
        expect(assigns(:comment)).to_not be_new_record
      end

      it 'sends a notification using Notifications::NewComment service' do
        expect(ncs).to receive_message_chain(:new, :notify)
        request_exec
      end

      context "default request" do
        it "redirects to photo page" do
          request_exec
          expect(response).to redirect_to(user_album_photo_path(id: assigns(:photo).id))
        end
      end

      context "XHR request" do
        include_context "XHR_create" do
          it "responds with JS" do
            request_exec
            expect(response).to render_template("create")
          end
        end
      end
    end

    context 'with invalid params' do
      let(:comment_attributes) { FactoryGirl.attributes_for(:comment).tap { |attr| attr[:text] = '' } }
      include_examples "assign_vars", :user, :album, :photo
      include_examples "assigns comment with attributes"

      it "doesn't save @comment" do
        request_exec
        expect(assigns(:comment)).to be_new_record
      end

      it "doesn't send a notification using Notifications::NewComment service" do
        expect(ncs).to_not receive(:new)
        request_exec
      end

      context "default request" do
        it "redirects to photo page with an alert flash" do
          expect{ request_exec }.to_not change{ Comment.count }
          expect(flash[:alert]).to_not eq(nil)
          expect(response).to redirect_to(user_album_photo_path(id: assigns(:photo).id))
        end
      end

      context "XHR request" do
        include_context "XHR_create" do
          it "redirects to photo page" do
            request_exec
            expect(response.body).to match(user_album_photo_path(id: assigns(:photo).id))
          end
        end
      end
    end

    include_examples "requires authentication"
    include_examples 'cancancan_used'
  end
end
