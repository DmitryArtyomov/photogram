require 'rails_helper'

RSpec.describe HomepageController, type: :controller do

  describe "GET #index" do
    let(:request_exec) { get :index }

    context "logged in user" do
      login_user
      it "redirects to feed" do
        request_exec
        expect(response).to redirect_to(:feed)
      end
    end

    context "logged out user" do
      logout_user
      it "renders 'index' template" do
        request_exec
        expect(response).to render_template("index")
      end
    end
  end
end
