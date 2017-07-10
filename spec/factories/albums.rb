# == Schema Information
#
# Table name: albums
#
#  id           :integer          not null, primary key
#  name         :string
#  description  :text
#  is_main      :boolean          default(FALSE)
#  user_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  photos_count :integer          default(0)
#
# Indexes
#
#  index_albums_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id) ON DELETE => cascade
#

FactoryGirl.define do
  factory :album do
    name { Faker::Book.title }
    description { Faker::Beer.name }
    association :user, strategy: :build

    factory :album_with_photos do
      transient do
        photos_count 5
      end

      after(:build) do |album, evaluator|
        album.photos = build_list(:photo, evaluator.photos_count, album: album)
      end
    end
  end
end
