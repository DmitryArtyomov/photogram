require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  login_user

  describe "GET #edit" do
    let(:user) { current_user }
    let(:request_exec) { get :edit, params: { id: user.id } }

    include_examples "assign_vars", :user

    it "renders 'edit' template" do
      request_exec
      expect(response).to render_template("edit")
    end

    include_examples "requires authentication"
    include_examples 'cancancan_used'
  end
end
