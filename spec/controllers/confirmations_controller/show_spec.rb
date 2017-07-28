require 'rails_helper'

RSpec.describe ConfirmationsController, type: :controller do
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe "GET #show" do
    let!(:user) { create(:user_not_confirmed) }
    let(:request_exec) { get :show, params: { confirmation_token: user.confirmation_token } }
    let(:ouc) { class_double("Operations::Users::Confirm").as_stubbed_const }
    before(:example) { allow(ouc).to receive_message_chain(:new, :execute) }

    context "valid user" do
      it "calls Operations::Users::Confirm" do
        expect(ouc).to receive(:new).with(user)
        expect(ouc).to receive_message_chain(:new, :execute)
        request_exec
      end
    end

    context "invalid user" do
      before(:example) { allow_any_instance_of(User).to receive(:valid?).and_return(false) }
      it "doesn't call Operations::Users::Confirm" do
        expect(ouc).to_not receive(:new)
        request_exec
      end
    end
  end
end
