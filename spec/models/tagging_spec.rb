# == Schema Information
#
# Table name: taggings
#
#  tag_id        :integer
#  taggable_type :string
#  taggable_id   :integer
#
# Indexes
#
#  index_taggings_on_tag_id                                    (tag_id)
#  index_taggings_on_tag_id_and_taggable_id_and_taggable_type  (tag_id,taggable_id,taggable_type) UNIQUE
#  index_taggings_on_taggable_type_and_taggable_id             (taggable_type,taggable_id)
#
# Foreign Keys
#
#  fk_rails_...  (tag_id => tags.id) ON DELETE => cascade
#

require 'rails_helper'

RSpec.describe Tagging, type: :model do

  shared_context 'attribute validations' do
    include_examples 'empty attribute validation', empty_attribute: nil,       validity: true
    include_examples 'empty attribute validation', empty_attribute: :tag,      validity: false
    include_examples 'empty attribute validation', empty_attribute: :taggable, validity: false

    it 'is not valid if such tagging already exists' do
      subject.dup.save
      expect(subject).to_not be_valid
    end
  end

  context 'photo tags' do
    include_context 'attribute validations' do
      subject { build(:tagging_with_photo) }
    end
  end

  context 'album tags' do
    include_context 'attribute validations' do
      subject { build(:tagging_with_album) }
    end
  end

end
