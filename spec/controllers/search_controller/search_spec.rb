require 'rails_helper'

RSpec.describe SearchController, type: :controller do
  describe "GET #search" do
    let(:q) { 'test' }
    let(:request_exec) { get :search, params: { q: q }, format: :json }
    let(:ss) { class_double("SearchService").as_stubbed_const }
    before(:example) { allow(ss).to receive_message_chain(:new, :search).and_return(test_hash) }
    let(:test_hash) { { test: 'test' } }

    it "uses SearchService to find records and assigns them to @result" do
      expect(ss).to receive(:new).with(q)
      expect(ss).to receive_message_chain(:new, :search)
      request_exec
      expect(assigns(:result)).to eq(test_hash)
    end

    it "renders result collection as JSON" do
      request_exec
      expect(response.header['Content-Type']).to match('application/json')
      expect(response.body).to eq(test_hash.to_json)
    end

    include_examples "does not require authentication"
  end
end
