require 'rails_helper'

RSpec.describe TagsController, type: :controller do
  describe "GET #fetch" do
    before(:context) { 25.times { |i| create(:tag, text: "#testtag#{i}") } }

    let(:q) { 'testtag' }
    let(:request_exec) { get :fetch, params: { q: q }, format: :json }

    let(:expected_search) { Tag.search_by_text(q).limit(20) }
    let(:expected_result) { ActiveModelSerializers::SerializableResource.new(expected_search) }
    it "finds first 20 tags by :q param and using serializer assigns them @tags" do
      request_exec
      expect(assigns(:tags).to_json).to eq(expected_result.to_json)
    end

    it "renders resulting collection as JSON" do
      request_exec
      expect(response.header['Content-Type']).to match('application/json')
      expect(response.body).to eq(expected_result.to_json)
    end

    include_examples "does not require authentication"
  end
end
