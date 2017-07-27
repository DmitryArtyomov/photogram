require 'rails_helper'

RSpec.describe FollowershipsController, type: :controller do
  login_user

  describe "POST #create" do
    before(:each) do
      request.env['HTTP_REFERER'] = root_url
    end

    let(:user) { current_user }
    let(:another_user) { create(:user) }
    let(:request_exec) { post :create, params: { user_id: user.id, followership: followership_attributes } }
    let(:followership_attributes) { { followed_id: another_user.id } }
    let(:nfs) { class_double("Notifications::NewFollower").as_stubbed_const }


    shared_examples "assigns followership with attributes" do
      it "assigns @followership" do
        request_exec
        expect(assigns(:followership).attributes.except('created_at', 'updated_at', 'id'))
          .to eq(user.active_followerships.build(followership_attributes).attributes.except('created_at', 'updated_at', 'id'))
      end
    end

    context 'with valid params' do
      include_examples "assign_vars", :user
      include_examples "assigns followership with attributes"

      it "saves @followership" do
        expect{ request_exec }.to change{ Followership.count }.by(1)
        expect(assigns(:followership)).to_not be_new_record
      end

      it 'sends a notification using Notifications::NewFollower service' do
        expect(nfs).to receive_message_chain(:new, :notify)
        request_exec
      end

      it "redirects back with a success flash" do
        request_exec
        expect(flash[:success]).to_not eq(nil)
        expect(response).to redirect_to(request.env['HTTP_REFERER'])
      end
    end

    context 'with invalid params' do
      before(:example) { allow_any_instance_of(Followership).to receive(:valid?).and_return(false) }
      include_examples "assign_vars", :user
      include_examples "assigns followership with attributes"

      it "doesn't save @followership" do
        expect{ request_exec }.to_not change{ Album.count }
        expect(assigns(:followership)).to be_new_record
      end

      it "doesn't send a notification using Notifications::NewFollower service" do
        expect(nfs).to_not receive(:new)
        request_exec
      end

      it "redirects back with an alert flash" do
        request_exec
        expect(flash[:alert]).to_not eq(nil)
        expect(response).to redirect_to(request.env['HTTP_REFERER'])
      end
    end

    include_examples "requires authentication"
    include_examples 'cancancan_used'
  end
end
