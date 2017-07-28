require 'rails_helper'

RSpec.describe FeedsController, type: :controller do
  login_user

  describe "GET #show" do
    let(:album) { create(:album_with_photos, photos_count: 20) }
    before(:example) { create(:followership, follower: current_user, followed: album.user) }
    let(:request_exec) { get :show }

    context 'default request' do
      it "assigns 10 latest photos to @feed" do
        request_exec
        expect(assigns(:feed)).to eq current_user.feed_photos.order(created_at: :desc).includes(album: :user).first(10)
      end

      it "renders 'show' template" do
        request_exec
        expect(response).to render_template("show")
      end
    end

    context 'XHR request' do
      let(:request_exec) { get :show, xhr: true, params: { last: last_id } }
      let(:last_id) { Photo.last(10).first.id }

      it "assigns 5 photos previous to :last photo to @feed" do
        request_exec
        expect(assigns(:feed)).to eq current_user.feed_photos.order(created_at: :desc).includes(album: :user)
          .where("photos.id < #{last_id}").first(5)
      end

      it "doesn't render 'show' template" do
        request_exec
        expect(response).to_not render_template("show")
      end

      it "renders @feed as a collection" do
        request_exec
        expect(response).to render_template('photos/_photo')
      end
    end

    include_examples "requires authentication"
  end
end
