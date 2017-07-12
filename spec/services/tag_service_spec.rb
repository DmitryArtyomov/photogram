require 'rails_helper'

RSpec.describe TagService do
  subject { described_class.new(tags) }
  let(:output_tags) { subject.tags }

  context '#tags' do
    shared_examples 'return value' do |input:, input_val:, return_val:, returns:|
      context input do
        let(:tags) { input_val }
        it "returns #{returns}" do
          expect(subject.tags).to eq(return_val)
        end
      end
    end

    include_examples 'return value', input: 'empty input array', input_val: [],  return_val: [], returns: 'empty array'
    include_examples 'return value', input: 'nil input',         input_val: nil, return_val: [], returns: 'empty array'
    include_examples 'return value', input: 'invalid format input',
      input_val: ['tag', ' ', '322', '#', '#123456789012345678901'], return_val: [], returns: 'empty array'

    context 'valid tags' do
      let(:tags) { ['#firsttag', '#secondtag', '#thirdtag'] }

      context 'new tags' do
        it "returns a collection of newly created tags" do
          expect(output_tags.length).to eql(tags.length)
          expect(output_tags.map { |t| t.text }).to eql(tags)
        end
      end

      context 'existing tags' do
        it "returns a collection of already existing tags" do
          existing_collection = output_tags
          expect(described_class.new(tags).tags).to eql(existing_collection)
        end
      end
    end

    context 'both valid & invalid tags' do
      let(:tags) { ['#mytag', 'invalidtag', '#anothertag', '#invalid_tag'] }
      let(:valid_tags) { ['#mytag', '#anothertag'] }

      it "returns a collection of valid tags" do
        expect(output_tags.length).to eql(2)
        expect(output_tags.map { |t| t.text }).to eql(valid_tags)
      end
    end
  end
end
