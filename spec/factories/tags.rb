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

FactoryGirl.define do
  factory :tag do
    text { "##{Faker::Lorem.word[0..19]}" }

    factory :tag_with_photos_and_albums do
      transient do
        photos_count 5
        albums_count 5
      end

      after(:create) do |tag, evaluator|
        tag.photos = create_list(:photo, evaluator.photos_count)
        tag.albums = create_list(:album, evaluator.photos_count)
      end
    end
  end
end
