# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  text       :string
#  user_id    :integer
#  photo_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_comments_on_photo_id  (photo_id)
#  index_comments_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_03de2dc08c  (user_id => users.id)
#  fk_rails_8e6de2dbfc  (photo_id => photos.id)
#

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :photo

  validates :text, presence: true, length: { maximum: 140 }
end
