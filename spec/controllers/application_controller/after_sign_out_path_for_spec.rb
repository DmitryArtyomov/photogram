require 'rails_helper'

describe ApplicationController, type: :controller do
  let(:user) { create(:user) }
  let(:stubbed_result) { :bar }
  let(:execute) { subject.after_sign_out_path_for(user) }

  describe "#after_sign_out_path_for" do
    context "request has referrer" do
      before(:example) { allow(request).to receive(:referrer).and_return(stubbed_result) }

      it "returns request.referrer" do
        expect(execute).to eq(stubbed_result)
      end
    end

    context "request doesn't have referrer" do
      before(:example) { allow(request).to receive(:referrer).and_return(nil) }

      it "returns root_path" do
        expect(execute).to eq(root_path)
      end
    end
  end
end
