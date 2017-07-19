module ControllerMacros
  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in FactoryGirl.create(:user)
    end
    let(:current_user) { subject.current_user }
  end

  def logout_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_out current_user
    end
    let(:current_user) { subject.current_user || FactoryGirl.create(:user) }
  end
end
