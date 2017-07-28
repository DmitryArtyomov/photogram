require 'rails_helper'
require_relative 'shared'

RSpec.describe AlbumSerializer do
  let(:stubbed_result)  { { 'test' => 'test' } }
  before(:example)      { allow(ActiveModelSerializers::SerializableResource).to receive(:new).and_return(stubbed_result) }
  let(:sample)          { create(:album) }

  subject { JSON.parse(described_class.new(sample).to_json) }

  include_examples "contains fields", :id, :name, :description, :photos_count

  it "contains 'user' field" do
    expect(subject['user']).to eq(stubbed_result)
  end

  include_examples "fields count", 5
end
