require 'rails_helper'

RSpec.describe TagsController, type: :controller do
  describe "GET #show" do
    let(:request_exec) { get :show, params: { id: tag.text[1..-1] } }
    let(:tag) { create(:tag_with_photos_and_albums) }

    context 'tag exists' do
      let(:photos) { tag.photos }
      let(:albums) { tag.albums }

      include_examples "assign_vars", :tag, :photos, :albums

      it "renders 'show' template" do
        request_exec
        expect(response).to render_template("show")
      end
    end

    context "tag doesn't exist" do
      let(:tag) { build(:tag) }

      include_examples "not_assign_vars", :tag, :photos, :albums

      it "renders 'show' template" do
        request_exec
        expect(response).to render_template("show")
      end
    end

    include_examples "does not require authentication"
    include_examples 'cancancan_used'
  end
end
