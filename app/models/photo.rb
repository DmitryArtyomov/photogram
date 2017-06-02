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
#  fk_rails_2593557582  (album_id => albums.id) ON DELETE => cascade
#

class Photo < ApplicationRecord
  belongs_to :album
  has_and_belongs_to_many :tags

  mount_uploader :image, PhotoUploader

  validates_presence_of :image
end
