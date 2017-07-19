require 'rails_helper'
require_relative 'shared'

RSpec.describe AlbumsController, type: :controller do
  login_user

  describe "GET #edit" do
    let(:user) { current_user }
    let(:album) { create(:album, user: user) }
    let(:request_exec) { get :edit, params: { user_id: user.id, id: album.id } }

    include_examples "assign_var", :user
    include_examples "assign_var", :album

    it "renders 'edit' template" do
      request_exec
      expect(response).to render_template("edit")
    end

    include_examples "requires authentication"
  end
end
