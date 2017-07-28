require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  login_user

  describe "GET #show" do
    let(:user)   { create(:user_with_albums) }
    let(:albums) { user.albums.order(updated_at: :desc) }
    let(:request_exec) { get :show, params: { id: user.id } }

    include_examples "assign_vars", :user, :albums

    context "signed in user" do
      let!(:followership) { create(:followership, follower: current_user, followed: user) }
      include_examples "assign_vars", :followership
    end

    context "signed out user" do
      logout_user
      include_examples "not_assign_vars", :followership
    end

    it "renders 'show' template" do
      request_exec
      expect(response).to render_template("show")
    end

    include_examples "does not require authentication"
    include_examples 'cancancan_used'
  end
end
