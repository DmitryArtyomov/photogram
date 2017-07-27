# == Schema Information
#
# Table name: photos
#
#  id          :integer          not null, primary key
#  description :text
#  image       :string
#  album_id    :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_photos_on_album_id  (album_id)
#
# Foreign Keys
#
#  fk_rails_...  (album_id => albums.id) ON DELETE => cascade
#

FactoryGirl.define do
  factory :photo do
    description { Faker::Lorem.sentence }
    image     { Rack::Test::UploadedFile.new(File.join(Rails.root, '/spec/fixtures/photo.jpg'), 'image/jpg') }
    association :album, strategy: :build

    factory :photo_with_comments do
      transient do
        comments_count 5
      end

      after(:create) do |photo, evaluator|
        photo.comments = build_list(:comment, evaluator.comments_count, photo: photo)
      end
    end
  end
end
