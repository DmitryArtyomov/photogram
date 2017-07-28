require 'rails_helper'

describe ApplicationController, type: :controller do
  let(:user) { create(:user) }
  let(:stubbed_result) { :bar }
  let(:execute) { subject.after_sign_in_path_for(user) }

  describe "#after_sign_in_path_for" do
    context "request from new_user_session_url" do
      before(:example) { allow_any_instance_of(ActionController::Base).to receive(:after_sign_in_path_for).and_return(stubbed_result) }
      before(:example) { allow(request).to receive(:referrer).and_return(new_user_session_url) }

      it "calls super" do
        expect(execute).to eq(stubbed_result)
      end
    end

    context "request from another place" do
      context "stored_location_for is not nil" do
        before(:example) { allow_any_instance_of(ActionController::Base).to receive(:stored_location_for).and_return(stubbed_result) }

        it "returns stored_location_for" do
          expect(execute).to eq(stubbed_result)
        end
      end

      context "stored_location_for is nil" do
        before(:example) { allow_any_instance_of(ActionController::Base).to receive(:stored_location_for).and_return(nil) }

        context "referrer is not nil" do
          before(:example) { allow(request).to receive(:referrer).and_return(stubbed_result) }

          it "returns request.referrer" do
            expect(execute).to eq(stubbed_result)
          end
        end

        context "referrer is nil" do
          before(:example) { allow(request).to receive(:referrer).and_return(nil) }

          it "returns user profile path" do
            expect(execute).to eq(user_path(user))
          end
        end
      end
    end
  end
end
