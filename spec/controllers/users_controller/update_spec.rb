require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  login_user

  shared_examples "assigns user with attributes" do
    it "assigns @user" do
      request_exec
      expect(user_attributes.except(:avatar).map { |k, v| assigns(:user).send(k) == v }.select { |v| !v }.empty?).to eq(true)
      expect(assigns(:user).avatar.size).to eq(user_attributes[:avatar].size) if user_attributes[:avatar]
    end
  end

  let(:user_attributes) { FactoryGirl.attributes_for(:user_no_notifications).except(:email, :password, :confirmed_at, :role) }

  describe "PATCH #update" do
    let(:user) { current_user }

    let(:request_exec) { patch :update, params: { id: user.id, user: user_attributes } }

    context 'with valid params' do
      include_examples "assigns user with attributes"

      it "saves @user" do
        request_exec
        expect(assigns(:user).changed?).to eq(false)
      end

      it "redirects to show with a success flash" do
        request_exec
        expect(flash[:success]).to_not eq(nil)
        expect(response).to redirect_to(user_path(id: assigns(:user).id))
      end
    end

    context 'with invalid params' do
      let(:user_attributes) { FactoryGirl.attributes_for(:user_no_notifications).except(:email, :password, :confirmed_at, :role).tap { |a| a[:first_name] = '' } }
      include_examples "assigns user with attributes"

      it "doesn't save @user" do
        request_exec
        expect(assigns(:user).changed?).to eq(true)
      end

      it "renders 'edit' with an alert flash" do
        request_exec
        expect(flash[:alert]).to_not eq(nil)
        expect(response).to render_template("edit")
      end
    end

    include_examples "requires authentication"
    include_examples 'cancancan_used'
  end
end
