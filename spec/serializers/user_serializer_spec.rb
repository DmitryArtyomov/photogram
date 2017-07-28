require 'rails_helper'
require_relative 'shared'

RSpec.describe UserSerializer do
  let(:stubbed_result)  { { 'test' => 'test' } }
  before(:example)      { allow(ActionController::Base).to receive_message_chain(:helpers, :asset_path).and_return(stubbed_result) }
  let(:sample)          { create(:user) }

  subject { JSON.parse(described_class.new(sample).to_json) }

  include_examples "contains fields", :id, :first_name, :last_name

  context "user with avatar" do
    it "contains 'avatar' field with avatar url" do
      expect(subject['avatar']).to eq(sample.avatar.url)
    end
  end

  context "user without avatar" do
    let(:sample) { create(:user, avatar: nil) }
    it "contains 'avatar' field with noavatar-image url" do
      expect(subject['avatar']).to eq(stubbed_result)
    end
  end

  it "contains 'followers' field" do
    expect(subject['followers']).to eq(sample.followers_count)
  end

  include_examples "fields count", 5
end
