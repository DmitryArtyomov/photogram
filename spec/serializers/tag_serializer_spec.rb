require 'rails_helper'
require_relative 'shared'

RSpec.describe TagSerializer do
  let(:sample) { create(:tag) }
  subject { JSON.parse(described_class.new(sample).to_json) }

  include_examples "contains fields", :text

  it "contains 'items_count' field" do
    expect(subject['items_count']).to eq(sample.taggings_count)
  end

  include_examples "fields count", 2
end
