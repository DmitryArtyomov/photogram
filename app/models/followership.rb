# == Schema Information
#
# Table name: followerships
#
#  id          :integer          not null, primary key
#  follower_id :integer
#  followed_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_followerships_on_followed_id                  (followed_id)
#  index_followerships_on_follower_id                  (follower_id)
#  index_followerships_on_follower_id_and_followed_id  (follower_id,followed_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (followed_id => users.id) ON DELETE => cascade
#  fk_rails_...  (follower_id => users.id) ON DELETE => cascade
#

class Followership < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :followed, class_name: 'User', counter_cache: :followers_count

  validate :cannot_follow_self
  validates :follower_id, uniqueness: { scope: :followed_id }

  private
  def cannot_follow_self
    if follower == followed
      errors.add(:followed_id, "can't be equal to follower")
    end
  end
end
