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
    image       { File.open(File.join(Rails.root, '/spec/fixtures/photo.jpg')) }
    association :album, strategy: :build
  end
end
