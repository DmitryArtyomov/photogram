# == Schema Information
#
# Table name: albums
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  is_main     :boolean          default(FALSE)
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_albums_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_964016e0e8  (user_id => users.id) ON DELETE => cascade
#

class Album < ApplicationRecord
  include PgSearch

  belongs_to :user

  has_and_belongs_to_many :tags
  has_many :photos, dependent: :destroy

  validates :name, presence: true
  validates :photos, length: { maximum: 50 }

  pg_search_scope :search_by_name, against: :name, using: { tsearch: { prefix: true} }
end
