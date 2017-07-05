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

class Photo < ApplicationRecord
  belongs_to :album, counter_cache: true

  has_many :taggings, as: :taggable
  has_many :tags, through: :taggings, dependent: :destroy

  has_many :comments

  mount_uploader :image, PhotoUploader

  validates_presence_of :image

  def display_name
    "Photo ##{id}"
  end
end
