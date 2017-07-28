# == Schema Information
#
# Table name: tags
#
#  id             :integer          not null, primary key
#  text           :string(20)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  taggings_count :integer          default(0)
#
# Indexes
#
#  index_tags_on_text  (text) UNIQUE
#

require 'rails_helper'

RSpec.describe Tag, type: :model do
  context 'attribute validators' do
    subject { build(:tag) }
    include_examples 'empty attribute validation', empty_attribute: nil,     validity: true
    include_examples 'empty attribute validation', empty_attribute: :text,   validity: false

    context 'text' do
      it 'is valid with russian symbols' do
        subject.text = '#ТэгЁё'
        expect(subject).to be_valid
      end

      it 'is valid with numbers' do
        subject.text = '#0123456789'
        expect(subject).to be_valid
      end

      it 'is not valid without #' do
        subject.text = Faker::Lorem.word[0..19]
        expect(subject).to_not be_valid
      end

      include_examples 'text length validation', length: 0,  prefix: '#', validity: false
      include_examples 'text length validation', length: 1,  prefix: '#', validity: true
      include_examples 'text length validation', length: 20, prefix: '#', validity: true
      include_examples 'text length validation', length: 21, prefix: '#', validity: false

      it 'is not valid if tag with such text exists' do
        subject.dup.save
        expect(subject).to_not be_valid
      end
    end
  end

  context 'instance methods' do
    subject { create(:tag) }
    describe '#display_name' do
      it 'should return text' do
        expect(subject.display_name).to eq subject.text
      end
    end
  end
end
