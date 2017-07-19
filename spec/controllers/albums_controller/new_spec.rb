require 'rails_helper'
require_relative 'shared'

RSpec.describe AlbumsController, type: :controller do
  login_user

  describe "GET #new" do
    let(:user) { current_user }
    let(:request_exec) { get :new, params: { user_id: user.id } }
    include_examples "assign_var", :user

    it "assigns new @album" do
      request_exec
      expect(assigns(:album)).to be_a_new(Album).with(user_id: user.id)
    end

    it "renders the 'new' template" do
      request_exec
      expect(response).to render_template("new")
    end

    include_examples "requires authentication"
  end
end
