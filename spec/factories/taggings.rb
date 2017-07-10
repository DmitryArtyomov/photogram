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

FactoryGirl.define do
  factory :tagging do
    tag
    taggable nil

    factory :tagging_with_photo do
      association :taggable, factory: :photo
    end

    factory :tagging_with_album do
      association :taggable, factory: :album
    end
  end
end
