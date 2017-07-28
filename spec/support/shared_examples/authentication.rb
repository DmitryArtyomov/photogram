shared_examples "requires authentication" do
  context "unauthenticated" do
    logout_user
    it "redirects to sign-in page" do
      expect(request_exec).to redirect_to(new_user_session_url)
    end
  end
end

shared_examples "does not require authentication" do
  context "unauthenticated" do
    logout_user
    it "does not redirect to sign-in page" do
      expect(request_exec).to_not redirect_to(new_user_session_url)
    end
  end
end
