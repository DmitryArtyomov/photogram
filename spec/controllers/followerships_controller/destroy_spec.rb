require 'rails_helper'

RSpec.describe FollowershipsController, type: :controller do
  login_user

  describe "DELETE #destroy" do
    before(:each) do
      request.env['HTTP_REFERER'] = root_url
    end

    let(:user) { current_user }
    let!(:followership) { create(:followership, follower: user) }
    let(:request_exec) { delete :destroy, params: { user_id: user.id, id: followership.id } }

    context 'successful destroy' do
      include_examples "assign_vars", :user, :followership

      it "destroys the followership" do
        expect{ request_exec }.to change{ Followership.count }.by(-1)
        expect(assigns(:followership).destroyed?).to eq(true)
      end

      it "redirects back with a success flash" do
        request_exec
        expect(flash[:success]).to_not eq(nil)
        expect(response).to redirect_to(request.env['HTTP_REFERER'])
      end
    end

    context 'unsuccessful destroy' do
      before(:example) { allow_any_instance_of(Followership).to receive(:destroy).and_return(false) }

      include_examples "assign_vars", :user, :followership

      it "doesn't destroy the followership" do
        expect{ request_exec }.to_not change{ Followership.count }
        expect(assigns(:followership).destroyed?).to eq(false)
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
