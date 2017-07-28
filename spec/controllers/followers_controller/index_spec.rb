require 'rails_helper'

RSpec.describe FollowersController, type: :controller do
  login_user

  describe "GET #index" do
    let(:user) { create(:user_followed) }
    let(:request_exec) { get :index, params: { user_id: user.id } }
    let(:fs) { class_double("FollowershipsService").as_stubbed_const }
    before(:example) { allow(fs).to receive_message_chain(:new, :get).and_return([]) }

    include_examples "assign_vars", :user

    it "assigns @followers" do
      request_exec
      expect(assigns[:followers]).to eq(user.followers)
    end

    it "assigns @current_following using FollowershipsService" do
      expect(fs).to receive(:new).with(current_user)
      expect(fs).to receive_message_chain(:new, :get)
      request_exec
      expect(assigns[:current_following]).to eq([])
    end

    it "renders 'index' template" do
      request_exec
      expect(response).to render_template("index")
    end

    include_examples "does not require authentication"
    include_examples 'cancancan_used'
  end
end
